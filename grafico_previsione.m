% GRAFICO PREVISIONE E TENDENZA - VERSIONE INDICIZZATA (BASE 2018) ED ELEGANTE
function grafico_previsione()
    clear; clc; close all;

    % 1. Carica i dati dal database
    nomeFile = 'Foglio dati progetto Chiara e Ludo.xlsx';
    dfEpidemio = readtable(nomeFile, 'Sheet', 'Epidemiologia', 'VariableNamingRule', 'preserve');

    nomiMalattie = unique(dfEpidemio.Nome_Malattia);
    anniStorici = unique(dfEpidemio.Anno)';
    anniFuturi = anniStorici(1):2028; 

    % 2. Interfaccia grafica (Sfondo bianco puro)
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
            % --- SINGOLA MALATTIA (Mantiene il suo colore fisso!) ---
            nomeSelezionato = nomiMalattie{scelta};
            coloreFisso = ottieniColoreMalattia(nomeSelezionato, nomiMalattie);
            tracciaMalattia(nomeSelezionato, coloreFisso, true);
        else
            % --- TUTTE INSIEME (Partono tutte da 100 nel 2018) ---
            vettoreGraficiReali = []; % Serve per ripulire la legenda dai tratti predittivi
            for idx = 1:length(nomiMalattie)
                coloreCorrente = ottieniColoreMalattia(nomiMalattie{idx}, nomiMalattie);
                hPlot = tracciaMalattia(nomiMalattie{idx}, coloreCorrente, false);
                vettoreGraficiReali = [vettoreGraficiReali, hPlot];
            end
            % Mostra in legenda solo le linee storiche reali, eliminando i doppioni dei tratteggi futuri
            legend(axPrev, vettoreGraficiReali, nomiMalattie, 'Location', 'northeastoutside', ...
                   'TextColor', [0 0 0], 'FontWeight', 'bold', 'EdgeColor', 'none', 'Color', 'w');
        end
        
        set(axPrev, 'XColor', [0 0 0], 'YColor', [0 0 0], ...
                    'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Helvetica', ...
                    'XTick', anniFuturi);
        
        xlabel(axPrev, 'Asse Temporale (Anni)', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0 0 0]);
        ylabel(axPrev, 'Indice di Crescita dei Casi (Base 2018 = 100%)', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0 0 0]);
        
        title(axPrev, 'Modello Predittivo: Confronto Dinamico e Linee di Tendenza (Fino al 2028)', ...
              'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0], 'FontName', 'Helvetica');
    end

    function hStorico = tracciaMalattia(nomeMal, colore, mostraTrend)
        totaliAnno = zeros(length(anniStorici), 1);
        for t = 1:length(anniStorici)
            righe = strcmpi(string(dfEpidemio.Nome_Malattia), string(nomeMal)) & dfEpidemio.Anno == anniStorici(t);
            totaliAnno(t) = sum(double(dfEpidemio.Casi_Totali(righe)), 'omitnan');
        end
        
        % TRASFORMAZIONE IN INDICE PERCENTUALE (Fascia di partenza comune a 100)
        valoreIniziale2018 = totaliAnno(1);
        if valoreIniziale2018 == 0, valoreIniziale2018 = 1; end % Evita divisioni per zero
        andamentoIndicizzato = (totaliAnno / valoreIniziale2018) * 100;
        
        % 1. Disegna i dati storici reali indicizzati
        hStorico = plot(axPrev, anniStorici, andamentoIndicizzato, 'o-', 'LineWidth', 2.8, 'Color', colore, ...
             'MarkerFaceColor', 'w', 'MarkerSize', 7);
        
        % 2. Calcolo predittivo basato sull'indice di crescita
        p = polyfit(anniStorici', andamentoIndicizzato, 1); 
        valoriTrend = polyval(p, anniFuturi);
        
        if mostraTrend
            % Se singola mostra il trend futuro continuo proiettato
            plot(axPrev, anniFuturi, valoriTrend, '--', 'LineWidth', 1.8, 'Color', colore * 0.6);
            legend(axPrev, {['Storico Indicizzato (' nomeMal ')'], 'Modello di Tendenza Futura'}, ...
                   'Location', 'northeast', 'TextColor', [0 0 0], 'FontWeight', 'bold', 'EdgeColor', 'none', 'Color', 'w');
            xlim(axPrev, [anniFuturi(1)-0.5, anniFuturi(end)+0.5]);
        else
            % Se sono tutte insieme, prolunga con i punti fini
            plot(axPrev, anniFuturi(end-3:end), valoriTrend(end-3:end), ':', 'LineWidth', 2.2, 'Color', colore);
            xlim(axPrev, [anniStorici(1)-0.5, anniStorici(end)+0.5]);
        end
    end

    %% FUNZIONE INTERNA PER ASSOCIARE UN COLORE UNIVOCO FISSO AD OGNI MALATTIA
    function cout = ottieniColoreMalattia(nomeMal, listaMalattie)
        mappaColoriMiei = [
            1.00, 0.00, 0.00;  % 1. Rosso Fuoco
            0.00, 0.45, 1.00;  % 2. Blu Elettrico
            0.00, 0.75, 0.20;  % 3. Verde Brillante
            0.90, 0.00, 0.60;  % 4. Magenta / Fucsia Carico
            0.95, 0.65, 0.00;  % 5. Giallo Oro / Arancione
            0.50, 0.00, 0.90   % 6. Viola Neon
        ];
        % Trova la posizione fissa della malattia nell'elenco alfabetico Excel
        idFisso = find(strcmpi(listaMalattie, nomeMal));
        if isempty(idFisso), idFisso = 1; end
        % Estrae il colore corrispondente
        cout = mappaColoriMiei(mod(idFisso-1, size(mappaColoriMiei, 1)) + 1, :);
    end
end