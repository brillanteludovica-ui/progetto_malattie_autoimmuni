% GRAFICO PREVISIONE E TENDENZA 
function grafico_previsione()
   clc; 
    % Carica i dati dal database
    dfEpi = readtable('database/Epidemiologia.csv', 'VariableNamingRule', 'preserve');

    
    nomiMalattie = cellstr(sort(unique(dfEpi.Nome_Malattia)));
    anniStorici = sort(unique(dfEpi.Anno));
    anniStorici = anniStorici(:); 
    startAnno = min(anniStorici);
    anniFuturi = (startAnno:2028)';

    % Interfaccia grafica 
    figPrev = figure('Name', 'Previsione e Linee di Tendenza', 'Color', 'w', 'Position', [200, 150, 950, 580]);
    elencoOpzioni = [nomiMalattie; {'Tutte Insieme'}];

    uicontrol('Parent', figPrev, 'Style', 'text', 'String', 'Seleziona Malattia:', ...
        'Position', [40, 520, 120, 20], 'BackgroundColor', 'w', 'FontWeight', 'bold', 'ForegroundColor', [0 0 0]);
    popPrev = uicontrol('Parent', figPrev, 'Style', 'popupmenu', 'String', elencoOpzioni, 'Value', length(elencoOpzioni), ...
        'Position', [165, 522, 200, 20], 'FontSize', 10, 'Callback', @aggiornaPrevisione);

    axPrev = axes('Parent', figPrev, 'Position', [0.08, 0.16, 0.82, 0.65], 'Box', 'off', 'Color', 'w');
    
    aggiornaPrevisione();

    function aggiornaPrevisione(~, ~)
        cla(axPrev); hold(axPrev, 'on');
        scelta = popPrev.Value;
        
        set(axPrev, 'YGrid', 'on', 'XGrid', 'off', 'GridColor', [0.85 0.85 0.85], 'GridAlpha', 0.6);
        
        if scelta <= length(nomiMalattie)
             
            nomeSelezionato = nomiMalattie{scelta};
            coloreFisso = ottieniColoreMalattia(nomeSelezionato, nomiMalattie);
            tracciaMalattia(nomeSelezionato, coloreFisso, true);
        else
             
            vettoreGraficiReali = gobjects(1, length(nomiMalattie));
            for idx = 1:length(nomiMalattie)
                coloreCorrente = ottieniColoreMalattia(nomiMalattie{idx}, nomiMalattie);
                hPlot = tracciaMalattia(nomiMalattie{idx}, coloreCorrente, false);
                vettoreGraficiReali(idx) = hPlot;
            end
            
                 legend(axPrev, vettoreGraficiReali, nomiMalattie, 'Location', 'northeastoutside', ...
                     'TextColor', [0 0 0], 'FontWeight', 'bold', 'EdgeColor', 'none', 'Color', 'w');
        end
        
        set(axPrev, 'XColor', [0 0 0], 'YColor', [0 0 0], ...
                'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Helvetica');
        xticks(axPrev, anniFuturi');
        
        xlabel(axPrev, 'Asse Temporale (Anni)', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0 0 0]);
        ylabel(axPrev, 'Indice di Crescita dei Casi (Base 2018 = 100%)', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0 0 0]);
        
        title(axPrev, 'Modello Predittivo: Confronto Dinamico e Linee di Tendenza (Fino al 2028)', ...
              'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0], 'FontName', 'Helvetica');
    end

    function hStorico = tracciaMalattia(nomeMal, colore, mostraTrend)
        totaliAnno = zeros(length(anniStorici), 1);
        for t = 1:length(anniStorici)
            righe = strcmpi(string(dfEpi.Nome_Malattia), string(nomeMal)) & dfEpi.Anno == anniStorici(t);
            if any(righe)
                totaliAnno(t) = sum(double(dfEpi.Casi_Totali(righe)), 'omitnan');
            else
                totaliAnno(t) = NaN;
            end
        end
        
        
        valoreIniziale2018 = totaliAnno(1);
        if valoreIniziale2018 == 0, valoreIniziale2018 = 1; end 
        andamentoIndicizzato = (totaliAnno / valoreIniziale2018) * 100;
        
        
        hStorico = plot(axPrev, anniStorici, andamentoIndicizzato, 'o-', 'LineWidth', 2.8, 'Color', colore, ...
             'MarkerFaceColor', 'w', 'MarkerSize', 7);
        
        
        validIdx = ~isnan(andamentoIndicizzato);
        if sum(validIdx) >= 2
            p = polyfit(anniStorici(validIdx), andamentoIndicizzato(validIdx), 1);
            valoriTrend = polyval(p, anniFuturi);
        else
            valoriTrend = nan(size(anniFuturi));
        end
        
        if mostraTrend
            
            plot(axPrev, anniFuturi, valoriTrend, '--', 'LineWidth', 1.8, 'Color', max(min(colore * 0.6,1),0));
            legend(axPrev, {['Storico Indicizzato (' nomeMal ')'], 'Modello di Tendenza Futura'}, ...
                   'Location', 'northeast', 'TextColor', [0 0 0], 'FontWeight', 'bold', 'EdgeColor', 'none', 'Color', 'w');
            xlim(axPrev, [anniFuturi(1)-0.5, anniFuturi(end)+0.5]);
        else
            
            idxPlot = max(1, length(anniFuturi)-3):length(anniFuturi);
            plot(axPrev, anniFuturi(idxPlot), valoriTrend(idxPlot), ':', 'LineWidth', 2.2, 'Color', colore);
            xlim(axPrev, [anniStorici(1)-0.5, anniStorici(end)+0.5]);
        end
    end

    
    function cout = ottieniColoreMalattia(nomeMal, listaMalattie)
        mappaColoriMiei = [
            1.00, 0.00, 0.00;  % 1. Rosso Fuoco
            0.00, 0.45, 1.00;  % 2. Blu Elettrico
            0.00, 0.75, 0.20;  % 3. Verde 
            0.90, 0.00, 0.60;  % 4. Magenta / Fucsia 
            0.95, 0.65, 0.00;  % 5. Giallo Oro / Arancione
            0.50, 0.00, 0.90   % 6. Viola 
        ];
        
        idFisso = find(strcmpi(listaMalattie, nomeMal));
        if isempty(idFisso), idFisso = 1; end
        
        cout = mappaColoriMiei(mod(idFisso-1, size(mappaColoriMiei, 1)) + 1, :);
    end
end