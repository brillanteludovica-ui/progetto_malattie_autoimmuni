function italia()
    clear; clc; close all;
    
    % =========================================================================
    % GESTIONE AUTOMATICA DEI PERCORSI
    % =========================================================================
    percorsoScript = fileparts(mfilename('fullpath'));
    if ~isempty(percorsoScript), cd(percorsoScript); end
    
    if isfolder("database")
        addpath("database");
        cartellaRicerca = "database";
    else
        cartellaRicerca = ".";
    end
    
    elencoShp = dir(fullfile(cartellaRicerca, "*.shp"));
    if isempty(elencoShp)
        error("Errore: Mappa .shp non trouvata.");
    end
    nomeFileShp = elencoShp(1).name;
    
    elencoExcel = dir(fullfile(".", "*.xlsx")); 
    if isempty(elencoExcel)
        elencoExcel = dir(fullfile(cartellaRicerca, "*.xlsx")); 
    end
    if isempty(elencoExcel)
        elencoExcel = dir(fullfile(".", "*.xls")); 
    end
    if isempty(elencoExcel)
        error("Errore: File Excel non trovato.");
    end
    nomeFileExcel = elencoExcel(1).name;
    
    fprintf('File caricati con successo.\n');
    
    % =========================================================================
    % CARICAMENTO DATI
    % =========================================================================
    regioniShp = shaperead(nomeFileShp); 
    datiExcelTutti = readtable(nomeFileExcel, 'Sheet', 3, 'VariableNamingRule', 'preserve'); 
    
    anniDisponibili = 2018:2025;
    indiceAnnoCorrente = 1; 
    
    nomiColonne = datiExcelTutti.Properties.VariableNames;
    nomeColonnaMalattie = nomiColonne{1}; 
    nomeColonnaAnni = nomiColonne{2};     
    nomeColonnaRegioni = nomiColonne{3};  
    nomeColonnaDati = nomiColonne{4};
    
    nomiMalattieGrezi = unique(datiExcelTutti.(nomeColonnaMalattie));
    if iscell(nomiMalattieGrezi)
        nomiMalattie = nomiMalattieGrezi(~cellfun(@isempty, nomiMalattieGrezi));
    else
        nomiMalattie = cellstr(string(nomiMalattieGrezi));
    end
    indiceMalattiaCorrente = 1; 
    
    if iscell(datiExcelTutti.(nomeColonnaAnni))
        vettoreAnniTutti = str2double(datiExcelTutti.(nomeColonnaAnni));
    else
        vettoreAnniTutti = double(datiExcelTutti.(nomeColonnaAnni));
    end
    
    if iscell(datiExcelTutti.(nomeColonnaDati))
        vettoreDatiTutti = str2double(datiExcelTutti.(nomeColonnaDati));
    else
        vettoreDatiTutti = double(datiExcelTutti.(nomeColonnaDati));
    end
    vettoreDatiTutti(isnan(vettoreDatiTutti)) = 0;
    
    % =========================================================================
    % CREA L'INTERFACCIA GRAFICA
    % =========================================================================
    fig = figure('Name', 'Mappa Epidemiologica - Alta Sensibilita', ...
                 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
                 'Position', [150, 100, 850, 650]);
             
    axMappa = axes('Parent', fig, 'Position', [0.05, 0.20, 0.70, 0.70]);
    
    % Usiamo la mappa 'jet' o 'turbo' per il massimo contrasto visivo
    mappaColori = turbo(256); 
    numColori = size(mappaColori, 1);
    
    colormap(axMappa, mappaColori);
    cb = colorbar(axMappa, 'Position', [0.80, 0.25, 0.03, 0.55]);
    
    uicontrol('Parent', fig, 'Style', 'text', 'String', 'Seleziona Malattia:', ...
        'Position', [480, 25, 120, 20], 'FontSize', 11, 'HorizontalAlignment', 'right');
    uicontrol('Parent', fig, 'Style', 'popupmenu', ...
        'String', nomiMalattie, 'Position', [610, 25, 180, 25], 'FontSize', 11, ...
        'Callback', @cambiaMalattia);
    uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', '<< Indietro', ...
        'Position', [50, 20, 100, 30], 'FontSize', 11, 'Callback', @(~,~) cambiaAnno(-1));
    testoAnno = uicontrol('Parent', fig, 'Style', 'text', ...
        'String', 'Anno: 2018', 'Position', [160, 20, 120, 25], ...
        'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    uicontrol('Parent', fig, 'Style', 'pushbutton', 'String', 'Avanti >>', ...
        'Position', [290, 20, 100, 30], 'FontSize', 11, 'Callback', @(~,~) cambiaAnno(1));
    
    hold(axMappa, 'on');
    
    handlePoligoni = cell(length(regioniShp), 1);
    for i = 1:length(regioniShp)
        handlePoligoni{i} = mapshow(axMappa, regioniShp(i), 'FaceColor', [0.6 0.6 0.6], 'EdgeColor', [0.2 0.2 0.2]);
    end
    axis(axMappa, 'equal');  
    axis(axMappa, 'off'); 

    aggiornaVisualizzazione();
    
    % =========================================================================
    % FUNZIONI INTERNE
    % =========================================================================
    function cambiaMalattia(src, ~)
        indiceMalattiaCorrente = src.Value; 
        aggiornaVisualizzazione();
    end 
    
    function cambiaAnno(direzione)
        nuovoIndice = indiceAnnoCorrente + direzione;
        if nuovoIndice >= 1 && nuovoIndice <= length(anniDisponibili)
            indiceAnnoCorrente = nuovoIndice;
            testoAnno.String = ['Anno: ', num2str(anniDisponibili(indiceAnnoCorrente))];
            aggiornaVisualizzazione();
        end
    end 
    
    function nomePulito = normalizzaNome(nomeGrezzo)
        nomeStr = lower(string(nomeGrezzo));
        if contains(nomeStr, "/")
            parti = split(nomeStr, "/");
            nomeStr = string(parti(1));
        end
        nomePulito = regexprep(nomeStr, "[^a-z0-9]", "");
    end 
    
    function aggiornaVisualizzazione()
        annoAttivo = anniDisponibili(indiceAnnoCorrente);
        malattiaAttiva = nomiMalattie{indiceMalattiaCorrente};
        
        vettoreMalattieTutti = string(datiExcelTutti.(nomeColonnaMalattie));
        righeTutteDellaMalattia = strcmpi(vettoreMalattieTutti, string(malattiaAttiva));
        
        righeAnno = (vettoreAnniTutti == annoAttivo);
        datiFiltratiCorrenti = datiExcelTutti(righeAnno & righeTutteDellaMalattia, :);
        valoriCorrenti = vettoreDatiTutti(righeAnno & righeTutteDellaMalattia);
        regioniCorrenti = string(datiFiltratiCorrenti.(nomeColonnaRegioni));
        
        % ----------------=================================================
        % CUORE DELL'ALTA SENSIBILITÀ: SCALA DINAMICA ANNUALE
        % ----------------=================================================
        minValAnno = min(valoriCorrenti);
        maxValAnno = max(valoriCorrenti);
        
        if isempty(maxValAnno) || maxValAnno == 0
            maxValAnno = 1;
        end
        
        % Applichiamo il logaritmo solo sui valori strettamente positivi
        minLog = log1p(minValAnno);
        maxLog = log1p(maxValAnno);
        
        if exist('clim', 'file')
            clim(axMappa, [minLog maxLog]);
        else
            caxis(axMappa, [minLog maxLog]);
        end
        
        % Generazione dinamica dei tick della legenda basati sull'anno corrente
        puntiTick = linspace(minLog, maxLog, 5);
        valoriConvertiti = expm1(puntiTick);
        valoriArrotondati = round(transpose(valoriConvertiti));
        
        cb.Ticks = puntiTick;
        cb.TickLabels = cellstr(num2str(valoriArrotondati));
        ylabel(cb, 'Casi nell''anno selezionato (Scala Logaritmica Iper-Sensibile)', 'FontSize', 10, 'FontWeight', 'bold');
        
        % Colorazione dei poligoni
        for j = 1:length(regioniShp)
            nomeShpNormalizzato = normalizzaNome(regioniShp(j).DEN_REG);
            indiceTrovato = [];
            
            for m = 1:length(regioniCorrenti)
                if normalizzaNome(regioniCorrenti(m)) == nomeShpNormalizzato
                    indiceTrovato = m;
                    break;
                end
            end
            
            if isempty(indiceTrovato)
                for m = 1:length(regioniCorrenti)
                    excelNorm = normalizzaNome(regioniCorrenti(m));
                    if contains(nomeShpNormalizzato, excelNorm) || contains(excelNorm, nomeShpNormalizzato)
                        indiceTrovato = m;
                        break;
                    end
                end
            end
            
            if ~isempty(indiceTrovato)
                valoreRiga = valoriCorrenti(indiceTrovato);
                
                if valoreRiga == 0
                    % Se i casi sono zero, diamo un colore grigio neutro di fondo
                    coloreRegione = [0.9 0.9 0.9];
                else
                    valLog = log1p(valoreRiga);
                    if maxLog == minLog
                        idx = 1;
                    else
                        idx = round(1 + (numColori-1) * (valLog - minLog) / (maxLog - minLog));
                    end
                    idx = max(1, min(numColori, idx));
                    coloreRegione = mappaColori(idx, :);
                end
            else
                coloreRegione = [0.6 0.6 0.6]; % Regione non trovata nell'Excel
            end
            
            hObj = handlePoligoni{j};
            if isgraphics(hObj)
                if isprop(hObj, 'FaceColor')
                    set(hObj, 'FaceColor', coloreRegione);
                elseif isprop(hObj, 'Children')
                    sottoElementi = hObj.Children;
                    for s = 1:length(sottoElementi)
                        if isprop(sottoElementi(s), 'FaceColor')
                            set(sottoElementi(s), 'FaceColor', coloreRegione);
                        end
                    end
                end
            end
        end
        
        titoloPulito = strrep(malattiaAttiva, '_', ' '); 
        title(axMappa, {['Malattia: ', titoloPulito], ['Distribuzione Casi Totali (Anno ', num2str(annoAttivo), ')']}, ...
            'FontSize', 13, 'FontWeight', 'bold');
    end 

end