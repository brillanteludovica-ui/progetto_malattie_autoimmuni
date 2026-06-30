function motore_estrazione_anagrafica(idMalattia, tipoDato)
    nomi = {'Sclerosi Multipla', 'Celiachia', 'Diabete Tipo 1', 'Tiroidite di Hashimoto', 'Morbo di Crohn'};
    malattia = nomi{idMalattia};

    % Configura i colori e i titoli in base al tipo di scheda estratto
    switch tipoDato
        case 'descrizione'
            titoloFinestra = 'Descrizione Clinica'; colTematico = [0.20 0.60 1.00]; prefisso = '📄 DESCRIZIONE CLINICA AVANZATA: ';
        case 'sintomi'
            titoloFinestra = 'Quadro Sintomatologico'; colTematico = [1.00, 0.35, 0.10]; prefisso = '⚠️ QUADRO SINTOMATOLOGICO STRUTTURATO: ';
        case 'terapie'
            titoloFinestra = 'Protocolli Terapeutici'; colTematico = [0.10, 0.70, 0.40]; prefisso = '💊 PROTOCOLLI TERAPEUTICI DISPONIBILI: ';
    end

    fig = figure('Name', [titoloFinestra ' - ' malattia], 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', 'Position', [450, 250, 560, 300], 'Color', 'w');

    uicontrol('Parent', fig, 'Style', 'text', 'String', [prefisso upper(malattia)], ...
        'Position', [20, 245, 520, 30], 'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', 'w', 'ForegroundColor', colTematico, 'HorizontalAlignment', 'left');

    % Database dei testi completi e approfonditi
    switch malattia
        case 'Sclerosi Multipla'
            desc = 'La Sclerosi Multipla è una patologia cronica infiammatoria demielinizzante ad andamento progressivo. Il sistema immunitario attacca la guaina mielinica isolante dei neuroni nel sistema nervoso centrale, determinando placche sclero-cicatriziali che bloccano la normale conduzione degli impulsi bioelettrici lungo gli assoni.';
            sint = ['- Stanchezza cronica centrale profonda ed invalidante (fatigue)' + newline + ...
                     '- Neurite ottica retrobulbare con dolore e annebbiamento visivo transitorio' + newline + ...
                     '- Atassia cerebellare, marcata perdita di equilibrio e vertigini' + newline + ...
                     '- Parestesie, alterazioni della sensibilità e spasticità muscolare agli arti.'];
            ter = 'Uso di farmaci modificanti la malattia (DMD) come gli anticorpi monoclonali per rallentare la progressione. Corticosteroidi ad alto dosaggio somministrati in bolo endovenoso (metilprednisolone) per ridurre la durata delle fasi acute di ricaduta, affiancati da cicli di fisioterapia motoria mirata.';
            
        case 'Celiachia'
            desc = 'La Celiachia è un''enteropatia autoimmune permanente e sistemica, scatenata dall''ingestione di glutine (frazione proteica presente in frumento, orzo e segale) in soggetti geneticamente predisposti (aplotipi HLA-DQ2/DQ8). Provoca una massiva reazione linfocitaria che demolisce la mucosa enterica.';
            sint = ['- Diarrea cronica persistente con quadri gravi di steatorrea' + newline + ...
                     '- Dolore addominale ricorrente, crampi e meteorismo intestinale severo' + newline + ...
                     '- Sindrome da malassorbimento con conseguente anemia sideropenica refrattaria' + newline + ...
                     '- Calo ponderale progressivo, astenia e arresto della crescita staturale nei bambini.'];
            ter = 'L''unico trattamento terapeutico di comprovata efficacia salvavita e validato a livello clinico internazionale consiste nell''esclusione totale, assoluta e permanente del glutine dalla dieta alimentare (regime terapeutico gluten-free). L''eliminazione della prolamina tossica permette la completa rigenerazione istologica dei villi.';
            
        case 'Diabete Tipo 1'
            desc = 'Il Diabete di Tipo 1 è una severa patologia metabolica cronica indotta da un''anomala distruzione autoimmune organo-specifica. Il sistema immunitario riconosce erroneamente come estranee e demolisce in modo selettivo ed irreversibile le cellule beta dislocate all''interno delle isole di Langerhans pancreatiche.';
            sint = ['- Poliuria marcata dovuta a diuresi osmotica causata dall''iperglicemia' + newline + ...
                     '- Polidipsia compensatoria secondaria alla forte disidratazione dei tessuti' + newline + ...
                     '- Polifagia paradossa accompagnata da un calo ponderale repentino ed evidente' + newline + ...
                     '- Letargia cronica, affaticamento muscolare, visione offuscata e rischio di coma.'];
            ter = 'Trattamento basato esclusivamente sulla terapia insulinica sostitutiva esogena salvavita a vita. Viene somministrata tramite iniezioni sottocutanee multiple quotidiane (schema basal-bolus) o mediante l''utilizzo di microinfusori continui (CSII). Richiede un monitoraggio costante tramite sensori interstiziali (CGM).';
            
        case 'Tiroidite di Hashimoto'
            desc = 'La Tiroidite di Hashimoto è una patologia endocrina autoimmune d''organo. Caratterizzata da una massiva infiltrazione intraparenchimale di linfociti T e B che aggrediscono i tireociti, la malattia determina la progressiva distruzione del tessuto follicolare della tiroide, conducendo a un quadro clinico stazionario di ipotiroidismo.';
            sint = ['- Astenia severa diffusa, sonnolenza diurna e rallentamento psicomotorio' + newline + ...
                     '- Intolleranza spiccata al freddo ambientale ed ipotermia basale' + newline + ...
                     '- Aumento di peso corporeo ingiustificato a parità di apporto calorico' + newline + ...
                     '- Bradicardia, ipercolesterolemia, alopecia, stipsi ostinata e mixedema facciale.'];
            ter = 'Il protocollo clinico standard consiste nella terapia sostitutiva ormonale orale quotidiana a vita a base di Levotiroxina sodica (ormone sintetico analogo del T4). L''obiettivo farmacologico è vicariare la funzionalità perduta della tiroide distruttiva, sopprimendo il TSH ipofisario e ripristinando l''eutiroidismo.';
            
        case 'Morbo di Crohn'
            desc = 'Il Morbo di Crohn è una complessa malattia infiammatoria cronica intestinale (MICI) a patogenesi immunitaria. È contraddistinta da un''infiammazione granulomatosa transmurale ad andamento segmentario alternato "a macchia di leopardo", in grado di localizzarsi in qualsiasi distretto del tubo digerente.';
            sint = ['- Dolore addominale cronico localizzato prevalentemente alla fossa iliaca destra' + newline + ...
                     '- Diarrea cronica acquosa o muco-ematica persistente nei mesi' + newline + ...
                     '- Febbre serotina, astenia profonda ed inappetenza marcata' + newline + ...
                     '- Calo ponderale severo dovuto a malassorbimento e sviluppo di complicanze anali.'];
            ter = 'Il trattamento farmacologico si basa sull''uso di antinfiammatori topici localizzati (mesalazina), immunosoppressori sistemici e farmaci biologici avanzati anti-TNF (es. Infliximab) per indurre la remissione clinica. Nei casi complicati da stenosi fibrose serrate o perforazioni fistolose si ricorre alla chirurgia.';
    end

    switch tipoDato
        case 'descrizione', testoSelezionato = desc; align = 'justify';
        case 'sintomi', testoSelezionato = sint; align = 'left';
        case 'terapie', testoSelezionato = ter; align = 'justify';
    end

    % Casella del testo: RIGOROSAMENTE NERO SU BIANCO
    uicontrol('Parent', fig, 'Style', 'text', 'String', testoSelezionato, ...
        'Position', [20, 20, 520, 210], 'FontSize', 11, 'BackgroundColor', 'w', ...
        'ForegroundColor', 'k', 'HorizontalAlignment', align);
end