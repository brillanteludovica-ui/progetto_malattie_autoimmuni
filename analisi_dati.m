% 1. Connessione al Database
conn = sqlite('database/sistema_sanitario.db');

% 2. Query SQL per estrarre Malattie e Costi
query = 'SELECT Nome, Costo_Annuo_Paziente FROM Malattie';
tabella_costi = fetch(conn, query);

% CONTROLLO ACCOPPIAMENTO NOMI COLONNE
% Dato che fetch restituisce già una tabella, rinominiamo le colonne 
% per far funzionare i comandi del grafico successivi
tabella_costi.Properties.VariableNames{'Nome'} = 'Malattia';
tabella_costi.Properties.VariableNames{'Costo_Annuo_Paziente'} = 'Costo';

% 3. Creazione del Grafico a Barre
figure('Name', 'Analisi Economica Malattie', 'NumberTitle', 'off');
bar(tabella_costi.Costo, 'FaceColor', [0.2 0.6 0.8]); % Un bel colore azzurro

% Personalizzazione degli assi
set(gca, 'XTick', 1:height(tabella_costi), 'XTickLabel', tabella_costi.Malattia);
xtickangle(45); % Ruota i nomi delle malattie per leggerli meglio
ylabel('Costo Annuo per Paziente (€)');
title('Confronto dei Costi Sostenuti dal Sistema Sanitario');
grid on; % Aggiunge la griglia di sfondo

% 4. Chiusura della connessione
close(conn);