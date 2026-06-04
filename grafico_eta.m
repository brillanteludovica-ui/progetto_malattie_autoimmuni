% GRAFICO FASCIA ETA 
clear; clc; close all;

% Carica i dati
nomeFile = 'Foglio dati progetto Chiara e Ludo.xlsx';
dfDemo = readtable(nomeFile, 'Sheet', 'Demografia', 'VariableNamingRule', 'preserve');

% Prende le malattie disponibili e chiede all'utente quale mostrare
nomiMalattie = unique(dfDemo.Nome_Malattia);
[idx, ok] = listdlg('PromptString', 'Seleziona una malattia per le Fasce d''Età:', ...
                    'SelectionMode', 'single', 'ListString', nomiMalattie);

if ok
    malattiaAttiva = nomiMalattie{idx};
    datiFiltrati = dfDemo(strcmpi(dfDemo.Nome_Malattia, malattiaAttiva), :);
    

    fig = figure('Name', ['Fasce d''Età - ' malattiaAttiva], 'Color', 'w', 'Position', [300, 200, 550, 450]);
    
    % Crea il grafico a torta e salva i puntatori agli elementi generati
    pressioneTorta = pie(datiFiltrati.Numero_Casi, cellstr(datiFiltrati.Fascia_Eta));
    
  
    elementiTesto = findobj(pressioneTorta, 'Type', 'text');
    for k = 1:length(elementiTesto)
        set(elementiTesto(k), 'Color', [0 0 0], ...     
                              'FontSize', 11, ...       
                              'FontWeight', 'bold');     
    end
    
    title(['Distribuzione per Fasce d''Età: ' malattiaAttiva], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
end