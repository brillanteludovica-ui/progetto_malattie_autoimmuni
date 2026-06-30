function scheda_organi(idMalattia)
    nomi = {'Sclerosi Multipla', 'Celiachia', 'Diabete Tipo 1', 'Tiroidite di Hashimoto', 'Morbo di Crohn'};
    malattia = nomi{idMalattia};

    % Finestra principale spaziosa
    fig = figure('Name', ['Target Anatomici - ' malattia], 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', 'Position', [200, 100, 1000, 550], 'Color', 'w');

    % Configurazione Asse Grafico Bloccato a 480x480 pixel
    ax = axes('Parent', fig, 'Units', 'pixels', 'Position', [30, 25, 480, 480]);
    hold(ax, 'on');

    % CARICAMENTO DIRETTO ED ESCLUSIVO DEL FILE .JPEG
    img = imread('corpo_umano.jpeg');
    imgResized = imresize(img, [480, 480]);
    imshow(imgResized, 'Parent', ax);

    % Impostiamo l'asse da 0 a 480 per i punti grafici
    set(ax, 'XLim', [0 480], 'YLim', [0 480], 'YDir', 'reverse');
    axis(ax, 'off');

    % INTESTAZIONE CLINICA ALLARGATA
    uicontrol('Parent', fig, 'Style', 'text', 'String', ['🫁 TARGET ANATOMICI: ' upper(malattia)], ...
        'Position', [540, 485, 430, 35], 'FontSize', 13, 'FontWeight', 'bold', 'BackgroundColor', 'w', ...
        'ForegroundColor', [0.45, 0.25, 0.70], 'HorizontalAlignment', 'left');

    % MAPPATURA CON ALONE INTERNO E PALLINO PICCOLO E PIENO ALL'ESTERNO
    switch malattia
        case 'Sclerosi Multipla'
            colore = [0.9, 0.1, 0.1]; % Rosso clinico
            
            % --- INTERNAL BODY: ENCEFALO & MIDOLLO (Effetto Alone) ---
            plot(ax, 240, 145, 'o', 'Color', [1 0.6 0.6], 'MarkerSize', 28, 'LineWidth', 1);
            plot(ax, 240, 145, 'o', 'Color', [1 0.4 0.4], 'MarkerSize', 22, 'LineWidth', 1.5);
            plot(ax, 240, 145, 'o', 'Color', colore, 'MarkerSize', 14, 'LineWidth', 2.5);
            
            plot(ax, 240, 220, 'o', 'Color', [1 0.6 0.6], 'MarkerSize', 24, 'LineWidth', 1);
            plot(ax, 240, 220, 'o', 'Color', colore, 'MarkerSize', 12, 'LineWidth', 2);
            
            % --- EXTERNAL ICON: CERVELLO (Pallino piccolo e pieno) ---
            plot(ax, 240, 45, 'ro', 'MarkerFaceColor', colore, 'MarkerSize', 8);
            
            % Scritte Protette
            text(275, 145, ' Encefalo (SNC) ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            text(275, 220, ' Midollo Spinale ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            
            % Corretta la concatenazione che causava l'errore
            testo = ['SISTEMA NERVOSO CENTRALE (SNC)', newline, newline, ...
                     'L''aggressione immunitaria si concentra a scapito degli oligodendrociti, cellule deputate alla sintesi di mielina nel SNC. ', ...
                     'La demielinizzazione focale genera lesioni cicatriziali distribuite nella sostanza bianca cerebrale e spinale. ', ...
                     'Questo altera l''isolamento assonale, interrompendo la conduzione saltatoria dei potenziali d''azione e inducendo degenerazione neuronale cronica.'];

        case 'Celiachia'
            colore = [0.8, 0.0, 0.6]; % Viola
            
            % --- INTERNAL BODY: INTESTINO TENUE (Effetto Alone) ---
            plot(ax, 240, 310, 'o', 'Color', [1 0.6 0.9], 'MarkerSize', 28, 'LineWidth', 1);
            plot(ax, 240, 310, 'o', 'Color', [1 0.3 0.8], 'MarkerSize', 22, 'LineWidth', 1.5);
            plot(ax, 240, 310, 'o', 'Color', colore, 'MarkerSize', 14, 'LineWidth', 2.5);
            
            % --- EXTERNAL ICON: INTESTINO (Pallino piccolo e pieno) ---
            plot(ax, 410, 410, 'mo', 'MarkerFaceColor', colore, 'MarkerSize', 8);
            
            text(275, 310, ' Mucosa Intestinale ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            
            testo = ['APPARATO DIGERENTE: INTESTINO TENUE', newline, newline, ...
                     'L''interazione tra gliadina e l''enzima transglutaminasi tessutale (tTG) evoca una risposta immunitaria cellulo-mediata nei soggetti predisposti. ', ...
                     'I linfociti T infiltrano la lamina propria inducendo un''infiammazione cronica distruttiva che causa l''iperplasia delle cripte e la totale atrofia dei villi intestinali. ', ...
                     'La perdita dell''architettura mucosa annulla la capacità assorbente dell''organo.'];

        case 'Diabete Tipo 1'
            colore = [0.0, 0.4, 0.8]; % Blu
            
            % --- INTERNAL BODY: ISOLE PANCREATICHE (Effetto Alone) ---
            plot(ax, 245, 290, 'o', 'Color', [0.6 0.8 1], 'MarkerSize', 28, 'LineWidth', 1);
            plot(ax, 245, 290, 'o', 'Color', [0.3 0.6 1], 'MarkerSize', 22, 'LineWidth', 1.5);
            plot(ax, 245, 290, 'o', 'Color', colore, 'MarkerSize', 14, 'LineWidth', 2.5);
            
            % --- EXTERNAL ICON: PANCREAS (Pallino piccolo e pieno) ---
            plot(ax, 85, 290, 'bo', 'MarkerFaceColor', colore, 'MarkerSize', 8);
            
            text(275, 290, ' Isole di Langerhans ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            
            testo = ['SISTEMA ENDOCRINO: PANCREAS (COMPONENTE ENDOCRINA)', newline, newline, ...
                     'Il processo patologico colpisce in modo organo-specifico le Isole di Langerhans dislocate nel parenchima pancreatico. ', ...
                     'Un massivo infiltrato linfocitario (insulite cronica) bersaglia e distrugge per via apoptotica las cellule beta deputate alla biosintesi dell''insulina. ', ...
                     'La perdita della quasi totalità della massa beta azzera la produzione ormonale endogena, scatenando un''iperglicemia tossica sistemica.'];

        case 'Tiroidite di Hashimoto'
            colore = [0.1, 0.6, 0.2]; % Verde
            
            % --- INTERNAL BODY: GHIANDOLA TIROIDE (Effetto Alone) ---
            plot(ax, 240, 195, 'o', 'Color', [0.6 1 0.7], 'MarkerSize', 28, 'LineWidth', 1);
            plot(ax, 240, 195, 'o', 'Color', [0.3 0.8 0.4], 'MarkerSize', 22, 'LineWidth', 1.5);
            plot(ax, 240, 195, 'o', 'Color', colore, 'MarkerSize', 14, 'LineWidth', 2.5);
            
            % --- EXTERNAL ICON: TIROIDE (Pallino piccolo e pieno) ---
            plot(ax, 145, 75, 'go', 'MarkerFaceColor', colore, 'MarkerSize', 8);
            
            text(275, 195, ' Follicoli Tiroidei ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            
            testo = ['SISTEMA ENDOCRINO: GHIANDOLA TIROIDE', newline, newline, ...
                     'La reazione autoimmune colpisce l''architettura cellulare follicolare della tiroide, situata nella regione anteriore del collo. ', ...
                     'Gli autoanticorpi specifici (Anti-TPO e Anti-TG) e l''aggressione mediata dai linfociti T citotossici distruggono progressivamente i tireociti. ', ...
                     'Il tessuto secernente viene sostituito da un''infiltrazione fibrosa, esaurendo le riserves di ormoni T3 e T4 e sfociando in ipotiroidismo.'];

        case 'Morbo di Crohn'
            colore = [0.0, 0.5, 0.6]; % Ottanio
            
            % --- INTERNAL BODY: ILEO TERMINALE E COLON (Effetto Alone) ---
            plot(ax, 240, 335, 'o', 'Color', [0.6 0.9 1], 'MarkerSize', 28, 'LineWidth', 1);
            plot(ax, 240, 335, 'o', 'Color', [0.3 0.7 0.8], 'MarkerSize', 22, 'LineWidth', 1.5);
            plot(ax, 240, 335, 'o', 'Color', colore, 'MarkerSize', 14, 'LineWidth', 2.5);
            
            % --- EXTERNAL ICON: COLON (Pallino piccolo e pieno) ---
            plot(ax, 410, 410, 'co', 'MarkerFaceColor', colore, 'MarkerSize', 8);
            
            text(275, 335, ' Infiammazione Transmurale ', 'Parent', ax, 'Color', colore, ...
                'FontWeight', 'bold', 'FontSize', 10, 'BackgroundColor', 'w', 'EdgeColor', colore);
            
            testo = ['APPARATO DIGERENTE: PARETE INTESTINALE TRANSMURALE', newline, newline, ...
                     'A differenza di altre MICI, l''aggressione immunitaria si manifesta in modo discontinuo lungo l''intero spessore della parete enterica (mucosa, sottomucosa, muscolare e sierosa). ', ...
                     'Pur potendosi estendere a tutto il tubo digerente, colpisce prevalentemente l''ileo terminale e il colon. ', ...
                     'L''infiammazione transmurale profonda altera la barriera intestinale determinando ulcere stenosanti ostruttive e fistole penetranti.'];
    end

    % Casella di testo esplicativo a destra (Nero nitido su Bianco)
    uicontrol('Parent', fig, 'Style', 'text', 'String', testo, ...
        'Position', [540, 30, 430, 435], 'FontSize', 11, 'BackgroundColor', 'w', ...
        'ForegroundColor', 'k', 'HorizontalAlignment', 'left');
end