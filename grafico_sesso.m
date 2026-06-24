% GRAFICO PERCENTUALE SESSO 
function grafico_sesso()
    clc; 

    % Carica i dati dal file CSV 
    nomeFile = 'database/Anagrafica.csv';
    if ~exist(nomeFile, 'file')
        errordlg('Errore: Il file database/Anagrafica.csv non esiste!', 'Errore File');
        return;
    end
    
    try
        dfAnagrafica = readtable(nomeFile, 'Delimiter', ',', 'VariableNamingRule', 'preserve');
        if width(dfAnagrafica) < 3
            dfAnagrafica = readtable(nomeFile, 'Delimiter', ';', 'VariableNamingRule', 'preserve');
        end
    catch
        dfAnagrafica = readtable(nomeFile, 'VariableNamingRule', 'preserve');
    end

    
    nomiMalattie = { ...
        'Sclerosi Multipla'; ...
        'Celiachia'; ...
        'Diabete Tipo 1'; ...
        'Tiroidite di Hashimoto'; ...
        'Morbo di Crohn' ...
    };
    
    
    [idx, ok] = listdlg('PromptString', 'Seleziona una malattia per la distinzione Sesso:', ...
                        'SelectionMode', 'single', 'ListString', nomiMalattie, ...
                        'ListSize', [300, 250]);

    if ok
        malattiaSelezionata = nomiMalattie{idx};
        
        stringaCercata = lower(regexprep(malattiaSelezionata, '[_\s]', ''));
        listaMalattieCSV = lower(regexprep(string(dfAnagrafica{:, 1}), '[_\s]', ''));
        
        righeValide = false(height(dfAnagrafica), 1);
        for r = 1:length(listaMalattieCSV)
            if contains(listaMalattieCSV(r), stringaCercata) || contains(stringaCercata, listaMalattieCSV(r))
                righeValide(r) = true;
            end
        end
        
        rigaAnag = dfAnagrafica(righeValide, :);
        
        if isempty(rigaAnag)
            errordlg(['Nessun dato trovato nel CSV per la malattia: ' malattiaSelezionata], 'Errore Dati');
            return;
        end
        
        
        valDonne = double(rigaAnag{1, 3});
        valUomini = double(rigaAnag{1, 4});

        if isnan(valDonne), valDonne = 0; end
        if isnan(valUomini), valUomini = 0; end

        if (valDonne + valUomini) == 0
            msgbox('I valori per questa patologia sono pari a zero o mancanti.', 'Attenzione');
            return;
        end

        
        figure('Name', ['Percentuale Sesso - ' malattiaSelezionata], 'Color', 'w', ...
               'Position', [350, 200, 550, 450], 'MenuBar', 'none', 'ToolBar', 'none');
        
        
        hPie = pie([valDonne, valUomini], {'Donne', 'Uomini'});
        
        
        coloreRosa = [1, 0.6, 0.78];  % Rosa 
        coloreBlu  = [0.2, 0.6, 0.9]; % Blu
        
        
        set(hPie(1), 'FaceColor', coloreRosa, 'EdgeColor', 'w', 'LineWidth', 1); 
        if length(hPie) >= 3
            set(hPie(3), 'FaceColor', coloreBlu, 'EdgeColor', 'w', 'LineWidth', 1);  
        end
        
       
        elementiTesto = findobj(hPie, 'Type', 'text');
        for k = 1:length(elementiTesto)
            set(elementiTesto(k), 'Color', [0 0 0], ...     
                                  'FontSize', 11, ...       
                                  'FontWeight', 'bold');    
        end
        
        title(['Percentuale per Sesso: ' malattiaSelezionata], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
    end
end