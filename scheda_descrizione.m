function scheda_descrizione(idMalattia)
    nomi = {'Sclerosi Multipla', 'Celiachia', 'Diabete Tipo 1', 'Tiroidite di Hashimoto', 'Morbo di Crohn'};
    malattia = nomi{idMalattia};
    
    fig = figure('Name', ['Descrizione - ' malattia], 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', 'Position', [450, 250, 560, 300], 'Color', 'w');
    
    uicontrol('Parent', fig, 'Style', 'text', 'String', ['📄 DESCRIZIONE CLINICA AVANZATA: ' upper(malattia)], ...
        'Position', [20, 245, 520, 30], 'FontSize', 12, 'FontWeight', 'bold', 'BackgroundColor', 'w', ...
        'ForegroundColor', [0.20 0.60 1.00], 'HorizontalAlignment', 'left');
    
    switch malattia
        case 'Sclerosi Multipla'
            t = 'La Sclerosi Multipla è una patologia cronica infiammatoria demielinizzante ad andamento progressivo. Il sistema immunitario attacca per errore la guaina mielinica isolante dei neuroni all''interno del sistema nervoso centrale, determinando la comparsa di placche sclero-cicatriziali diffuse che bloccano o rallentano gravemente la normale conduzione degli impulses bioelettrici lungo gli assoni.';
        case 'Celiachia'
            t = 'La Celiachia è un''enteropatia autoimmune permanente e sistemica, scatenata dall''ingestione di glutine (frazione proteica presente in frumento, orzo e segale) in individui che presentano una chiara predisposizione genetica poligenica legata agli aplotipi HLA-DQ2 e HLA-DQ8. Provoca una massiva reazione immunitaria linfocitaria.';
        case 'Diabete Tipo 1'
            t = 'Il Diabete di Tipo 1 è una severa patologia metabolica cronica indotta da un''anomala distruzione autoimmune organo-specifica. Il sistema immunitario riconosce erroneamente come estranee e demolisce in modo selettivo ed irreversibile las cellule beta dislocate all''interno delle isole di Langerhans pancreatiche, provocando l''instaurarsi di un deficit ormonale assoluto di insulina.';
        case 'Tiroidite di Hashimoto'
            t = 'La Tiroidite di Hashimoto (o tiroidite cronica linfocitaria) è una patologia endocrine autoimmune d''organo. Caratterizzata da una massiva infiltrazione intraparenchimale di linfociti T e B che aggrediscono i tireociti, la malattia determina la progressiva distruzione del tessuto secernente follicolare della ghiandola, conducendo a un quadro clinico di ipotiroidismo.';
        case 'Morbo di Crohn'
            t = 'Il Morbo di Crohn è una complessa malattia infiammatoria cronica intestinale (MICI) a patogenesi immunitaria. È contraddistinta da un''infiammazione granulomatosa transmurale (che interessa cioè l''intero spessore della parete) ad andamento segmentario alternato "a macchia di leopardo", in grado di localizzarsi potenzialmente in qualsiasi distretto del tubo digerente.';
    end
    
    % Sostituito 'justify' con 'left'
    uicontrol('Parent', fig, 'Style', 'text', 'String', t, 'Position', [20, 20, 520, 210], ...
        'FontSize', 11, 'BackgroundColor', 'w', 'ForegroundColor', 'k', 'HorizontalAlignment', 'left');
end