# progetto_malattie_autoimmuni

    SISTEMA EPIDEMIOLOGICO NAZIONALE: PATOLOGIE CRONICHE AUTOIMMUNI

Sviluppato da: Brillante Ludovica e Di Dio Chiara
Ambiente di sviluppo: MATLAB R2025b / R2026 + Visual studio Code
Database: SQLite 3 e Flussi Strutturati CSV
------------------------------------------------------------------------

1. INTRODUZIONE E OBIETTIVI DEL PROGETTO
Il presente progetto consiste nella progettazione e nello 
sviluppo di un sistema software integrato in ambiente MATLAB per la 
gestione, il monitoraggio e l'analisi statistico-epidemiologica delle 
principali patologie autoimmuni sul territorio nazionale.

L'applicazione modella un'architettura dati a due livelli 
(flussi di input CSV e database relazionale SQL) e fornisce
 un'interfaccia grafica (GUI) dinamica con accessi profilati 
tramite credenziali gestite internamente nel database.


2. ARCHITETTURA E PROGETTAZIONE DEL DATABASE
Il sistema è stato strutturato seguendo le fasi classiche della 
progettazione delle basi di dati:

A. Progettazione Concettuale (Modello ER):
   Modellazione a stella incentrata sull'entità principale "MALATTIE". Le 
   tabelle "EPIDEMIOLOGIA", "DEMOGRAFIA" e "STATISTICHE_GENERALI" 
   sono collegate con relazione logica 1:N tramite Chiave Esterna 
   (Foreign Key) basata sul nome della patologia.

B. Traduzione nel Modello Relazionale (Modello Logico):
   L'entità "UTENTI" presentava inizialmente una generalizzazione nei 
   profili "Guest" e "Ricercatore". In fase di traduzione logica, per 
   poter implementare i dati in SQL, è stato applicato il criterio di 
   "Accorpamento nel Genitore", creando un'unica tabella ottimizzata con 
   l'attributo "Ruolo" per gestire gli accessi in modo più efficiente.

C. Struttura dei File nella Directory:
   - login_centro_controllo.m   -> File principale (Interfaccia di Login e Menu)
   - CreaDB.m                  -> Script unificato di inizializzazione SQL
   - grafico_sesso.m           -> Analisi vettoriale e grafico a torta (Genere)
   - grafico_eta.m             -> Analisi vettoriale e grafico a torta (Età)
   - grafico_costi.m           -> Connessione SQLite e Analisi Spesa Sanitaria
   - mappa_epidemiologica.m    -> Distribuzione geografica delle patologie
   - database/                 -> Cartella locale protetta contenente:
     * Anagrafica.csv, Demografia.csv, Epidemiologia.csv (Flussi di input)
     * sistema_sanitario.db (Database relazionale SQLite autogenerato)


3. GUIDA ALL'AVVIO E FUNZIONAMENTO

Fase 1: Inizializzazione del Database
Prima di avviare l'applicazione per la prima volta (o in caso di modifica 
dei dati grezzi nei file CSV), eseguire lo script:
>> CreaDB

Questo script leggerà i flussi CSV, modellerà le tabelle relazionali, 
inserirà le credenziali degli utenti di prova e genererà in modo sincrono
 il file 'sistema_sanitario.db' nella cartella.

Fase 2: Avvio dell'Applicazione
Eseguire il file principale digitando nella Command Window:
>> login_centro_controllo

Fase 3: Credenziali di Accesso
- Profilo GUEST: Selezionare "Guest" dal menu a tendina (Nessuna password richiesta).
  Garantisce l'accesso alle funzioni statistiche di base (Sesso, Età, Costi).
- Profilo RICERCATORE: Selezionare "Ricercatore Clinico" e digitare la password:
  Codice: ricercatore123
  Sblocca il pannello completo con funzioni di Confronto avanzato, 
  Previsioni temporali ed Esportazione dei dati.


4. FUNZIONALITÀ AVANZATE 
- Elaborazione Sincrona: Le callback dei grafici interrogano i database 
  in tempo reale ad ogni clic per garantire la massima accuratezza dei dati.
- Pattern Matching e Data Cleaning: Implementazione di filtri robusti 
  con cicli 'for' e 'regexprep' per l'uniformazione dei testi medici.
- Algoritmo di Reportistica PDF: Il pulsante "REPORT PDF" esegue calcoli 
  statistici matematici (tasso di letalità medio, picco di 
  densità geografica per regione e graduatoria Top 3 delle patologie 
  più incidenti) generando un documento formattato ad uso clinico 
  tramite le librerie 'mlreportgen.dom'.
- Esportazione standard: Conversione nativa da tabelle MATLAB a formato 
  universale CSV per l'interoperabilità con sistemi sanitari esterni.

