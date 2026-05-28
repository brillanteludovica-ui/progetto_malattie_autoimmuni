% GRAFICO FASCIA ETA - AUTONOMO (VERSIONE TESTO SCURO)
clear; clc; close all;

% 1. Carica i dati
nomeFile = 'Foglio dati progetto Chiara e Ludo.xlsx';
dfDemo = readtable(nomeFile, 'Sheet', 'Demografia', 'VariableNamingRule', 'preserve');

% 2. Prende le malattie disponibili e chiede all'utente quale mostrare
nomiMalattie = unique(dfDemo.Nome_Malattia);
[idx, ok] = listdlg('PromptString', 'Seleziona una malattia per le Fasce d''Età:', ...
                    'SelectionMode', 'single', 'ListString', nomiMalattie);

if ok
    malattiaAttiva = nomiMalattie{idx};
    datiFiltrati = dfDemo(strcmpi(dfDemo.Nome_Malattia, malattiaAttiva), :);
    
    % 3. Genera la figura
    fig = figure('Name', ['Fasce d''Età - ' malattiaAttiva], 'Color', 'w', 'Position', [300, 200, 550, 450]);
    
    % Creiamo il grafico a torta e salviamo i puntatori agli elementi generati
    pressioneTorta = pie(datiFiltrati.Numero_Casi, cellstr(datiFiltrati.Fascia_Eta));
    
    % 4. CICLO PER SCURIRE IL TESTO (Risolve il problema del grigio chiaro)
    % In MATLAB, gli elementi di testo nella torta sono gli oggetti di tipo 'Text'
    elementiTesto = findobj(pressioneTorta, 'Type', 'text');
    for k = 1:length(elementiTesto)
        set(elementiTesto(k), 'Color', [0 0 0], ...     % Nero puro anziché grigio
                              'FontSize', 11, ...       % Leggermente più grande
                              'FontWeight', 'bold');    % Grassetto per massima leggibilità
    end
    
    title(['Distribuzione per Fasce d''Età: ' malattiaAttiva], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
end