% Connessione al Database
conn = sqlite('database/sistema_sanitario.db');

% Query e preparazione dati
query = 'SELECT Nome, Costo_Annuo_Paziente FROM Malattie';
tabella_costi = fetch(conn, query);
tabella_costi.Properties.VariableNames{'Nome'} = 'Malattia';
tabella_costi.Properties.VariableNames{'Costo_Annuo_Paziente'} = 'Costo';

% Creazione del Grafico 
fig = figure('Name', 'Analisi Proporzionale', 'Color', [0 0 0]); 
ax = axes('Parent', fig, 'Color', [0 0 0]);                      


b = bar(tabella_costi.Costo, 0.4, 'FaceAlpha', 0.95);

% COLORE 
b.FaceColor = [0.00 0.65 0.68]; 
b.EdgeColor = [0.00, 0.50, 0.55]; 
b.LineWidth = 1.5;

% PROPORZIONALITÀ
max_costo = max(tabella_costi.Costo);
ylim([0, max_costo * 1.4]); 


xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(tabella_costi.Costo) + " €";


text(xtips, ytips, labels, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0.00 0.85 0.90]); 

% ASSI
ax.FontSize = 11;
ax.FontWeight = 'bold'; 
ax.XColor = [1 1 1];    
ax.YColor = [1 1 1];    

ax.XTickLabel = tabella_costi.Malattia;
xtickangle(45);

ylabel('Spesa per Paziente (€)', 'FontSize', 11, 'FontWeight', 'bold', 'Color', [1 1 1]);
title('Distribuzione Economica SSN - Focus Malattie Croniche', 'FontSize', 14, ...
      'FontWeight', 'bold', 'Color', [0.00 0.65 0.68]); 

% Griglia 
grid on;
ax.GridColor = [0.3 0.3 0.3];
ax.GridAlpha = 0.4;
box off;

close(conn);