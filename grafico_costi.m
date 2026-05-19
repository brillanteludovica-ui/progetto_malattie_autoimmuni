% 1. Connessione al Database
conn = sqlite('database/sistema_sanitario.db');

% 2. Query e preparazione dati
query = 'SELECT Nome, Costo_Annuo_Paziente FROM Malattie';
tabella_costi = fetch(conn, query);
tabella_costi.Properties.VariableNames{'Nome'} = 'Malattia';
tabella_costi.Properties.VariableNames{'Costo_Annuo_Paziente'} = 'Costo';

% 3. Creazione del Grafico Estetico Rosa
fig = figure('Name', 'Analisi Proporzionale', 'Color', [1 1 1]);
ax = axes('Parent', fig);

% 'BarWidth', 0.4 rende le barre molto più sottili e meno "squadrate"
b = bar(tabella_costi.Costo, 0.4, 'FaceAlpha', 0.8);

% Colore ROSA (RGB: 1, 0.7, 0.8 è un rosa pastello molto bello)
b.FaceColor = [1, 0.7, 0.8]; 
b.EdgeColor = [0.8, 0.5, 0.6]; % Un bordo rosa leggermente più scuro
b.LineWidth = 1.2;

% --- PROPORZIONALITÀ ---
% Calcoliamo il massimo e aggiungiamo il 40% di spazio vuoto sopra
max_costo = max(tabella_costi.Costo);
ylim([0, max_costo * 1.4]); 

% Etichette sopra le barre (per far capire il valore anche se sembrano piccole)
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(tabella_costi.Costo) + " €";
text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', 'FontSize', 10, 'Color', [0.5 0.2 0.3]);

% --- STILE ASSI ---
ax.FontSize = 11;
ax.XTickLabel = tabella_costi.Malattia;
xtickangle(45);
ylabel('Spesa per Paziente (€)');
title('Distribuzione Economica SSN - Focus Malattie Croniche', 'FontSize', 14, 'Color', [0.4 0.1 0.2]);
grid on;
ax.GridAlpha = 0.1;
box off;

close(conn);
