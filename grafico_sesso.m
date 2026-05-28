% GRAFICO PERCENTUALE SESSO - AUTONOMO (VERSIONE COLORI PERSONALIZZATI E TESTO SCURO)
clear; clc; close all;

% 1. Carica i dati
nomeFile = 'Foglio dati progetto Chiara e Ludo.xlsx';
dfAnagrafica = readtable(nomeFile, 'Sheet', 'Anagrafica', 'VariableNamingRule', 'preserve');

% 2. Chiede l'input all'utente
nomiMalattie = unique(dfAnagrafica.Nome);
[idx, ok] = listdlg('PromptString', 'Seleziona una malattia per la distinzione Sesso:', ...
                    'SelectionMode', 'single', 'ListString', nomiMalattie);

if ok
    malattiaAttiva = nomiMalattie{idx};
    rigaAnag = dfAnagrafica(strcmpi(dfAnagrafica.Nome, malattiaAttiva), :);
    
    % 3. Genera la figura
    figure('Name', ['Percentuale Sesso - ' malattiaAttiva], 'Color', 'w', 'Position', [350, 200, 550, 450]);
    
    % Creiamo il grafico a torta
    pressioneTorta = pie([rigaAnag.Percentuale_Donne(1), rigaAnag.Percentuale_Uomini(1)], {'Donne', 'Uomini'});
    
    % 4. CAMBIO COLORI DEGLI SPICCHI (Rosa per Donne, Blu per Uomini)
    % Troviamo tutte le fette della torta (oggetti di tipo 'patch')
    fette = findobj(pressioneTorta, 'Type', 'patch');
    
    % Definiamo i colori personalizzati in formato RGB (valori da 0 a 1)
    coloreRosa = [1, 0.6, 0.78];  % Rosa confetto delicato
    coloreBlu  = [0.2, 0.6, 0.9]; % Blu/Azzurro moderno
    
    % MATLAB inserisce gli elementi nel vettore in ordine inverso rispetto alla creazione
    if length(fette) == 2
        set(fette(2), 'FaceColor', coloreBlu);  % Seconda fetta (Uomini)
        set(fette(1), 'FaceColor', coloreRosa); % Prima fetta (Donne)
    end
    
    % 5. APPLICAZIONE TESTO SCURO E GRASSETTO
    elementiTesto = findobj(pressioneTorta, 'Type', 'text');
    for k = 1:length(elementiTesto)
        set(elementiTesto(k), 'Color', [0 0 0], ...     % Nero puro
                              'FontSize', 11, ...       % Dimensione leggibile
                              'FontWeight', 'bold');    % Testo in grassetto
    end
    
    title(['Percentuale per Sesso: ' malattiaAttiva], 'FontSize', 13, 'FontWeight', 'bold', 'Color', [0 0 0]);
end