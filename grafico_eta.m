% GRAFICO FASCIA ETA
function grafico_eta()
    clc; 
    
    dfDemo = readtable('database/Demografia.csv', 'VariableNamingRule', 'preserve');

    
    if ~iscellstr(dfDemo.Nome_Malattia)
        try
            dfDemo.Nome_Malattia = cellstr(dfDemo.Nome_Malattia);
        catch
            dfDemo.Nome_Malattia = cellstr(string(dfDemo.Nome_Malattia));
        end
    end

    
    nomiMalattie = unique(dfDemo.Nome_Malattia);
    [idx, ok] = listdlg('PromptString', 'Seleziona una malattia per le Fasce d''Età:', ...
                        'SelectionMode', 'single', 'ListString', nomiMalattie);

    if ok && ~isempty(idx)
        malattiaAttiva = nomiMalattie{idx};
        datiFiltrati = dfDemo(strcmpi(dfDemo.Nome_Malattia, malattiaAttiva), :);

        
        if isnumeric(datiFiltrati.Numero_Casi)
            counts = datiFiltrati.Numero_Casi(:);
        else
            counts = str2double(string(datiFiltrati.Numero_Casi));
        end
        counts(isnan(counts)) = 0;

        
        fasce = cellstr(datiFiltrati.Fascia_Eta);
        total = sum(counts);
        if total == 0
            warndlg('Nessun caso disponibile per la malattia selezionata.', 'Avviso');
            return;
        end
        pct = 100 * counts / total;
        labelsWithPct = arrayfun(@(i) sprintf('%s (%d — %.1f%%)', fasce{i}, counts(i), pct(i)), (1:numel(counts))', 'UniformOutput', false);

        fig = figure('Name', ['Fasce d''Età - ' malattiaAttiva], 'Color', 'w', ...
                     'Position', [300, 200, 650, 450], 'MenuBar', 'none', 'ToolBar', 'none');

        
        h = pie(counts, labelsWithPct);

        
        fette = findobj(h, 'Type', 'patch');
        coloreVerde     = [0.00, 0.75, 0.20]; 
        coloreArancione = [0.95, 0.65, 0.00]; 
        coloreRosso     = [0.75, 0.20, 0.20]; 
        
        
        if length(fette) == 3
            set(fette(3), 'FaceColor', coloreVerde, 'EdgeColor', 'w', 'LineWidth', 1);
            set(fette(2), 'FaceColor', coloreArancione, 'EdgeColor', 'w', 'LineWidth', 1);
            set(fette(1), 'FaceColor', coloreRosso, 'EdgeColor', 'w', 'LineWidth', 1);
        end

        
        txt = findobj(h, 'Type', 'text');
        for k = 1:numel(txt)
            set(txt(k), 'Color', [0 0 0], 'FontSize', 11, 'FontWeight', 'bold');
        end

        title(['Distribuzione per Fasce d''Età: ' malattiaAttiva], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
    end
end