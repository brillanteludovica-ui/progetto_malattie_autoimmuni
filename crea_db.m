% 1. Connessione (Creazione del file da zero)
if ~exist('database', 'dir')
    mkdir('database');
end
% Usiamo 'create' per sicurezza
conn = sqlite('database/sistema_sanitario.db', 'create');

% 2. CREAZIONE TABELLA UTENTI (L'unica che creiamo a mano perché non è nell'Excel)
execute(conn, ['CREATE TABLE IF NOT EXISTS Utenti (' ...
    'ID_Utente INTEGER PRIMARY KEY AUTOINCREMENT, ' ...
    'Username TEXT UNIQUE, ' ...
    'Password TEXT, ' ...
    'Ruolo TEXT)']);

% 3. Inserimento Utenti di Prova
try
    execute(conn, "INSERT INTO Utenti (Username, Password, Ruolo) VALUES ('guest', 'guest123', 'Guest')");
    execute(conn, "INSERT INTO Utenti (Username, Password, Ruolo) VALUES ('ricercatore', 'admin123', 'Ricercatore')");
catch
    % Se esistono già, non fa nulla
end

% 4. IMPORTAZIONE AUTOMATICA DALL'EXCEL (Qui MATLAB crea le tabelle da solo)
% Assicuratevi che il nome del file Excel sia identico!
nomeExcel = 'database/Foglio dati progetto Chiara e Ludo.xlsx';

% Importa Anagrafica -> Tabella Malattie
opts1 = detectImportOptions(nomeExcel, 'Sheet', 'Anagrafica');
sqlwrite(conn, 'Malattie', readtable(nomeExcel, opts1));

% Importa Statistiche_Generali -> Tabella Statistiche_Storiche
opts2 = detectImportOptions(nomeExcel, 'Sheet', 'Statistiche_Generali');
sqlwrite(conn, 'Statistiche_Storiche', readtable(nomeExcel, opts2));

% Importa Epidemiologia -> Tabella Dati_Epidemiologici
opts3 = detectImportOptions(nomeExcel, 'Sheet', 'Epidemiologia');
sqlwrite(conn, 'Dati_Epidemiologici', readtable(nomeExcel, opts3));

% Importa Demografia -> Tabella Demografia
opts4 = detectImportOptions(nomeExcel, 'Sheet', 'Demografia');
sqlwrite(conn, 'Demografia', readtable(nomeExcel, opts4));

% 5. Messaggio finale e chiusura
disp('Database creato con successo con tutti i 4 fogli e la tabella Utenti!');
close(conn);