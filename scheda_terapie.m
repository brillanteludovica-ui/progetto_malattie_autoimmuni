function scheda_terapie(idMalattia)
    nomi = {'Sclerosi Multipla', 'Celiachia', 'Diabete Tipo 1', 'Tiroidite di Hashimoto', 'Morbo di Crohn'};
    malattia = nomi{idMalattia};
    
    fig = figure('Name', ['Terapie - ' malattia], 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', 'Position', [450, 250, 560, 300], 'Color', 'w');
    
    uicontrol('Parent', fig, 'Style', 'text', 'String', ['💊 PROTOCOLLI TERAPEUTICI: ' upper(malattia)], ...
        'Position', [20, 245, 520, 30], 'FontSize', 12, 'FontWeight', 'bold', 'BackgroundColor', 'w', ...
        'ForegroundColor', [0.10, 0.70, 0.40], 'HorizontalAlignment', 'left');
    
    switch malattia
        case 'Sclerosi Multipla'
            t = 'Attualmente non esiste una cura eradicante. Il protocollo prevede farmaci modificanti la malattia (DMD) basati su immunomodulatori (interferoni) o anticorpi monoclonali selettivi per ridurre la frequenza delle ricadute. Le esacerbazioni acute vengono trattate con boli endovenosi di corticosteroidi ad alto dosaggio (metilprednisolone), affiancati da fisioterapia riabilitativa.';
        case 'Celiachia'
            t = 'L''unico trattamento terapeutico di comprovata efficacia salvavita e validato a livello clinico internazionale consiste nell''esclusione totale, assoluta e permanente del glutine dalla dieta alimentare (regime terapeutico gluten-free). L''eliminazione della prolamina tossica azzera lo stimolo infiammatorio autoimmune intestinale, permettendo la rigenerazione dei villi.';
        case 'Diabete Tipo 1'
            t = 'Trattamento basato esclusivamente sulla terapia insulinica sostitutiva esogena salvavita a vita. Viene somministrata tramite iniezioni sottocutanee multiple quotidiane (schema basal-bolus) o mediante l''utilizzo di microinfusori continui (CSII). La terapia richiede un monitoraggio costante effettuato tramite sensori interstiziali (CGM).';
        case 'Tiroidite di Hashimoto'
            t = 'Il protocollo clinico standard consiste nella terapia sostitutiva ormonale orale quotidiana a vita a base di Levotiroxina sodica (ormone sintetico analogo del T4). L''obiettivo farmacologico è vicariare la funzionalità perduta della tiroide distruttiva, sopprimendo l''ipersecrezione ipofisaria di TSH e ripristinando uno stato metabolico ideale.';
        case 'Morbo di Crohn'
            t = 'Il trattamento farmacologico si basa sull''uso di antinfiammatori topici localizzati (mesalazina), immunosoppressori sistemici e farmaci biologici avanzati anti-TNF (es. Infliximab) per indurre e mantenere la remissione clinica. Nei casi complicati da stenosi fibrose serrate, occlusioni o perforazioni fistolose si ricorre alla chirurgia di resezione.';
    end
    
    % Sostituito 'justify' con 'left'
    uicontrol('Parent', fig, 'Style', 'text', 'String', t, 'Position', [20, 20, 520, 210], ...
        'FontSize', 11, 'BackgroundColor', 'w', 'ForegroundColor', 'k', 'HorizontalAlignment', 'left');
end