% GRAFICO CONFRONTO 2 MALATTIE 
function grafico_confronto()
     clc; 

    % Carica i dati dal database
    dfEpidemio = readtable('database/Epidemiologia.csv', 'VariableNamingRule', 'preserve');

    
    nomiMalattie = unique(cellstr(string(dfEpidemio.Nome_Malattia)));
    anniDisponibili = unique(dfEpidemio.Anno);

     
    figConf = figure('Name', 'Confronto Avanzato Malattie', 'Color', 'w', 'Position', [200, 150, 950, 580]);

     
    coloreTestoMenu = [0 0 0];
    
    uicontrol('Parent', figConf, 'Style', 'text', 'String', 'Malattia 1:', ...
        'Position', [40, 520, 70, 20], 'BackgroundColor', 'w', 'FontWeight', 'bold', 'ForegroundColor', coloreTestoMenu);
    popM1 = uicontrol('Parent', figConf, 'Style', 'popupmenu', 'String', nomiMalattie, 'Value', 1, ...
        'Position', [115, 522, 140, 20], 'FontSize', 10, 'Callback', @aggiornaPlot);

    uicontrol('Parent', figConf, 'Style', 'text', 'String', 'Malattia 2:', ...
        'Position', [280, 520, 70, 20], 'BackgroundColor', 'w', 'FontWeight', 'bold', 'ForegroundColor', coloreTestoMenu);
    popM2 = uicontrol('Parent', figConf, 'Style', 'popupmenu', 'String', nomiMalattie, 'Value', min(2, length(nomiMalattie)), ...
        'Position', [355, 522, 140, 20], 'FontSize', 10, 'Callback', @aggiornaPlot);

    uicontrol('Parent', figConf, 'Style', 'text', 'String', 'Anno:', ...
        'Position', [520, 520, 40, 20], 'BackgroundColor', 'w', 'FontWeight', 'bold', 'ForegroundColor', coloreTestoMenu);
    popAnno = uicontrol('Parent', figConf, 'Style', 'popupmenu', 'String', cellstr(string(anniDisponibili)), ...
        'Position', [565, 522, 80, 20], 'FontSize', 10, 'Callback', @aggiornaPlot);

    uicontrol('Parent', figConf, 'Style', 'text', 'String', 'Parametro:', ...
        'Position', [670, 520, 70, 20], 'BackgroundColor', 'w', 'FontWeight', 'bold', 'ForegroundColor', coloreTestoMenu);
    popParam = uicontrol('Parent', figConf, 'Style', 'popupmenu', 'String', {'Sintomatici', 'Gravita_Media', 'Tasso_Mortalita'}, ...
        'Position', [745, 522, 140, 20], 'FontSize', 10, 'Callback', @aggiornaPlot);

     
    axConf = axes('Parent', figConf, 'Position', [0.08, 0.16, 0.88, 0.65], 'Box', 'off', 'Color', 'w');
    
    eseguiDisegno(axConf);
    
    function aggiornaPlot(~, ~)
        eseguiDisegno(axConf);
    end

    function eseguiDisegno(targetAx)
        cla(targetAx);
        m1 = nomiMalattie{popM1.Value}; m2 = nomiMalattie{popM2.Value};
        annoAttivo = anniDisponibili(popAnno.Value);
        parametro = popParam.String{popParam.Value};
        
        datiM1 = dfEpidemio(strcmpi(cellstr(string(dfEpidemio.Nome_Malattia)), m1) & dfEpidemio.Anno == annoAttivo, :);
        datiM2 = dfEpidemio(strcmpi(cellstr(string(dfEpidemio.Nome_Malattia)), m2) & dfEpidemio.Anno == annoAttivo, :);
        
        regioniUniche = unique(cellstr(string(dfEpidemio.Regione)));
        y1 = zeros(length(regioniUniche), 1); y2 = zeros(length(regioniUniche), 1);
        
        for k = 1:length(regioniUniche)
            r1 = datiM1(strcmpi(cellstr(string(datiM1.Regione)), regioniUniche{k}), :);
            if ~isempty(r1), y1(k) = convertiInNumero(r1.(parametro)(1)); end
            
            r2 = datiM2(strcmpi(cellstr(string(datiM2.Regione)), regioniUniche{k}), :);
            if ~isempty(r2), y2(k) = convertiInNumero(r2.(parametro)(1)); end
        end
        
        
        b = bar(targetAx, [y1, y2], 0.7, 'EdgeColor', [0.85 0.85 0.85], 'LineWidth', 0.5);
        
        
        b(1).FaceColor = ottieniColoreFissoMalattia(m1, nomiMalattie); 
        b(2).FaceColor = ottieniColoreFissoMalattia(m2, nomiMalattie); 
        
        
        maxValore = max([y1; y2]);
        if maxValore > 0
            ylim(targetAx, [0, maxValore * 1.15]); 
        else
            ylim(targetAx, [0, 1]);
        end
        
        
        set(targetAx, 'YGrid', 'on', 'XGrid', 'off', 'GridColor', [0.85 0.85 0.85], 'GridAlpha', 0.6);
        
        
        set(targetAx, 'XTick', 1:length(regioniUniche), 'XTickLabel', regioniUniche, ...
                      'XColor', [0 0 0], 'YColor', [0 0 0], ...
                      'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Helvetica');
        xtickangle(targetAx, 30); 
        
        nomeAsseY = strrep(parametro, '_', ' ');
        ylabel(targetAx, nomeAsseY, 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0 0 0]);
        
         
        legend(targetAx, {m1, m2}, 'Location', 'northeast', 'TextColor', [0 0 0], 'FontWeight', 'bold', 'EdgeColor', 'none', 'Color', 'w');
        title(targetAx, ['Analisi Comparativa Regionale: ' nomeAsseY ' (' num2str(annoAttivo) ')'], ...
          'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0], 'FontName', 'Helvetica');
    end

    function numUscita = convertiInNumero(valore)
        if isnumeric(valore)
            numUscita = double(valore);
        else
            strPulita = string(valore);
            strPulita = strrep(strPulita, ',', '.');
            numUscita = str2double(strPulita);
        end
        if isnan(numUscita), numUscita = 0; end
    end

    
    function cout = ottieniColoreFissoMalattia(nomeMal, listaMalattie)
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