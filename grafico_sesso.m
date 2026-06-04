% GRAFICO PERCENTUALE SESSO 
clear; clc; close all;

% 1. Carica i dati
nomeFile = 'Foglio dati progetto Chiara e Ludo.xlsx';
dfAnagrafica = readtable(nomeFile, 'Sheet', 'Anagrafica', 'VariableNamingRule', 'preserve');

% Chiede l'input all'utente
nomiMalattie = unique(dfAnagrafica.Nome);
[idx, ok] = listdlg('PromptString', 'Seleziona una malattia per la distinzione Sesso:', ...
                    'SelectionMode', 'single', 'ListString', nomiMalattie);

if ok
    malattiaAttiva = nomiMalattie{idx};
    rigaAnag = dfAnagrafica(strcmpi(dfAnagrafica.Nome, malattiaAttiva), :);
    
    
    figure('Name', ['Percentuale Sesso - ' malattiaAttiva], 'Color', 'w', 'Position', [350, 200, 550, 450]);
    
    % Creiamo il grafico a torta
    pressioneTorta = pie([rigaAnag.Percentuale_Donne(1), rigaAnag.Percentuale_Uomini(1)], {'Donne', 'Uomini'});
    
    % COLORI DEGLI SPICCHI (Rosa per Donne, Blu per Uomini)
   
    fette = findobj(pressioneTorta, 'Type', 'patch');
    
    % Definiamo i colori personalizzati in formato RGB (valori da 0 a 1)
    coloreRosa = [1, 0.6, 0.78];  % Rosa
    coloreBlu  = [0.2, 0.6, 0.9]; % Blu
    
    % MATLAB inserisce gli elementi nel vettore in ordine inverso rispetto alla creazione
    if length(fette) == 2
        set(fette(2), 'FaceColor', coloreBlu);  % Seconda fetta (Uomini)
        set(fette(1), 'FaceColor', coloreRosa); % Prima fetta (Donne)
    end
    
    
    elementiTesto = findobj(pressioneTorta, 'Type', 'text');
    for k = 1:length(elementiTesto)
        set(elementiTesto(k), 'Color', [0 0 0], ...     
                              'FontSize', 11, ...       
                              'FontWeight', 'bold');   
    end
    
    title(['Percentuale per Sesso: ' malattiaAttiva], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
end