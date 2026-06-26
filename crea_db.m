
clear; clc;

fileDatabase = 'database/sistema_sanitario.db';

% Se la cartella database non esiste, la crea
if ~exist('database', 'dir')
    mkdir('database');
end

try
    fprintf('Fase 1: Connessione e inizializzazione del Database...\n');
    
    conn = sqlite(fileDatabase, 'create');

    % Crea la tabella Utenti se non esiste
    execute(conn, ['CREATE TABLE IF NOT EXISTS Utenti (' ...
        'ID_Utente INTEGER PRIMARY KEY AUTOINCREMENT, ' ...
        'Username TEXT UNIQUE, ' ...
        'Password TEXT, ' ...
        'Ruolo TEXT)']);

    % Inserisce gli utenti di prova
    try
        execute(conn, "INSERT INTO Utenti (Username, Password, Ruolo) VALUES ('guest', 'guest123', 'Guest')");
        execute(conn, "INSERT INTO Utenti (Username, Password, Ruolo) VALUES ('ricercatore', 'admin123', 'Ricercatore')");
    catch
        % Se esistono già, ignora l'errore
    end

    fprintf('Fase 2: Lettura dei file CSV dalla cartella database...\n');
    tabAnag  = readtable('database/Anagrafica.csv', 'VariableNamingRule', 'preserve');
    tabEpi   = readtable('database/Epidemiologia.csv', 'VariableNamingRule', 'preserve');
    tabDemo  = readtable('database/Demografia.csv', 'VariableNamingRule', 'preserve');
    
    
    if isfile('database/Statistiche_Generali.csv')
        tabStats = readtable('database/Statistiche_Generali.csv', 'VariableNamingRule', 'preserve');
    else
        tabStats = [];
    end

    fprintf('Fase 3: Scrittura strutturata delle tabelle SQL...\n');
    % Scrive la tabella per i costi sanitari
    sqlwrite(conn, 'Malattie', tabAnag);
    
    % Scrive le tabelle per i grafici e le statistiche
    sqlwrite(conn, 'Epidemiologia', tabEpi);
    sqlwrite(conn, 'Demografia', tabDemo);
    
    if ~isempty(tabStats)
        sqlwrite(conn, 'Statistiche_Generali', tabStats);
    end

    
    close(conn);
    
    fprintf('Operazione completata con successo!\n');
    msgbox('Database SQLite creato e aggiornato con successo da tutti i flussi CSV!', 'Database Pronto');
    
catch ME
    errordlg(['Errore durante la gestione del database: ' ME.message], 'Errore');
end