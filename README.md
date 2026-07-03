# progetto_malattie_autoimmuni

    SISTEMA EPIDEMIOLOGICO NAZIONALE: PATOLOGIE CRONICHE AUTOIMMUNI

Sviluppato da: Brillante Ludovica e Di Dio Chiara
Ambiente di sviluppo: MATLAB R2025b / R2026 + Visual studio Code
Database: SQLite 3 e Flussi Strutturati CSV
------------------------------------------------------------------------

# INTRODUZIONE E OBIETTIVI DEL PROGETTO

Il presente progetto consiste nella progettazione e nello sviluppo di un sistema software integrato in ambiente MATLAB per la gestione, il monitoraggio e l'analisi statistico-epidemiologica delle principali patologie autoimmuni sul territorio nazionale.

L'applicazione modella un'architettura dati a due livelli (flussi di input CSV e database relazionale SQL) e fornisce un'interfaccia grafica (GUI) dinamica con accessi profilati tramite credenziali gestite internamente nel database.

# ARCHITETTURA E PROGETTAZIONE DEL DATABASE

Il sistema è stato strutturato seguendo le fasi classiche della progettazione delle basi di dati:

**A. Progettazione Concettuale (Modello ER):**
Modellazione a stella incentrata sull'entità principale "MALATTIE".

**B. Traduzione nel Modello Relazionale (Modello Logico).**

**C. Struttura dei file nella directory:**

* login_centro_controllo.m → File principale (interfaccia di login e menu)
* CreaDB.m → Script unificato di inizializzazione SQL
* anagrafica_clinica.m → Schermata principale di selezione e scomposizione delle patologie
* descrizione_clinica.m → Sotto-modulo testuale per l'eziopatogenesi
* quadro_sintomatologico.m → Sotto-modulo per la consultazione rapida dei sintomi
* organi_coinvolti.m → Sotto-modulo per la mappa anatomica visiva
* protocolli_terapeutici.m → Sotto-modulo per le linee guida sui trattamenti
* grafico_sesso.m → Analisi vettoriale e grafico a torta (genere)
* grafico_eta.m → Analisi vettoriale e grafico a barre tridimensionale (età)
* grafico_costi.m → Connessione SQLite e analisi della spesa sanitaria
* mappa_epidemiologica.m → Distribuzione geografica delle patologie
* database/ → Cartella locale protetta contenente:

  * Anagrafica.csv
  * Demografia.csv
  * Epidemiologia.csv (flussi di input ISTAT)
  * sistema_sanitario.db (database relazionale SQLite autogenerato)

# GUIDA ALL'AVVIO E AL FUNZIONAMENTO

## Fase 1: Inizializzazione del database

Prima di avviare l'applicazione per la prima volta (o in caso di modifica dei dati grezzi nei file CSV), eseguire lo script:

**CreaDB**

Questo script leggerà i flussi CSV, modellerà le tabelle relazionali, inserirà le credenziali degli utenti di prova e genererà in modo sincrono il file **sistema_sanitario.db** nella cartella.

## Fase 2: Avvio dell'applicazione

Eseguire il file principale digitando nella Command Window:

**login_centro_controllo**

## Fase 3: Credenziali di accesso

**Profilo GUEST:** selezionare "Guest" dal menu a tendina (nessuna password richiesta). Garantisce l'accesso alle funzioni statistiche di base.

**Profilo RICERCATORE:** selezionare "Ricercatore Clinico" e digitare la password **ricercatore123**. Sblocca il pannello completo con funzioni avanzate.

# MODULI OPERATIVI E INTERFACCIA GRAFICA

## Modulo 1: Anagrafica Clinica Patologie

Centro di consultazione e scomposizione informativa per le singole malattie autoimmuni.

Attraverso un menu a tendina, l'operatore seleziona una patologia e, tramite l'attivazione di quattro pulsanti dedicati, può consultare le specifiche sotto-schermate di approfondimento: descrizione clinica, quadro sintomatologico, organi coinvolti e protocolli terapeutici.

## Modulo 2: Analisi Epidemiologica e Statistica

* **Mappa Epidemiologica:** rappresentazione dell'Italia suddivisa per regioni.
* **Costi Sanitari:** calcolo dell'impatto economico complessivo per ciascuna malattia cronica.
* **Distribuzione Demografica e di Genere:** generazione di diagrammi a torta.

# FUNZIONALITÀ AVANZATE

* **Elaborazione sincrona:** le callback dei grafici interrogano il database in tempo reale a ogni clic, per garantire la massima accuratezza dei dati.
* **Pattern Matching e Data Cleaning:** implementazione di filtri robusti con cicli `for` e `regexprep` per l'uniformazione dei testi medici.
* **Algoritmo di Reportistica PDF:** il pulsante "REPORT PDF" esegue calcoli statistici e matematici (tasso medio di letalità, picco di densità geografica per regione e graduatoria delle prime tre patologie con la maggiore incidenza), generando un documento formattato a uso clinico.
* **Esportazione standard:** conversione nativa delle tabelle MATLAB nel formato universale CSV, per garantire l'interoperabilità con sistemi sanitari esterni.
