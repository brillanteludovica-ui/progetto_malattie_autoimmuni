
% INTERFACCIA PRINCIPALE: SISTEMA EPIDEMIOLOGICO ITALIA

function login_centro_controllo()
    clc; close all;

    % SCHERMATA LOGIN
    figLogin = figure('Name', 'Accesso Sistema', 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', ...
        'Position', [500, 300, 420, 340], 'Color', 'w');

    uicontrol('Parent', figLogin, 'Style', 'text', ...
        'String', 'SISTEMA EPIDEMIOLOGICO ITALIA', ...
        'Position', [20, 265, 380, 30], 'FontSize', 14, ...
        'FontWeight', 'bold', 'BackgroundColor', 'w', ...
        'ForegroundColor', [0.00 0.45 1.00]);

    uicontrol('Parent', figLogin, 'Style', 'text', ...
        'String', 'Seleziona il tuo Profilo:', ...
        'Position', [50, 205, 320, 20], ...
        'FontSize', 10, 'FontWeight', 'bold', ...
        'BackgroundColor', 'w', 'HorizontalAlignment', 'left', ...
        'ForegroundColor', [0.2 0.2 0.2]);

    menuRuolo = uicontrol('Parent', figLogin, 'Style', 'popupmenu', ...
        'String', {'Guest (Ospite)', 'Ricercatore Clinico'}, ...
        'Position', [50, 175, 320, 25], 'FontSize', 10);

    txtPassword = uicontrol('Parent', figLogin, 'Style', 'text', ...
        'String', 'Codice Identificativo Ricercatore:', ...
        'Position', [50, 135, 320, 20], ...
        'FontSize', 10, 'FontWeight', 'bold', ...
        'BackgroundColor', 'w', 'ForegroundColor', [0.2 0.2 0.2], ...
        'HorizontalAlignment', 'left');

    editPassword = uicontrol('Parent', figLogin, 'Style', 'edit', ...
        'String', '', 'Position', [50, 110, 320, 25], ...
        'FontSize', 11, ...
        'Enable', 'off', ...
        'BackgroundColor', [0.9 0.9 0.9], ...
        'ForegroundColor', [0.4 0.4 0.4]);

    set(menuRuolo, 'Callback', @(src,~) gestisciCampi(src, txtPassword, editPassword));

    uicontrol('Parent', figLogin, 'Style', 'pushbutton', ...
        'String', 'ACCEDI AL SISTEMA', ...
        'Position', [80, 35, 260, 42], ...
        'FontSize', 11, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.00 0.45 1.00], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) verificareLogin(menuRuolo, editPassword, figLogin));
end

function gestisciCampi(src, txt, editField)
    if src.Value == 2
        set(txt, 'Enable', 'on');
        set(editField, 'Enable', 'on');
        set(editField, 'BackgroundColor', 'white');
        set(editField, 'ForegroundColor', [0 0 0]);
    else
        set(txt, 'Enable', 'off');
        set(editField, 'Enable', 'off');
        set(editField, 'String', '');
        set(editField, 'BackgroundColor', [0.9 0.9 0.9]);
        set(editField, 'ForegroundColor', [0.4 0.4 0.4]);
    end
end

function verificareLogin(menuRuolo, editPassword, figLogin)
    if menuRuolo.Value == 2
        if strcmp(get(editPassword, 'String'), 'ricercatore123')
            close(figLogin);
            apriCentroControllo("Ricercatore");
        else
            errordlg('Codice Ricercatore Errato!', 'Errore');
        end
    else
        close(figLogin);
        apriCentroControllo("Guest");
    end
end

function apriCentroControllo(ruolo)
    figCentro = figure('Name', ['Centro Controllo - ' char(ruolo)], ...
        'NumberTitle', 'off', 'MenuBar', 'none', ...
        'ToolBar', 'none', 'Position', [350, 80, 680, 600], 'Color', 'w');

    uicontrol('Parent', figCentro, 'Style', 'text', ...
        'String', ['PANNELLO: ' upper(char(ruolo))], ...
        'Position', [30, 545, 620, 30], ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'BackgroundColor', 'w', 'ForegroundColor', [0.00 0.45 1.00]);

    % BOTTONE ANAGRAFICA CLINICA 
    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', '📄 ANAGRAFICA CLINICA PATOLOGIE', ...
        'Position', [40, 485, 600, 45], 'FontSize', 11, 'FontWeight', 'bold', ...
        ... 
        'BackgroundColor', [0.00 0.45 1.00], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) dashboard_clinica_anagrafica());

    % PULSANTI DI ANALISI BASE (ACCESSIBILI A GUEST E RICERCATORE)
    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', 'MAPPA EPIDEMIOLOGICA', ...
        'Position', [40, 415, 280, 42], ...
        'BackgroundColor', [0.00 0.75 0.20], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) mappa_epidemiologica());

    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', 'COSTI SANITARI', ...
        'Position', [350, 415, 290, 42], ...
        'BackgroundColor', [0.95 0.65 0.00], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) grafico_costi());

    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', 'ETA', ...
        'Position', [40, 355, 280, 42], ...
        'BackgroundColor', [0.90 0.00 0.60], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) grafico_eta());

    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', 'SESSO', ...
        'Position', [350, 355, 290, 42], ...
        'BackgroundColor', [0.50 0.00 0.90], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) grafico_sesso());

    % PULSANTI AVANZATI (SOLO RICERCATORE)
    if ruolo == "Ricercatore"
        uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
            'String', 'CONFRONTO MALATTIE', ...
            'Position', [40, 260, 590, 42], ...
            'BackgroundColor', [0.00 0.65 0.68], 'ForegroundColor', 'w', ...
            'Callback', @(~,~) grafico_confronto());

        uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
            'String', 'PREVISIONI', ...
            'Position', [40, 200, 590, 42], ...
            'BackgroundColor', [0.08 0.18 0.36], 'ForegroundColor', 'w', ...
            'Callback', @(~,~) grafico_previsione());

        uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
            'String', 'EXPORT CSV', ...
            'Position', [40, 95, 280, 40], ...
            'BackgroundColor', [0.10 0.50 0.30], 'ForegroundColor', 'w', ...
            'Callback', @esportaSempliceCSV);

        uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
            'String', 'REPORT PDF', ...
            'Position', [350, 95, 290, 40], ...
            'BackgroundColor', [0.75 0.20 0.20], 'ForegroundColor', 'w', ...
            'Callback', @esportaReportPDFAcademic);
    end

    uicontrol('Parent', figCentro, 'Style', 'pushbutton', ...
        'String', 'ESCI', ...
        'Position', [40, 25, 590, 42], ...
        'BackgroundColor', [1 0 0], 'ForegroundColor', 'w', ...
        'Callback', @(~,~) chiudiTutto(figCentro));
end

function esportaSempliceCSV(~, ~)
    try
        T = readtable('database/Epidemiologia.csv', 'VariableNamingRule', 'preserve');
        writetable(T, 'Report_Epidemiologia_Output.csv');
        msgbox('File CSV generato con successo nella cartella di progetto!', 'Successo');
    catch ME
        errordlg(['Errore durante l''esportazione CSV: ' ME.message], 'Errore');
    end
end
%  REPORT PDF 

function esportaReportPDFAcademic(~, ~)
    try
        import mlreportgen.dom.*

        
        fileCSV = 'database/Epidemiologia.csv';
        if ~isfile(fileCSV)
            error('Il file database/Epidemiologia.csv non è stato trovato.');
        end

        T = readtable(fileCSV, 'VariableNamingRule', 'preserve');
        if isempty(T)
            error('Il file Epidemiologia.csv è vuoto o non leggibile.');
        end

        vars = T.Properties.VariableNames;
        varsLow = lower(vars);

        
        idxMal  = find(contains(varsLow,'malat') | contains(varsLow,'patologia') | contains(varsLow,'nome'), 1);
        idxCasi = find(contains(varsLow,'casi') | contains(varsLow,'tot'), 1);
        idxMort = find(contains(varsLow,'mortal') | contains(varsLow,'decessi') | contains(varsLow,'letal'), 1);
        idxReg  = find(contains(varsLow,'region') | contains(varsLow,'zona') | contains(varsLow,'territ'), 1);

        if isempty(idxMal) || isempty(idxCasi)
            error(['Nel file Epidemiologia.csv non sono state trovate colonne riconoscibili per ' ...
                   'malattia/patologia e numero di casi.']);
        end

        colMal = vars{idxMal};
        colCasi = vars{idxCasi};

        hasMort = ~isempty(idxMort);
        hasReg  = ~isempty(idxReg);

        if hasMort
            colMort = vars{idxMort};
        end
        if hasReg
            colReg = vars{idxReg};
        end

        
        nomiMalattia = string(T.(colMal));
        casi = convertiNumerico(T.(colCasi));

        if hasMort
            mortalita = convertiNumerico(T.(colMort));
        else
            mortalita = nan(height(T),1);
        end

        if hasReg
            regioni = string(T.(colReg));
        else
            regioni = strings(height(T),1);
        end

        
        righeValide = ~(ismissing(nomiMalattia) | nomiMalattia=="") & ~isnan(casi);
        nomiMalattia = nomiMalattia(righeValide);
        casi = casi(righeValide);

        if hasMort
            mortalita = mortalita(righeValide);
        else
            mortalita = nan(sum(righeValide),1);
        end

        if hasReg
            regioni = regioni(righeValide);
        else
            regioni = strings(sum(righeValide),1);
        end

        if isempty(nomiMalattia)
            error('Dopo la pulizia dei dati non sono rimaste osservazioni valide.');
        end

        
        [grpMal, nomiUniciMal] = findgroups(nomiMalattia);
        casiPerMal = splitapply(@nansum, casi, grpMal);

        if hasMort
            mortalitaMediaPerMal = splitapply(@(x) mean(x,'omitnan'), mortalita, grpMal);
        else
            mortalitaMediaPerMal = nan(size(casiPerMal));
        end

        [casiOrdinati, idxOrd] = sort(casiPerMal, 'descend');
        malOrd = string(nomiUniciMal(idxOrd));

        totCasi = sum(casi, 'omitnan');

        if hasMort
            
            decessiStimatiRiga = casi .* (mortalita / 100);
            totMortiStimati = sum(decessiStimatiRiga, 'omitnan');
            mortalitaMedia = mean(mortalita, 'omitnan');
        else
            totMortiStimati = NaN;
            mortalitaMedia = NaN;
        end

        
        regioneTop = "Dato non disponibile";
        maxCasiReg = NaN;
        nRegioniMonitorate = NaN;

        if hasReg
            righeRegValide = ~(ismissing(regioni) | regioni=="");
            if any(righeRegValide)
                [grpReg, nomiReg] = findgroups(regioni(righeRegValide));
                casiPerRegione = splitapply(@nansum, casi(righeRegValide), grpReg);
                [maxCasiReg, idxMaxReg] = max(casiPerRegione);
                regioneTop = string(nomiReg(idxMaxReg));
                nRegioniMonitorate = numel(nomiReg);
            end
        end

       
        malattiaTop = malOrd(1);
        casiTop = casiOrdinati(1);
        quotaTop = (casiTop / totCasi) * 100;

        nPatologie = numel(nomiUniciMal);

        if nPatologie > 1
            dispersione = std(casiPerMal, 'omitnan');
        else
            dispersione = 0;
        end

        
        timestamp = datestr(now, 'yyyy-mm-dd_HHMMSS');
        nomeFile = ['Report_Epidemiologico_Autoimmune_' timestamp '.pdf'];

        doc = Document(nomeFile, 'pdf');
        open(doc);

        
        styleTitle = {FontSize('20pt'), Bold(true), Color('#0057B8'), HAlign('center')};
        styleSubTitle = {FontSize('12pt'), Italic(true), Color('#4F4F4F'), HAlign('center')};
        styleSection = {FontSize('14pt'), Bold(true), Color('#0057B8')};
        styleBody = {FontSize('10.5pt'), HAlign('justify')};
        styleSmall = {FontSize('9pt'), Color('#666666')};

       
        append(doc, Paragraph(' '));
        append(doc, Paragraph('SISTEMA EPIDEMIOLOGICO ITALIA'));
        doc.Children(end).Style = styleTitle;

        append(doc, Paragraph('Report clinico-statistico sulle principali patologie autoimmuni monitorate in Italia'));
        doc.Children(end).Style = styleSubTitle;

        append(doc, Paragraph(' '));

        pInfo = Paragraph(['Documento generato automaticamente dal modulo riservato al Ricercatore Clinico | Data: ' ...
            datestr(now, 'dd/mm/yyyy') ' | Ora: ' datestr(now, 'HH:MM')]);
        pInfo.Style = {FontSize('9.5pt'), HAlign('center'), Color('#666666')};
        append(doc, pInfo);

        append(doc, Paragraph(' '));
        append(doc, HorizontalRule);
        append(doc, Paragraph(' '));

        
        p = Paragraph('1. REPORT');
        p.Style = styleSection;
        append(doc, p);

        testoSummary = sprintf([ ...
            'Il presente report sintetizza i risultati principali emersi dall''analisi del database epidemiologico ' ...
            'relativo a %d patologie autoimmuni monitorate sul territorio nazionale. ' ...
            'L''elaborazione è stata eseguita in ambiente MATLAB a partire da dati strutturati in formato CSV, ' ...
            'con l''obiettivo di integrare consultazione descrittiva, confronto clinico e supporto all''interpretazione epidemiologica.\n\n' ...
            'Nel campione analizzato risultano complessivamente %.0f casi registrati. La patologia con il maggior carico osservato nel dataset è "%s", ' ...
            'che da sola rappresenta il %.1f%% del totale considerato. %s'], ...
            nPatologie, totCasi, char(malattiaTop), quotaTop, generaFraseMortalita(mortalitaMedia, totMortiStimati));

        p = Paragraph(testoSummary);
        p.Style = styleBody;
        append(doc, p);

        append(doc, Paragraph(' '));

        
        p = Paragraph('2. INDICATORI CHIAVE DEL DATASET');
        p.Style = styleSection;
        append(doc, p);

        append(doc, creaBullet(['Patologie monitorate: ' num2str(nPatologie)]));
        append(doc, creaBullet(['Casi complessivi analizzati: ' num2str(round(totCasi))]));
        append(doc, creaBullet(['Patologia a maggiore prevalenza nel dataset: ' char(malattiaTop) ...
            ' (' num2str(round(casiTop)) ' casi)']));

        if hasReg && ~ismissing(regioneTop) && regioneTop ~= ""
            append(doc, creaBullet(['Area/regione con maggior numero di casi registrati: ' ...
                char(regioneTop) ' (' num2str(round(maxCasiReg)) ' casi)']));
            append(doc, creaBullet(['Numero di regioni/aree monitorate nel dataset: ' num2str(nRegioniMonitorate)]));
        else
            append(doc, creaBullet('Distribuzione territoriale: dato non disponibile nel file Epidemiologia.csv.'));
        end

        if hasMort && ~isnan(mortalitaMedia)
            append(doc, creaBullet(['Mortalità/letalità media osservata: ' num2str(mortalitaMedia, '%.2f') '%']));
            append(doc, creaBullet(['Decessi stimati complessivi (calcolo su base percentuale): ' ...
                num2str(round(totMortiStimati))]));
        else
            append(doc, creaBullet('Indicatori di mortalità: non disponibili nel file caricato.'));
        end

        append(doc, creaBullet(['Variabilità tra patologie (dispersione dei casi): ' num2str(dispersione, '%.2f')]));
        append(doc, Paragraph(' '));

        
        p = Paragraph('3. GRADUATORIA DI PREVALENZA DELLE PATOLOGIE');
        p.Style = styleSection;
        append(doc, p);

        pDesc = Paragraph(['La seguente graduatoria ordina le patologie in base al numero complessivo di casi ' ...
            'registrati nel dataset. Tale classifica permette di identificare il peso relativo di ciascuna condizione ' ...
            'all''interno del sistema epidemiologico analizzato.']);
        pDesc.Style = styleBody;
        append(doc, pDesc);

        append(doc, Paragraph(' '));

        topN = min(5, numel(malOrd));
        for i = 1:topN
            perc = 100 * casiOrdinati(i) / totCasi;
            testoRiga = sprintf('%d) %s - %.0f casi (%.1f%% del totale)', ...
                i, malOrd(i), casiOrdinati(i), perc);

            pr = Paragraph(testoRiga);
            if i == 1
                pr.Style = {FontSize('11pt'), Bold(true), Color('#1F1F1F')};
            else
                pr.Style = {FontSize('10.5pt')};
            end
            append(doc, pr);
        end

        append(doc, Paragraph(' '));

      
	append(doc, PageBreak);

	p = Paragraph('4. TABELLA DI SINTESI CLINICO-EPIDEMIOLOGICA');
	p.Style = styleSection;
	append(doc, p);

        intestazione = {'Patologia', 'Casi Totali', 'Quota % sul totale', 'Mortalità media %'};
        datiTabella = cell(numel(nomiUniciMal)+1, 4);
        datiTabella(1,:) = intestazione;

        for i = 1:numel(nomiUniciMal)
            quota = 100 * casiPerMal(i) / totCasi;
            datiTabella{i+1,1} = char(string(nomiUniciMal(i)));
            datiTabella{i+1,2} = num2str(round(casiPerMal(i)));
            datiTabella{i+1,3} = num2str(quota, '%.1f');

            if hasMort && ~isnan(mortalitaMediaPerMal(i))
                datiTabella{i+1,4} = num2str(mortalitaMediaPerMal(i), '%.2f');
            else
                datiTabella{i+1,4} = 'n.d.';
            end
        end

        tbl = Table(datiTabella);
        tbl.Width = '100%';
        tbl.Border = 'solid';
        tbl.BorderWidth = '1px';
        tbl.ColSep = 'solid';
        tbl.RowSep = 'solid';
        tbl.Style = {FontSize('9pt')};

        for j = 1:4
            entry = tbl.Children(1).Children(j);
            entry.Style = [entry.Style {Bold(true), BackgroundColor('#DCEBFA')}];
        end

        append(doc, tbl);
        append(doc, Paragraph(' '));

        
        p = Paragraph('5. INTERPRETAZIONE DEI RISULTATI');
        p.Style = styleSection;
        append(doc, p);

        testoInterpretazione = generaInterpretazione( ...
            malattiaTop, quotaTop, regioneTop, hasReg, mortalitaMedia, hasMort, nPatologie);

        p = Paragraph(testoInterpretazione);
        p.Style = styleBody;
        append(doc, p);

        append(doc, Paragraph(' '));

       
        p = Paragraph('6. CONCLUSIONI E VALORE DEL SISTEMA');
        p.Style = styleSection;
        append(doc, p);

        testoConclusioni = [ ...
            'Il progetto "Sistema Epidemiologico Italia" è stato concepito come strumento integrato di consultazione e supporto decisionale, ' ...
            'capace di coniugare visualizzazione interattiva, analisi quantitativa e sintesi documentale. ' ...
            'La distinzione tra accesso Guest e accesso Ricercatore Clinico consente di separare la fruizione divulgativa dalla consultazione avanzata, ' ...
            'rendendo la piattaforma adatta sia a finalità informative sia a contesti accademici e di studio.\n\n' ...
            'Dal punto di vista metodologico, l''uso di file CSV strutturati e di funzioni MATLAB dedicate alla lettura, aggregazione e rappresentazione ' ...
            'dei dati permette di costruire un flusso di lavoro replicabile, estendibile e coerente con un''impostazione di analisi epidemiologica. ' ...
            'Il report PDF costituisce il livello conclusivo del progetto, trasformando i risultati numerici in un documento sintetico, leggibile e professionale.'];

        p = Paragraph(testoConclusioni);
        p.Style = styleBody;
        append(doc, p);

        append(doc, Paragraph(' '));
        append(doc, HorizontalRule);

       
        nota = Paragraph(['Nota: i risultati riportati dipendono dalla struttura e dall''aggiornamento del file CSV caricato nel database. ' ...
            'Il report ha finalità didattiche e di analisi del dato e non sostituisce un documento clinico ufficiale.']);
        nota.Style = styleSmall;
        append(doc, nota);

        close(doc);

        msgbox(['Report PDF generato con successo: ' nomeFile], 'Successo');

    catch ME
        errordlg(['Errore durante la generazione del PDF: ' ME.message], 'Errore');
    end
end


% FUNZIONI DI SUPPORTO PDF


function x = convertiNumerico(v)
     
    if isnumeric(v)
        x = double(v);
        return;
    end

    if iscell(v)
        try
            v = string(v);
        catch
            x = nan(numel(v),1);
            return;
        end
    end

    if isstring(v) || ischar(v) || iscategorical(v)
        v = string(v);
        v = strrep(v, ',', '.');         
        v = regexprep(v, '[^\d\.\-]', ''); 
        x = str2double(v);
        return;
    end

    x = nan(size(v));
end

function p = creaBullet(testo)
    import mlreportgen.dom.*
    p = Paragraph(['• ' testo]);
    p.Style = {FontSize('10.5pt'), HAlign('justify')};
end

function frase = generaFraseMortalita(mortalitaMedia, totMortiStimati)
    if isnan(mortalitaMedia)
        frase = ['Il file in uso non contiene una colonna interpretabile come mortalità o letalità, ' ...
                 'per cui il report si concentra prevalentemente su distribuzione dei casi e prevalenza relativa delle patologie.'];
    else
        frase = sprintf(['La mortalità/letalità media osservata nel dataset è pari al %.2f%%, ' ...
                         'con una stima complessiva di circa %.0f decessi calcolata sui valori disponibili.'], ...
                         mortalitaMedia, totMortiStimati);
    end
end

function testo = generaInterpretazione(malattiaTop, quotaTop, regioneTop, hasReg, mortalitaMedia, hasMort, nPatologie)
    parte1 = sprintf([ ...
        'L''analisi mette in evidenza una distribuzione non uniforme del carico epidemiologico tra le %d patologie considerate. ' ...
        'In particolare, %s emerge come la condizione con il maggior numero di casi, rappresentando il %.1f%% del totale osservato. ' ...
        'Questo dato suggerisce che, all''interno del dataset utilizzato, tale patologia eserciti un peso sanitario più marcato rispetto alle altre condizioni monitorate. '], ...
        nPatologie, char(malattiaTop), quotaTop);

    if hasReg && ~ismissing(regioneTop) && regioneTop ~= ""
        parte2 = sprintf([ ...
            'Dal punto di vista territoriale, la concentrazione massima di casi risulta associata a %s, ' ...
            'informazione che può essere utile per evidenziare possibili differenze regionali nella diagnosi, nella presa in carico o nella distribuzione della popolazione osservata. '], ...
            char(regioneTop));
    else
        parte2 = ['Il file attualmente in uso non consente una lettura territoriale completa, per cui il confronto geografico non è stato incluso tra gli indicatori interpretativi principali. '];
    end

    if hasMort && ~isnan(mortalitaMedia)
        parte3 = sprintf([ ...
            'La presenza di un indicatore di mortalità/letalità permette inoltre di affiancare alla semplice prevalenza una valutazione, seppur sintetica, della severità clinica media del campione. ' ...
            'In un contesto reale, un''integrazione di questo tipo sarebbe utile per orientare la programmazione sanitaria, la prioritizzazione delle risorse e la definizione di strategie di monitoraggio. ']);
    else
        parte3 = ['In assenza di una colonna affidabile relativa alla mortalità, il valore del report resta comunque elevato sul piano descrittivo, perché consente di confrontare il peso relativo delle diverse patologie e di sintetizzare il contenuto del database in forma leggibile e immediata.'];
    end

    testo = [parte1 parte2 parte3];
end

% CHIUSURA

function chiudiTutto(fig)
    close(fig);
    close all;
end