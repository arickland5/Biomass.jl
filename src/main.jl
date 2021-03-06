# General Settings
if Sys.iswindows()
    # Icons path on Windows
    global ico1 = joinpath(dirname(Base.source_path()), "icons\\icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons\\icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons\\icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons\\icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons\\icon_help.ico")
    global ico6 = joinpath(dirname(Base.source_path()), "icons\\icon_open.ico")
    global ico7 = joinpath(dirname(Base.source_path()), "icons\\icon_save.ico")
    global ico8 = joinpath(dirname(Base.source_path()), "icons\\icon_run.ico")
end

if Sys.islinux()
    # Icons path on Linux
    global ico1 = joinpath(dirname(Base.source_path()), "icons/icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons/icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons/icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons/icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons/icon_help.ico")
    global ico6 = joinpath(dirname(Base.source_path()), "icons/icon_open.ico")
    global ico7 = joinpath(dirname(Base.source_path()), "icons/icon_save.ico")
    global ico8 = joinpath(dirname(Base.source_path()), "icons/icon_run.ico")
end

# TODO: check compatibility to macOS

function mainPI()
    ENV["GTK_CSD"] = 0

    # Measurement of screen size to allow compatibility to all screen devices
    global w, h = screen_size()

    # Main win
    mainPIWin = Window()
    # Properties for mainWin
    set_gtk_property!(mainPIWin, :title, "Interfase Biomass")
    set_gtk_property!(mainPIWin, :window_position, 3)
    set_gtk_property!(mainPIWin, :accept_focus, true)
    set_gtk_property!(mainPIWin, :resizable, false)
    set_gtk_property!(mainPIWin, :width_request, h * 1.0)
    set_gtk_property!(mainPIWin, :height_request, h * 0.70 - 10)
    set_gtk_property!(mainPIWin, :visible, false)

    ####################################################################################################################
    # Toolbar
    ####################################################################################################################
    # Menu Icons
    newToolbar = ToolButton("")
    newToolbarImg = Image()
    set_gtk_property!(newToolbarImg, :file, ico1)
    set_gtk_property!(newToolbar, :icon_widget, newToolbarImg)
    set_gtk_property!(newToolbar, :label, "New")
    set_gtk_property!(newToolbar, :tooltip_markup, "New case study")

    pdfToolbar = ToolButton("")
    pdfToolbarImg = Image()
    set_gtk_property!(pdfToolbarImg, :file, ico2)
    set_gtk_property!(pdfToolbar, :icon_widget, pdfToolbarImg)
    set_gtk_property!(pdfToolbar, :label, "Export")
    set_gtk_property!(pdfToolbar, :tooltip_markup, "Export")
    set_gtk_property!(pdfToolbar, :sensitive, false)

    runToolbar = ToolButton("")
    runToolbarImg = Image()
    set_gtk_property!(runToolbarImg, :file, ico8)
    set_gtk_property!(runToolbar, :icon_widget, runToolbarImg)
    set_gtk_property!(runToolbar, :label, "Solve")
    set_gtk_property!(runToolbar, :tooltip_markup, "Solve")
    set_gtk_property!(runToolbar, :sensitive, true)

    settingsToolbar = ToolButton("")
    settingsToolbarImg = Image()
    set_gtk_property!(settingsToolbarImg, :file, ico4)
    set_gtk_property!(settingsToolbar, :icon_widget, settingsToolbarImg)
    set_gtk_property!(settingsToolbar, :label, "Settings")
    set_gtk_property!(settingsToolbar, :tooltip_markup, "Settings")

    closeToolbar = ToolButton("")
    closeToolbarImg = Image()
    set_gtk_property!(closeToolbarImg, :file, ico3)
    set_gtk_property!(closeToolbar, :icon_widget, closeToolbarImg)
    set_gtk_property!(closeToolbar, :label, "Close")
    set_gtk_property!(closeToolbar, :tooltip_markup, "Close")
    signal_connect(closeToolbar, :clicked) do widget
        destroy(mainPIWin)
    end

    signal_connect(mainPIWin, "key-press-event") do widget, event
        if event.keyval == 65307
            destroy(mainPIWin)
        end
    end

    helpToolbar = ToolButton("")
    helpToolbarImg = Image()
    set_gtk_property!(helpToolbarImg, :file, ico5)
    set_gtk_property!(helpToolbar, :icon_widget, helpToolbarImg)
    set_gtk_property!(helpToolbar, :label, "Help")
    set_gtk_property!(helpToolbar, :tooltip_markup, "Help")

    openToolbar = ToolButton("")
    openToolbarImg = Image()
    set_gtk_property!(openToolbarImg, :file, ico6)
    set_gtk_property!(openToolbar, :icon_widget, openToolbarImg)
    set_gtk_property!(openToolbar, :label, "Open")
    set_gtk_property!(openToolbar, :tooltip_markup, "Open")

    saveToolbar = ToolButton("")
    saveToolbarImg = Image()
    set_gtk_property!(saveToolbarImg, :file, ico7)
    set_gtk_property!(saveToolbar, :icon_widget, saveToolbarImg)
    set_gtk_property!(saveToolbar, :label, "Save")
    set_gtk_property!(saveToolbar, :tooltip_markup, "Save")
    set_gtk_property!(saveToolbar, :sensitive, false)

    # Toolbar
    mainToolbar = Toolbar()
    set_gtk_property!(mainToolbar, :height_request, (h * 0.70) * 0.10)
    set_gtk_property!(mainToolbar, :toolbar_style, 2)
    push!(mainToolbar, newToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, openToolbar)
    push!(mainToolbar, pdfToolbar)
    push!(mainToolbar, saveToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, runToolbar)
    push!(mainToolbar, settingsToolbar)
    push!(mainToolbar, helpToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, closeToolbar)

    # Main grid
    mainGrid = Grid()
    set_gtk_property!(mainGrid, :column_homogeneous, true)
    set_gtk_property!(mainGrid, :row_homogeneous, false)

    gridToolbar = Grid()
    set_gtk_property!(gridToolbar, :column_homogeneous, true)
    set_gtk_property!(gridToolbar, :row_homogeneous, false)

    frameToolbar = Frame()
    push!(frameToolbar, mainToolbar)
    gridToolbar[1, 1] = frameToolbar

    bGrid = Grid()
    set_gtk_property!(bGrid, :column_spacing, 0)
    set_gtk_property!(bGrid, :row_spacing, 0)
    set_gtk_property!(bGrid, :margin_top, 0)
    set_gtk_property!(bGrid, :margin_bottom, 0)
    set_gtk_property!(bGrid, :margin_left, 0)
    set_gtk_property!(bGrid, :margin_right, 0)

    # Main notebook
    mainNotebook = Notebook()

    # Height for notebook
    hNb = (h * 0.70) - (h * 0.70) * 0.10 - 40

    ####################################################################################################################
    # Setting frame
    ####################################################################################################################
    settingFrame = Frame()
    set_gtk_property!(settingFrame, :height_request, hNb)
    set_gtk_property!(settingFrame, :width_request, h)

    settingGrid = Grid()
    set_gtk_property!(settingGrid, :column_spacing, 10)
    set_gtk_property!(settingGrid, :row_spacing, 10)
    set_gtk_property!(settingGrid, :margin_top, 10)
    set_gtk_property!(settingGrid, :margin_bottom, 10)
    set_gtk_property!(settingGrid, :margin_left, 10)
    set_gtk_property!(settingGrid, :margin_right, 10)

    settingGridLeft = Grid()
    set_gtk_property!(settingGridLeft, :row_spacing, 5)

    settingGridRight = Grid()
    set_gtk_property!(settingGridRight, :row_spacing, 5)

    ####################################################################################################################
    # Base Case Design
    ####################################################################################################################
    global idxBC = 1
    global idxEq = zeros(1, idxBC)
    global dictBC = Dict()

    baseCaseFrame = Frame(" Process ")
    set_gtk_property!(baseCaseFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(baseCaseFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(baseCaseFrame, :label_xalign, 0.50)

    baseCaseGrid = Grid()
    set_gtk_property!(baseCaseGrid, :column_spacing, 10)
    set_gtk_property!(baseCaseGrid, :row_spacing, 10)
    set_gtk_property!(baseCaseGrid, :margin_top, 5)
    set_gtk_property!(baseCaseGrid, :margin_bottom, 10)
    set_gtk_property!(baseCaseGrid, :margin_left, 10)
    set_gtk_property!(baseCaseGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    baseCaseFrameTree = Frame()
    set_gtk_property!(baseCaseFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(baseCaseFrameTree, :width_request, wBC - 20)
    baseCaseScroll = ScrolledWindow()
    push!(baseCaseFrameTree, baseCaseScroll)

    # Table for Case Design
    baseCaseList = ListStore(String, String, String, String, String, String)

    # Visual Table for Case Design
    baseCaseTreeView = TreeView(TreeModel(baseCaseList))
    set_gtk_property!(baseCaseTreeView, :reorderable, true)
    set_gtk_property!(baseCaseTreeView, :enable_grid_lines, 3)
    set_gtk_property!(baseCaseTreeView, :activate_on_single_click, true)
    selBC = Gtk.GAccessor.selection(baseCaseTreeView)
    selBC = Gtk.GAccessor.mode(selBC, Gtk.GConstants.GtkSelectionMode.SINGLE)

    # Set selectable
    selmodelBaseCase = G_.selection(baseCaseTreeView)

    renderTxt1 = CellRendererText()
    renderTxt2 = CellRendererText()
    set_gtk_property!(renderTxt1, :editable, true)
    set_gtk_property!(renderTxt2, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt2, Dict([("text", 0)]))
    c2 = TreeViewColumn("Name", renderTxt1, Dict([("text", 1)]))
    c3 = TreeViewColumn("Process", renderTxt2, Dict([("text", 2)]))
    c4 = TreeViewColumn("Raw material", renderTxt2, Dict([("text", 3)]))
    c5 = TreeViewColumn("Criterion", renderTxt2, Dict([("text", 4)]))
    c6 = TreeViewColumn("Status", renderTxt2, Dict([("text", 5)]))

    signal_connect(renderTxt1, "edited") do widget, path, text
        idxTree = parse(Int, path)

        if baseCaseList[idxTree + 1, 2] != text
            t = zeros(1, length(baseCaseList))
            for i=1:length(baseCaseList)
                t[i] = text == baseCaseList[i,2]
            end

            if sum(t) == 1
                warn_dialog("Name for base case design is already in use!", mainPIWin)
            else
                currentID = selected(selmodelBaseCase)
                dictBC["$(text)"] = pop!(dictBC, "$(baseCaseList[currentID, 2])")
                dictEq["$(text)"] = pop!(dictEq, "$(baseCaseList[currentID, 2])")
                dictMet["$(text)"] = pop!(dictMet, "$(baseCaseList[currentID, 2])")
                dictCriteriaM["$(text)"] = pop!(dictCriteriaM, "$(baseCaseList[currentID, 2])")
                baseCaseList[idxTree + 1, 2] = text
            end
        end
    end

    signal_connect(baseCaseTreeView, :row_activated) do widget, path, column
        currentID = selected(selmodelBaseCase)
        set_gtk_property!(addEq, :sensitive, true)
        set_gtk_property!(helpEq, :sensitive, true)
        set_gtk_property!(addMet, :sensitive, true)
        set_gtk_property!(helpMet, :sensitive, true)
        set_gtk_property!(addCr, :sensitive, true)
        set_gtk_property!(helpCr, :sensitive, true)

        empty!(processList)
        empty!(rawmaterialList)
        empty!(criterionList)

        newSel = length(dictEq["$(baseCaseList[currentID, 2])"])
        if newSel != 0
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)
        else
            set_gtk_property!(clearEq, :sensitive, false)
            set_gtk_property!(deleteEq, :sensitive, false)
        end

        for i = 1:newSel
            push!(
                processList,
                (
                dictEq["$(baseCaseList[currentID, 2])"][i][1],
                dictEq["$(baseCaseList[currentID, 2])"][i][2],
                dictEq["$(baseCaseList[currentID, 2])"][i][3],
                ),
            )
        end

        newSelMet = length(dictMet["$(baseCaseList[currentID, 2])"])
        if newSelMet != 0
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)
        else
            set_gtk_property!(clearMet, :sensitive, false)
            set_gtk_property!(deleteMet, :sensitive, false)
        end

        for i = 1:newSelMet
            push!(
                rawmaterialList,
                (
                dictMet["$(baseCaseList[currentID, 2])"][i][1],
                dictMet["$(baseCaseList[currentID, 2])"][i][2],
                dictMet["$(baseCaseList[currentID, 2])"][i][3],
                dictMet["$(baseCaseList[currentID, 2])"][i][4],
                ),
            )
        end

        newSelCr = length(dictCriteriaM["$(baseCaseList[currentID, 2])"])
        if newSelCr != 0
            set_gtk_property!(clearCr, :sensitive, true)
            set_gtk_property!(deleteCr, :sensitive, true)
        else
            set_gtk_property!(clearCr, :sensitive, false)
            set_gtk_property!(deleteCr, :sensitive, false)
        end

        for i = 1:newSelCr
            push!(
                criterionList,
                (
                dictCriteriaM["$(baseCaseList[currentID, 2])"][i][1],
                dictCriteriaM["$(baseCaseList[currentID, 2])"][i][2],
                dictCriteriaM["$(baseCaseList[currentID, 2])"][i][3],
                ),
            )
        end
    end

    # Allows to select rows
    for c in [c1, c2, c3, c4, c5, c6]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(baseCaseTreeView, c1, c2, c3, c4, c5, c6)
    push!(baseCaseScroll, baseCaseTreeView)

    baseCaseGrid[1:3, 1] = baseCaseFrameTree

    # Buttons for base case design
    addBC = Button("Add")
    set_gtk_property!(addBC, :width_request, (wBC - 5*10)/4)
    signal_connect(addBC, :clicked) do widget
        global idxBC

        # Set default name
        baseCaseName = @sprintf("Base Case_%i", idxBC)

        if length(baseCaseList) == 0
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)

            dictBC["$(baseCaseName)"] = []
            dictEq["$(baseCaseName)"] = []
            dictMet["$(baseCaseName)"] = []
            dictCriteriaM["$(baseCaseName)"] = []
            global idxBC += 1
            global idxEq = zeros(1, idxBC)
        else
            t = zeros(1, length(baseCaseList))
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)

            dictBC["$(baseCaseName)"] = []
            dictEq["$(baseCaseName)"] = []
            dictMet["$(baseCaseName)"] = []
            dictCriteriaM["$(baseCaseName)"] = []

            global idxBC += 1
            global idxEq = zeros(1, idxBC)
        end
    end

    deleteBC = Button("Delete")
    set_gtk_property!(deleteBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteBC, :sensitive, false)
    signal_connect(deleteBC, :clicked) do widget
        if hasselection(selBC)
            currentID = selected(selBC)
            delete!(dictBC, baseCaseList[currentID, 2])
            delete!(dictEq, baseCaseList[currentID, 2])
            delete!(dictMet, baseCaseList[currentID, 2])
            delete!(dictCriteriaM, baseCaseList[currentID, 2])
            deleteat!(baseCaseList, currentID)
            empty!(processList)
            empty!(rawmaterialList)
            empty!(criterionList)

            if length(baseCaseList) > 0
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            end

            if length(baseCaseList)==0
                global idxBC = 1
                empty!(baseCaseList)
                empty!(processList)
                empty!(rawmaterialList)
                empty!(criterionList)
                set_gtk_property!(clearBC, :sensitive, false)
                set_gtk_property!(clearEq, :sensitive, false)
                set_gtk_property!(deleteBC, :sensitive, false)
                set_gtk_property!(deleteEq, :sensitive, false)
                set_gtk_property!(saveToolbar, :sensitive, false)
                set_gtk_property!(pdfToolbar, :sensitive, false)
                set_gtk_property!(addEq, :sensitive, false)
                set_gtk_property!(helpEq, :sensitive, false)
                set_gtk_property!(addMet, :sensitive, false)
                set_gtk_property!(helpMet, :sensitive, false)
                set_gtk_property!(deleteMet, :sensitive, false)
                set_gtk_property!(clearMet, :sensitive, false)
                set_gtk_property!(equitMetNotebook, :page, 0)
                set_gtk_property!(addCr, :sensitive, false)
                set_gtk_property!(helpCr, :sensitive, false)
                set_gtk_property!(deleteCr, :sensitive, false)
                set_gtk_property!(clearCr, :sensitive, false)
            end
            global idxEq = zeros(1, idxBC)
        end
    end

    clearBC = Button("Clear")
    set_gtk_property!(clearBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearBC, :sensitive, false)
    signal_connect(clearBC, :clicked) do widget
        empty!(baseCaseList)
        empty!(processList)
        empty!(rawmaterialList)
        empty!(criterionList)
        set_gtk_property!(clearBC, :sensitive, false)
        set_gtk_property!(clearEq, :sensitive, false)
        set_gtk_property!(deleteBC, :sensitive, false)
        set_gtk_property!(deleteEq, :sensitive, false)
        set_gtk_property!(saveToolbar, :sensitive, false)
        set_gtk_property!(pdfToolbar, :sensitive, false)
        set_gtk_property!(addEq, :sensitive, false)
        set_gtk_property!(helpEq, :sensitive, false)
        set_gtk_property!(addMet, :sensitive, false)
        set_gtk_property!(helpMet, :sensitive, false)
        set_gtk_property!(deleteMet, :sensitive, false)
        set_gtk_property!(clearMet, :sensitive, false)
        set_gtk_property!(addCr, :sensitive, false)
        set_gtk_property!(helpCr, :sensitive, false)
        set_gtk_property!(equitMetNotebook, :page, 0)
        set_gtk_property!(deleteCr, :sensitive, false)
        set_gtk_property!(clearCr, :sensitive, false)

        global dictBC = Dict()
        global dictEq = Dict()
        global dictMet = Dict()
        global dictCriteriaM = Dict()
        global idxBC = 1
    end

    baseCaseGrid[1, 2] = addBC
    baseCaseGrid[2, 2] = deleteBC
    baseCaseGrid[3, 2] = clearBC

    push!(baseCaseFrame, baseCaseGrid)

    ## Notebook for Process and Raw Material ############################################################################
    equitMetFrame = Frame()
    if Sys.iswindows()
        set_gtk_property!(equitMetFrame, :height_request, (hNb - 30)/2 - 3)
    else
        set_gtk_property!(equitMetFrame, :height_request, (hNb - 30)/2 - 21)
    end

    set_gtk_property!(equitMetFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(equitMetFrame, :margin_top, 10)

    equitMetNotebook = Notebook()
    push!(equitMetFrame, equitMetNotebook)
    ####################################################################################################################

    # Process ########################################################################################################
    global listEqPhenomena = DataFrames.DataFrame(ID = Float64[], Name = String[], Phenomena = Array[])
    global dictEq = Dict()

    # Add avilable aquipments and phenomenas
    push!(listEqPhenomena, (1, "Jet Fuel",["JF"]))
    push!(listEqPhenomena, (2, "Semi-Batch Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (3, "CSTR Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (4, "PFR Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (5, "Pack-Bed Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (6, "Flash Column", ["2phM", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (7, "Distillation Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (8, "Azeotropic Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (9, "Extractive Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (10, "Absorption Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (11, "Stripping Column", ["2phM", "H", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (12, "Crystallization", ["2phM", "C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (13, "Liquid-Liquid Extraction", ["M", " PC", "PS"]))
    push!(listEqPhenomena, (14, "Membrane Pervaporation", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (15, "Membrane Reactor", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (16, "Reactive Distillation", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (17, "Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (18, "Reactive Divided Wall Column", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (19, "Azeotropic Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (20, "Azeotropic Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (21, "Azeotropic Divided Wall Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (22, "Extractive Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (23, "Extractive Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (24, "Extractive Divided Wall Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (25, "Absorption Column witn Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (26, "Stripping Column with Reaction", ["2phM", "H", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (27, "Liquid-Liquid Extraction with Reaction", ["M", "R", "PC", "PS"]))
    push!(listEqPhenomena, (28, "Reactive Crystallization", ["2phM", "R", "C", "PC", "PT", "PS"]))

    processFrame = Frame()
    set_gtk_property!(processFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(processFrame, :label_xalign, 0.50)

    processGrid = Grid()
    set_gtk_property!(processGrid, :column_spacing, 10)
    set_gtk_property!(processGrid, :row_spacing, 10)
    set_gtk_property!(processGrid, :margin_top, 5)
    set_gtk_property!(processGrid, :margin_bottom, 10)
    set_gtk_property!(processGrid, :margin_left, 10)
    set_gtk_property!(processGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    processFrameTree = Frame()

    if Sys.iswindows()
        set_gtk_property!(processFrameTree, :height_request, (hNb - 30)/2 - 110)
    else
        set_gtk_property!(processFrameTree, :height_request, (hNb - 30)/2 - 101)
    end

    set_gtk_property!(processFrameTree, :width_request, wBC - 20)
    set_gtk_property!(processFrameTree, :margin_top, 5)
    processScroll = ScrolledWindow()
    push!(processFrameTree, processScroll)

    # Table for Case Design
    processList = ListStore(String, String, String)

    # Visual Table for Case Design
    processTreeView = TreeView(TreeModel(processList))
    set_gtk_property!(processTreeView, :reorderable, true)
    set_gtk_property!(processTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelprocess = G_.selection(processTreeView)

    renderTxt3 = CellRendererText()
    renderTxt4 = CellRendererText()

    set_gtk_property!(renderTxt3, :editable, true)
    set_gtk_property!(renderTxt4, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt3, Dict([("text", 0)]))
    c2 = TreeViewColumn("Process", renderTxt4, Dict([("text", 1)]))
    c3 = TreeViewColumn("Phenomena", renderTxt4, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(processTreeView, c1, c2, c3)
    push!(processScroll, processTreeView)

    processGrid[1:4, 1] = processFrameTree

    # Edited
    signal_connect(renderTxt3, "edited") do widget, path, text
        idxTreeEq = parse(Int, path) + 1
        idxIDEq = parse(Int, text)

        if idxIDEq >= 1 && idxIDEq <= 28
            processList[idxTreeEq, 1] = text
            processList[idxTreeEq, 2] = listEqPhenomena[idxIDEq, 2]
            processList[idxTreeEq, 3] = string(listEqPhenomena[idxIDEq, 3])

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(processList))
            for i = 1:length(processList)
                push!(
                    dictEq["$(baseCaseList[newidxBC,2])"],
                    (processList[i, 1], processList[i, 2], processList[i, 3]),
                    )

                    if processList[i, 1] == "not specified"
                        testEq[i] = 1
                    end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(processList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Process = %i, Complete", length(processList))
                end
            end

        else
            warn_dialog("No process specified for option $(idxIDEq), see Help", mainPIWin)
        end
    end

    # Buttons for base case design
    addEq = Button("Add")
    set_gtk_property!(addEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addEq, :sensitive, false)
    signal_connect(addEq, :clicked) do widget
         push!(processList, ("not specified", "not specified", "not specified"))
         set_gtk_property!(clearEq, :sensitive, true)
         set_gtk_property!(deleteEq, :sensitive, true)

         newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
         push!(dictEq["$(baseCaseList[newidxBC,2])"], ("not specified", "not specified", "not specified"))

         newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
         baseCaseList[newidxBC, 3] = "Incomplete"
    end

    deleteEq = Button("Delete")
    set_gtk_property!(deleteEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteEq, :sensitive, false)
    signal_connect(deleteEq, :clicked) do widget
        if hasselection(selmodelprocess)
            currentID = selected(selmodelprocess)
            newidxBC = Gtk.index_from_iter(processList, selected(selmodelprocess))
            deleteat!(processList, currentID)

            currentIDBC = selected(selBC)
            nameBCSel = baseCaseList[currentIDBC, 2]
            dictEq[nameBCSel] = deleteat!(dictEq[nameBCSel], newidxBC)

            if length(processList)==0
                set_gtk_property!(deleteEq, :sensitive, false)
                set_gtk_property!(clearEq, :sensitive, false)
            end

            if length(processList) < 2
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
                baseCaseList[newidxBC, 3] = "Incomplete"
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(processList))
            for i = 1:length(processList)
                push!(
                    dictEq["$(baseCaseList[newidxBC,2])"],
                    (processList[i, 1], processList[i, 2], processList[i, 3]),
                    )

                    if processList[i, 1] == "not specified"
                        testEq[i] = 1
                    end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(processList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Proccess= %i, Complete", length(processList))
                end
            end

        end
    end

    clearEq = Button("Clear")
    set_gtk_property!(clearEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearEq, :sensitive, false)
    signal_connect(clearEq, :clicked) do widget
        currentIDBC = selected(selBC)
        nameBCSel = baseCaseList[currentIDBC, 2]
        dictEq[nameBCSel] = []
        empty!(processList)
        set_gtk_property!(clearEq, :sensitive, false)
        set_gtk_property!(deleteEq, :sensitive, false)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
        baseCaseList[newidxBC, 3] = "Incomplete"
    end

    helpEq = Button("Help")
    set_gtk_property!(helpEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpEq, :sensitive, false)
    signal_connect(helpEq, :clicked) do widget
        # Process Help Win
        eqHelpWin = Window()
        set_gtk_property!(eqHelpWin, :title, "Process Help")
        set_gtk_property!(eqHelpWin, :window_position, 3)
        set_gtk_property!(eqHelpWin, :accept_focus, true)
        set_gtk_property!(eqHelpWin, :resizable, false)
        set_gtk_property!(eqHelpWin, :width_request, h/2.5)

            eqFrameHelp = Frame("Process evailable")
        set_gtk_property!(eqFrameHelp, :label_xalign, 0.5)
        set_gtk_property!(eqFrameHelp, :margin_top, 5)
        set_gtk_property!(eqFrameHelp, :margin_bottom, 10)
        set_gtk_property!(eqFrameHelp, :margin_left, 10)
        set_gtk_property!(eqFrameHelp, :margin_right, 10)

        eqGridHelp = Grid()
        set_gtk_property!(eqGridHelp, :column_spacing, 10)
        set_gtk_property!(eqGridHelp, :row_spacing, 10)
        set_gtk_property!(eqGridHelp, :margin_top, 5)
        set_gtk_property!(eqGridHelp, :margin_bottom, 10)
        set_gtk_property!(eqGridHelp, :margin_left, 10)
        set_gtk_property!(eqGridHelp, :margin_right, 10)

        eqFrameTree = Frame()
        set_gtk_property!(eqFrameTree, :width_request, h/2.5 - 20)
        set_gtk_property!(eqFrameTree, :height_request, h/2 - 30 - 60)

        eqScroll = ScrolledWindow()
        push!(eqFrameTree, eqScroll)

        # Table for Process help
        eqList = ListStore(Int, String, String)

        # Load data from listEqPhenomena

        for i=1:size(listEqPhenomena)[1]
            push!(eqList, (listEqPhenomena[i,1], listEqPhenomena[i,2], string(listEqPhenomena[i,3])))
        end

        # Visual Table for Process help
        eqTreeView = TreeView(TreeModel(eqList))
        set_gtk_property!(eqTreeView, :reorderable, true)
        set_gtk_property!(eqTreeView, :enable_grid_lines, 3)

        # Set selectable
        selEqHelp = Gtk.GAccessor.selection(eqTreeView)
        selEqHelp = Gtk.GAccessor.mode(selEqHelp, Gtk.GConstants.GtkSelectionMode.SINGLE)
        selEqHelp = G_.selection(eqTreeView)

        renderTxteq = CellRendererText()
        set_gtk_property!(renderTxteq, :editable, false)

        c1 = TreeViewColumn("ID", renderTxteq, Dict([("text", 0)]))
        c2 = TreeViewColumn("Process", renderTxteq, Dict([("text", 1)]))
        c3 = TreeViewColumn("Phenomena", renderTxteq, Dict([("text", 2)]))

        # Allows to select rows
        for c in [c1, c2, c3]
            Gtk.GAccessor.resizable(c, true)
        end

        push!(eqTreeView, c1, c2, c3)
        push!(eqScroll, eqTreeView)

        eqClose = Button("Close")
        set_gtk_property!(eqClose, :label, "Close")
        set_gtk_property!(eqClose, :tooltip_markup, "Close")
        signal_connect(eqClose, :clicked) do widget
            destroy(eqHelpWin)
        end

        eqAdd = Button("Add")
        set_gtk_property!(eqAdd, :label, "Add")
        set_gtk_property!(eqAdd, :tooltip_markup, "Add")
        signal_connect(eqAdd, :clicked) do widget
            currentID = selected(selEqHelp)
            push!(processList, (eqList[currentID, 1], eqList[currentID, 2], eqList[currentID, 3]))
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(processList))
            for i = 1:length(processList)
                push!(dictEq["$(baseCaseList[newidxBC,2])"], (processList[i, 1], processList[i, 2], processList[i, 3]))

                if processList[i, 1] == "not specified"
                    testEq[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(processList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Process = %i, Complete", length(processList))
                end
            end
        end

        signal_connect(eqTreeView, :row_activated) do widget, path, column
            currentID = selected(selEqHelp)
            push!(processList, (eqList[currentID,1], eqList[currentID,2], eqList[currentID,3]))
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(processList))
            for i = 1:length(processList)
                push!(dictEq["$(baseCaseList[newidxBC,2])"], (processList[i, 1], processList[i, 2], processList[i, 3]))

                if processList[i, 1] == "not specified"
                    testEq[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(processList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Process= %i, Complete", length(processList))
                end
            end
        end

        eqGridHelp[1, 2] = eqAdd
        eqGridHelp[2, 2] = eqClose
        eqGridHelp[1:2, 1] = eqFrameTree
        push!(eqFrameHelp, eqGridHelp)
        push!(eqHelpWin, eqFrameHelp)
        Gtk.showall(eqHelpWin)
    end

    processGrid[1, 2] = addEq
    processGrid[2, 2] = deleteEq
    processGrid[3, 2] = clearEq
    processGrid[4, 2] = helpEq

    push!(processFrame, processGrid)
    ####################################################################################################################

    # Rawmaterial ##########################################################################################################
    global listMet = DataFrames.DataFrame(ID = Int[], RawMaterial = String[], Symbol = String[], Value = String[])
    global dictMet = Dict()

    # Add avilable aquipments and phenomenas
    push!(listMet, (1, "Palm oil", "PO", "not specified"))
    push!(listMet, (2, "Hydrogen", "H2", "not specified"))
    push!(listMet, (3, "Utility cost", "UC", "not specified"))
    push!(listMet, (4, "Profit", "Pr", "not specified"))
    push!(listMet, (5, "Return on investment", "ROI", "not specified"))
    push!(listMet, (6, "Human toxicity by ingestion", "HTPI", "not specified"))
    push!(listMet, (7, "Human toxicity by exposure", "HTPE", "not specified"))
    push!(listMet, (8, "Global Warming", "GWP", "not specified"))
    push!(listMet, (9, "Carcinogenics", "HTC", "not specified"))
    push!(listMet, (10, "Non carcinogenics", "HTNC", "not specified"))
    push!(listMet, (11, "Carbon footprint", "CF", "not specified"))
    push!(listMet, (12, "Fire and explosion damage index", "FEDI", "not specified"))

    rawmaterialFrame = Frame()
    set_gtk_property!(rawmaterialFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(rawmaterialFrame, :label_xalign, 0.50)

    rawmaterialGrid = Grid()
    set_gtk_property!(rawmaterialGrid, :column_spacing, 10)
    set_gtk_property!(rawmaterialGrid, :row_spacing, 10)
    set_gtk_property!(rawmaterialGrid, :margin_top, 5)
    set_gtk_property!(rawmaterialGrid, :margin_bottom, 10)
    set_gtk_property!(rawmaterialGrid, :margin_left, 10)
    set_gtk_property!(rawmaterialGrid, :margin_right, 10)

    # TreeView for Rawmaterial
    wBC = (h / 2) - 15
    rawmaterialFrameTree = Frame()

    if Sys.iswindows()
        set_gtk_property!(rawmaterialFrameTree, :height_request, (hNb - 30)/2 - 110)
    else
        set_gtk_property!(rawmaterialFrameTree, :height_request, (hNb - 30)/2 - 101)
    end

    set_gtk_property!(rawmaterialFrameTree, :width_request, wBC - 20)
    set_gtk_property!(rawmaterialFrameTree, :margin_top, 5)
    rawmaterialScroll = ScrolledWindow()
    push!(rawmaterialFrameTree, rawmaterialScroll)

    # Table for Case Design
    rawmaterialList = ListStore(String, String, String, String)

    # Visual Table for Case Design
    rawmaterialTreeView = TreeView(TreeModel(rawmaterialList))
    set_gtk_property!(rawmaterialTreeView, :reorderable, true)
    set_gtk_property!(rawmaterialTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelRawmaterial = G_.selection(rawmaterialTreeView)

    renderTxtM1 = CellRendererText()
    renderTxtM2 = CellRendererText()
    renderTxtM3 = CellRendererText()

    set_gtk_property!(renderTxtM1, :editable, true)
    set_gtk_property!(renderTxtM2, :editable, false)
    set_gtk_property!(renderTxtM3, :editable, true)

    c1 = TreeViewColumn("ID", renderTxtM1, Dict([("text", 0)]))
    c2 = TreeViewColumn("RawMaterial", renderTxtM2, Dict([("text", 1)]))
    c3 = TreeViewColumn("Symbol", renderTxtM2, Dict([("text", 2)]))
    c4 = TreeViewColumn("Value [Kg/h]", renderTxtM3, Dict([("text", 3)]))

    # Allows to select rows
    for c in [c1, c2, c3, c4]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(rawmaterialTreeView, c1, c2, c3, c4)
    push!(rawmaterialScroll, rawmaterialTreeView)

    rawmaterialGrid[1:4, 1] = rawmaterialFrameTree

    signal_connect(renderTxtM1, "edited") do widget, path, text
        idxTreeMet = parse(Int, path) + 1
        idxIDMet = parse(Int, text)


                if idxIDMet >= 1 && idxIDMet <= 12
                    rawmaterialList[idxTreeMet, 1] = text
                    rawmaterialList[idxTreeMet, 2] = listMet[idxIDMet, 2]
                    rawmaterialList[idxTreeMet, 3] = listMet[idxIDMet, 3]

                    newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
                    dictMet["$(baseCaseList[newidxBC,2])"] = []

                    testMet = zeros(1, length(rawmaterialList))
                    for i = 1:length(rawmaterialList)
                        push!(
                            dictMet["$(baseCaseList[newidxBC,2])"],
                            (rawmaterialList[i, 1], rawmaterialList[i, 2], rawmaterialList[i, 3], rawmaterialList[i, 4])
                            )

                            if (rawmaterialList[i, 1] == "not specified") || (rawmaterialList[i, 4] == "not specified")
                                testMet[i] = 1
                            end
                    end
                    newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

                    if length(rawmaterialList) >= 1
                        if sum(testMet) == 0
                            baseCaseList[newidxBC, 4] = @sprintf("Rawmaterial = %i, Complete", length(rawmaterialList))
                        end
                    end

                else
                    warn_dialog("No raw material specified for option $(idxIDMet), see Help", mainPIWin)
                end
    end

    signal_connect(renderTxtM3, "edited") do widget, path, text
        idxTreeMet = parse(Int, path) + 1

        try
            idxIDMet = parse(Int, text)

            rawmaterialList[idxTreeMet, 4] = text

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(rawmaterialList))
            for i = 1:length(rawmaterialList)
                push!(
                dictMet["$(baseCaseList[newidxBC,2])"],
                (rawmaterialList[i, 1], rawmaterialList[i, 2], rawmaterialList[i, 3], rawmaterialList[i, 4])
                )

                if (rawmaterialList[i, 1] == "not specified") || (rawmaterialList[i, 4] == "not specified")
                    testMet[i] = 1
                end
            end
            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(rawmaterialList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Rawmaterial = %i, Complete", length(rawmaterialList))
                end
            end

        catch e
            warn_dialog("No valid option", mainPIWin)
        end
    end

    # Buttons for base case design
    addMet = Button("Add")
    set_gtk_property!(addMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addMet, :sensitive, false)
    signal_connect(addMet, :clicked) do widget
         push!(rawmaterialList, ("not specified", "not specified", "not specified", "not specified"))
         set_gtk_property!(clearMet, :sensitive, true)
         set_gtk_property!(deleteMet, :sensitive, true)

         newidxMet = Gtk.index_from_iter(baseCaseList, selected(selBC))
         push!(dictMet["$(baseCaseList[newidxMet,2])"], ("not specified", "not specified", "not specified", "not specified"))

         baseCaseList[newidxMet, 4] = "Incomplete"
    end

    deleteMet = Button("Delete")
    set_gtk_property!(deleteMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteMet, :sensitive, false)
    signal_connect(deleteMet, :clicked) do widget
        if hasselection(selmodelRawmaterial)
            currentID = selected(selmodelRawmaterial)
            newidxMet = Gtk.index_from_iter(rawmaterialList, selected(selmodelRawmaterial))
            deleteat!(rawmaterialList, currentID)

            currentIDBC = selected(selBC)
            nameBCSel = baseCaseList[currentIDBC, 2]
            dictMet[nameBCSel] = deleteat!(dictMet[nameBCSel], newidxMet)

            if length(rawmaterialList)==0
                set_gtk_property!(deleteMet, :sensitive, false)
                set_gtk_property!(clearMet, :sensitive, false)
            end

            if length(rawmaterialList) < 2
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
                baseCaseList[newidxBC, 4] = "Incomplete"
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(rawmaterialList))
            for i = 1:length(rawmaterialList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (rawmaterialList[i, 1], rawmaterialList[i, 2], rawmaterialList[i, 3], rawmaterialList[i,4]))

                if (rawmaterialList[i, 1] == "not specified") || (rawmaterialList[i, 4] == "not specified")
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(rawmaterialList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Rawmaterial = %i, Complete", length(rawmaterialList))
                end
            end
        end
    end

    clearMet = Button("Clear")
    set_gtk_property!(clearMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearMet, :sensitive, false)
    signal_connect(clearMet, :clicked) do widget
        currentIDBC = selected(selBC)
        nameBCSel = baseCaseList[currentIDBC, 2]
        dictEq[nameBCSel] = []
        empty!(rawmaterialList)
        set_gtk_property!(clearMet, :sensitive, false)
        set_gtk_property!(deleteMet, :sensitive, false)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
        baseCaseList[newidxBC, 4] = "Incomplete"
    end

    helpMet = Button("Help")
    set_gtk_property!(helpMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpMet, :sensitive, false)
    signal_connect(helpMet, :clicked) do widget
        # Rawmaterial Help Win
        rawmaterialHelpWin = Window()
        set_gtk_property!(rawmaterialHelpWin, :title, "Rawmaterial Help")
        set_gtk_property!(rawmaterialHelpWin, :window_position, 3)
        set_gtk_property!(rawmaterialHelpWin, :accept_focus, true)
        set_gtk_property!(rawmaterialHelpWin, :resizable, false)
        set_gtk_property!(rawmaterialHelpWin, :width_request, h/2.5)

        rawmaterialFrameHelp = Frame("Rawmaterial evailable")
        set_gtk_property!(rawmaterialFrameHelp, :label_xalign, 0.5)
        set_gtk_property!(rawmaterialFrameHelp, :margin_top, 5)
        set_gtk_property!(rawmaterialFrameHelp, :margin_bottom, 10)
        set_gtk_property!(rawmaterialFrameHelp, :margin_left, 10)
        set_gtk_property!(rawmaterialFrameHelp, :margin_right, 10)

        rawmaterialGridHelp = Grid()
        set_gtk_property!(rawmaterialGridHelp, :column_spacing, 10)
        set_gtk_property!(rawmaterialGridHelp, :row_spacing, 10)
        set_gtk_property!(rawmaterialGridHelp, :margin_top, 5)
        set_gtk_property!(rawmaterialGridHelp, :margin_bottom, 10)
        set_gtk_property!(rawmaterialGridHelp, :margin_left, 10)
        set_gtk_property!(rawmaterialGridHelp, :margin_right, 10)

        rawmaterialFrameTreeH = Frame()
        set_gtk_property!(rawmaterialFrameTreeH, :width_request, h/2.5 - 20)
        set_gtk_property!(rawmaterialFrameTreeH, :height_request, h/2 - 30 - 60)

        rawmaterialScrollH = ScrolledWindow()
        push!(rawmaterialFrameTreeH, rawmaterialScrollH)

        # Table for Rawmaterial help
        metList = ListStore(String, String, String)

        # Load data from listEqPhenomena

        for i=1:size(listMet)[1]
            push!(metList, (listMet[i,1], listMet[i,2], string(listMet[i,3])))
        end

        # Visual Table for Rawmaterial help
        rawmaterialTreeViewH = TreeView(TreeModel(metList))
        set_gtk_property!(rawmaterialTreeViewH, :reorderable, true)
        set_gtk_property!(rawmaterialTreeViewH, :enable_grid_lines, 3)

        # Set selectable
        selMetHelp = Gtk.GAccessor.selection(rawmaterialTreeViewH)
        selMetHelp = Gtk.GAccessor.mode(selMetHelp, Gtk.GConstants.GtkSelectionMode.SINGLE)
        selMetHelp = G_.selection(rawmaterialTreeViewH)

        renderTxtMet = CellRendererText()
        set_gtk_property!(renderTxtMet, :editable, false)

        c1 = TreeViewColumn("ID", renderTxtMet, Dict([("text", 0)]))
        c2 = TreeViewColumn("RawMaterial", renderTxtMet, Dict([("text", 1)]))
        c3 = TreeViewColumn("Symbol", renderTxtMet, Dict([("text", 2)]))

        # Allows to select rows
        for c in [c1, c2, c3]
            Gtk.GAccessor.resizable(c, true)
        end

        push!(rawmaterialTreeViewH, c1, c2, c3)
        push!(rawmaterialScrollH, rawmaterialTreeViewH)

        rawmaterialClose = Button("Close")
        set_gtk_property!(rawmaterialClose, :label, "Close")
        set_gtk_property!(rawmaterialClose, :tooltip_markup, "Close")
        signal_connect(rawmaterialClose, :clicked) do widget
            destroy(rawmaterialHelpWin)
        end

        rawmaterialAdd = Button("Add")
        set_gtk_property!(rawmaterialAdd, :label, "Add")
        set_gtk_property!(rawmaterialAdd, :tooltip_markup, "Add")
        signal_connect(rawmaterialAdd, :clicked) do widget
            currentID = selected(selMetHelp)
            push!(rawmaterialList, (metList[currentID, 1], metList[currentID, 2], metList[currentID, 3], "not specified"))
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            baseCaseList[newidxBC, 4] = "Incomplete"
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(rawmaterialList))
            for i = 1:length(rawmaterialList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (rawmaterialList[i, 1], rawmaterialList[i, 2], rawmaterialList[i, 3], rawmaterialList[i, 4]))

                if (rawmaterialList[i, 1] == "not specified") || (rawmaterialList[i, 4] == "not specified")
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(rawmaterialList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Rawmaterial = %i, Complete", length(rawmaterialList))
                end
            end
        end

        signal_connect(rawmaterialTreeViewH, :row_activated) do widget, path, column
            currentID = selected(selMetHelp)
            push!(rawmaterialList, (metList[currentID,1], metList[currentID,2], metList[currentID,3], "not specified"))
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            baseCaseList[newidxBC, 4] = "Incomplete"

            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(rawmaterialList))
            for i = 1:length(rawmaterialList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (rawmaterialList[i, 1], rawmaterialList[i, 2], rawmaterialList[i, 3], rawmaterialList[i, 4]))

                if (rawmaterialList[i, 1] == "not specified") || (rawmaterialList[i, 4] == "not specified")
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(rawmaterialList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Rawmaterial = %i, Complete", length(rawmaterialList))
                end
            end
        end

        rawmaterialGridHelp[1, 2] = rawmaterialAdd
        rawmaterialGridHelp[2, 2] = rawmaterialClose
        rawmaterialGridHelp[1:2, 1] = rawmaterialFrameTreeH
        push!(rawmaterialFrameHelp, rawmaterialGridHelp)
        push!(rawmaterialHelpWin, rawmaterialFrameHelp)
        Gtk.showall(rawmaterialHelpWin)
    end

    rawmaterialGrid[1, 2] = addMet
    rawmaterialGrid[2, 2] = deleteMet
    rawmaterialGrid[3, 2] = clearMet
    rawmaterialGrid[4, 2] = helpMet

    push!(rawmaterialFrame, rawmaterialGrid)
    ####################################################################################################################

    ####################################################################################################################

    ####################################################################################################################
    # Criterion
    ####################################################################################################################
    global listCriteriaM = DataFrames.DataFrame(ID = Int[], Criterion = String[])
    global dictCriteriaM = Dict()

    # Add avilable aquipments and phenomenas
    push!(listCriteriaM, (1, "Production cost"))

    criterionFrame = Frame(" Criterion ")
    set_gtk_property!(criterionFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(criterionFrame, :label_xalign, 0.50)

    criterionGrid = Grid()
    set_gtk_property!(criterionGrid, :column_spacing, 10)
    set_gtk_property!(criterionGrid, :row_spacing, 10)
    set_gtk_property!(criterionGrid, :margin_top, 5)
    set_gtk_property!(criterionGrid, :margin_bottom, 10)
    set_gtk_property!(criterionGrid, :margin_left, 10)
    set_gtk_property!(criterionGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    criterionFrameTree = Frame()

    set_gtk_property!(criterionFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(criterionFrameTree, :width_request, wBC - 20)
    criterionScroll = ScrolledWindow()
    push!(criterionFrameTree, criterionScroll)

    # Table for Case Design
    criterionList = ListStore(String, String, String)

    # Visual Table for Case Design
    criterionTreeView = TreeView(TreeModel(criterionList))
    set_gtk_property!(criterionTreeView, :reorderable, true)
    set_gtk_property!(criterionTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelcriterion = G_.selection(criterionTreeView)

    renderTxtCrM1 = CellRendererText()
    renderTxtCrM2 = CellRendererText()
    set_gtk_property!(renderTxtCrM1, :editable, true)
    set_gtk_property!(renderTxtCrM2, :editable, false)

    c1 = TreeViewColumn("ID", renderTxtCrM1, Dict([("text", 0)]))
    c2 = TreeViewColumn("Criterion", renderTxtCrM2, Dict([("text", 1)]))
    c3 = TreeViewColumn("Status", renderTxtCrM2, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(criterionTreeView, c1, c2, c3)
    push!(criterionScroll, criterionTreeView)

    criterionGrid[1:4, 1] = criterionFrameTree

    # Edited
    signal_connect(renderTxtCrM1, "edited") do widget, path, text
        idxTreeCrM = parse(Int, path) + 1
        idxIDCrM = parse(Int, text) # Number provided by user

        if idxIDCrM >= 1 && idxIDCrM <= 1
            criterionList[idxTreeCrM, 1] = text
            criterionList[idxTreeCrM, 2] = listCriteriaM[idxIDCrM, 2]
            criterionList[idxTreeCrM, 3] = "incomplete"

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictCriteriaM["$(baseCaseList[newidxBC,2])"] = []

            testCrM = zeros(1, length(criterionList))
            for i = 1:length(criterionList)
                push!(
                    dictCriteriaM["$(baseCaseList[newidxBC,2])"],
                    (criterionList[i, 1], criterionList[i, 2], criterionList[i, 3]),
                    )

                    if criterionList[i, 1] == "not specified"
                        testCrM[i] = 1
                    end
            end

            if length(criterionList) >= 1
                if sum(testCrM) == 0
                    baseCaseList[newidxBC, 5] = @sprintf("Criterion = %i, Complete", length(criterionList))
                end
            end

        else
            warn_dialog("No criterion available for $(idxIDCrM), see Help", mainPIWin)
        end
    end

    signal_connect(criterionTreeView, :row_activated) do widget, path, column
        currentID = selected(selmodelcriterion)

        for i=1:length(processList)
            push!(crSettList, (processList[i,1], processList[i,2], 0))
        end
    end

    # Buttons for base case design
    addCr = Button("Add")
    set_gtk_property!(addCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addCr, :sensitive, false)
    signal_connect(addCr, :clicked) do widget
        push!(criterionList, ("not specified", "not specified", "Incomplete"))
        set_gtk_property!(clearCr, :sensitive, true)
        set_gtk_property!(deleteCr, :sensitive, true)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
        push!(dictCriteriaM["$(baseCaseList[newidxBC,2])"], ("not specified", "not specified", "Incomplete"))

        baseCaseList[newidxBC, 5] = "Incomplete"
    end

    deleteCr = Button("Delete")
    set_gtk_property!(deleteCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteCr, :sensitive, false)
    signal_connect(deleteCr, :clicked) do widget
        if hasselection(selmodelcriterion)
            currentID = selected(selmodelcriterion)
            newidxBC = Gtk.index_from_iter(criterionList, selected(selmodelcriterion))
            deleteat!(criterionList, currentID)

            currentIDBC = selected(selBC)
            nameBCSel = baseCaseList[currentIDBC, 2]
            dictCriteriaM[nameBCSel] = deleteat!(dictCriteriaM[nameBCSel], newidxBC)

            if length(criterionList)==0
                set_gtk_property!(deleteCr, :sensitive, false)
                set_gtk_property!(clearCr, :sensitive, false)
                baseCaseList[newidxBC, 5] = "Incomplete"
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictCriteriaM["$(baseCaseList[newidxBC,2])"] = []

            testCrM = zeros(1, length(criterionList))
            for i = 1:length(criterionList)
                push!(
                    dictCriteriaM["$(baseCaseList[newidxBC,2])"],
                    (criterionList[i, 1], criterionList[i, 2], criterionList[i, 3]),
                    )

                    if criterionList[i, 1] == "not specified"
                        testCrM[i] = 1
                    end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(criterionList) >= 1
                if sum(testCrM) == 0
                    baseCaseList[newidxBC, 5] = @sprintf("Criterion = %i, Complete", length(criterionList))
                end
            end

        end
    end

    clearCr = Button("Clear")
    set_gtk_property!(clearCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearCr, :sensitive, false)
    signal_connect(clearCr, :clicked) do widget
        currentIDBC = selected(selBC)
        nameBCSel = baseCaseList[currentIDBC, 2]
        dictCriteriaM[nameBCSel] = []
        empty!(criterionList)
        set_gtk_property!(clearCr, :sensitive, false)
        set_gtk_property!(deleteCr, :sensitive, false)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
        baseCaseList[newidxBC, 5] = "Incomplete"
    end

    helpCr = Button("Help")
    set_gtk_property!(helpCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpCr, :sensitive, false)
    signal_connect(helpCr, :clicked) do widget
        # Criterion Help Win
        criterionHelpWin = Window()
        set_gtk_property!(criterionHelpWin, :title, "Criterion Help")
        set_gtk_property!(criterionHelpWin, :window_position, 3)
        set_gtk_property!(criterionHelpWin, :accept_focus, true)
        set_gtk_property!(criterionHelpWin, :resizable, false)
        set_gtk_property!(criterionHelpWin, :width_request, h/2.5)

        criterionFrameHelp = Frame("Criterion evailable")
        set_gtk_property!(criterionFrameHelp, :label_xalign, 0.5)
        set_gtk_property!(criterionFrameHelp, :margin_top, 5)
        set_gtk_property!(criterionFrameHelp, :margin_bottom, 10)
        set_gtk_property!(criterionFrameHelp, :margin_left, 10)
        set_gtk_property!(criterionFrameHelp, :margin_right, 10)

        criterionGridHelp = Grid()
        set_gtk_property!(criterionGridHelp, :column_spacing, 10)
        set_gtk_property!(criterionGridHelp, :row_spacing, 10)
        set_gtk_property!(criterionGridHelp, :margin_top, 5)
        set_gtk_property!(criterionGridHelp, :margin_bottom, 10)
        set_gtk_property!(criterionGridHelp, :margin_left, 10)
        set_gtk_property!(criterionGridHelp, :margin_right, 10)

        criterionFrameTree = Frame()
        set_gtk_property!(criterionFrameTree, :width_request, h/2.5 - 20)
        set_gtk_property!(criterionFrameTree, :height_request, h/2 - 30 - 60)

        criterionScroll = ScrolledWindow()
        push!(criterionFrameTree, criterionScroll)

        # Table for Process help
        criterionListH = ListStore(Int, String)

        # Load data from criterionList

        for i=1:size(listCriteriaM)[1]
            push!(criterionListH, (listCriteriaM[i,1], listCriteriaM[i,2]))
        end

        # Visual Table for Process help
        criterionHTreeView = TreeView(TreeModel(criterionListH))
        set_gtk_property!(criterionHTreeView, :reorderable, true)
        set_gtk_property!(criterionHTreeView, :enable_grid_lines, 3)

        # Set selectable
        selCriterionHelp = Gtk.GAccessor.selection(criterionHTreeView)
        selCriterionHelp = Gtk.GAccessor.mode(selCriterionHelp, Gtk.GConstants.GtkSelectionMode.SINGLE)
        selCriterionHelp = G_.selection(criterionHTreeView)

        renderTxtCrH = CellRendererText()
        set_gtk_property!(renderTxtCrH, :editable, false)

        c1 = TreeViewColumn("ID", renderTxtCrH, Dict([("text", 0)]))
        c2 = TreeViewColumn("Criterion", renderTxtCrH, Dict([("text", 1)]))

        # Allows to select rows
        for c in [c1, c2]
            Gtk.GAccessor.resizable(c, true)
        end

        push!(criterionHTreeView, c1, c2)
        push!(criterionScroll, criterionHTreeView)
        criterionClose = Button("Close")
        set_gtk_property!(criterionClose, :label, "Close")
        set_gtk_property!(criterionClose, :tooltip_markup, "Close")
        signal_connect(criterionClose, :clicked) do widget
            destroy(criterionHelpWin)
        end

        criterionAdd = Button("Add")
        set_gtk_property!(criterionAdd, :label, "Add")
        set_gtk_property!(criterionAdd, :tooltip_markup, "Add")
        signal_connect(criterionAdd, :clicked) do widget
            currentID = selected(selCriterionHelp)
            push!(criterionList, (criterionListH[currentID, 1], criterionListH[currentID, 2], "incomplete"))
            set_gtk_property!(clearCr, :sensitive, true)
            set_gtk_property!(deleteCr, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictCriteriaM["$(baseCaseList[newidxBC,2])"] = []

            testCrM = zeros(1, length(criterionList))
            for i = 1:length(criterionList)
                push!(dictCriteriaM["$(baseCaseList[newidxBC,2])"], (criterionList[i, 1], criterionList[i, 2], "incomplete"))

                if criterionList[i, 1] == "not specified"
                    testCrM[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(criterionList) >= 1
                if sum(testCrM) == 0
                    baseCaseList[newidxBC, 5] = @sprintf("Criterion = %i, Complete", length(criterionList))
                end
            end
        end

        signal_connect(criterionHTreeView, :row_activated) do widget, path, column
            currentID = selected(selCriterionHelp)
            push!(criterionList, (criterionListH[currentID,1], criterionListH[currentID,2], "incomplete"))
            set_gtk_property!(clearCr, :sensitive, true)
            set_gtk_property!(deleteCr, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictCriteriaM["$(baseCaseList[newidxBC,2])"] = []

            testCrM = zeros(1, length(criterionList))
            for i = 1:length(criterionList)
                push!(dictCriteriaM["$(baseCaseList[newidxBC,2])"], (criterionList[i, 1], criterionList[i, 2], "incomplete"))

                if criterionList[i, 1] == "not specified"
                    testCrM[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(criterionList) >= 1
                if sum(testCrM) == 0
                    baseCaseList[newidxBC, 5] = @sprintf("Criterion = %i, Complete", length(criterionList))
                end
            end
        end

        criterionGridHelp[1, 2] = criterionAdd
        criterionGridHelp[2, 2] = criterionClose
        criterionGridHelp[1:2, 1] = criterionFrameTree
        push!(criterionFrameHelp, criterionGridHelp)
        push!(criterionHelpWin, criterionFrameHelp)
        Gtk.showall(criterionHelpWin)
    end

    criterionGrid[1, 2] = addCr
    criterionGrid[2, 2] = deleteCr
    criterionGrid[3, 2] = clearCr
    criterionGrid[4, 2] = helpCr

    push!(criterionFrame, criterionGrid)

    ####################################################################################################################
    # Criterion Settings
    ####################################################################################################################
    global dictCriteriaSett = Dict()

    crSettFrame = Frame(" Input Data for Criterion ")
    set_gtk_property!(crSettFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(crSettFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(crSettFrame, :label_xalign, 0.50)

    crSettGrid = Grid()
    set_gtk_property!(crSettGrid, :column_spacing, 10)
    set_gtk_property!(crSettGrid, :row_spacing, 10)
    set_gtk_property!(crSettGrid, :margin_top, 5)
    set_gtk_property!(crSettGrid, :margin_bottom, 10)
    set_gtk_property!(crSettGrid, :margin_left, 10)
    set_gtk_property!(crSettGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    crSettFrameTree = Frame()
    set_gtk_property!(crSettFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(crSettFrameTree, :width_request, wBC - 20)
    crSettScroll = ScrolledWindow()
    push!(crSettFrameTree, crSettScroll)

    # Table for Case Design
    crSettList = ListStore(String, String, String)

    # Visual Table for Case Design
    crSettTreeView = TreeView(TreeModel(crSettList))
    set_gtk_property!(crSettTreeView, :reorderable, true)
    set_gtk_property!(crSettTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelcrSett = G_.selection(crSettTreeView)

    renderTxt7 = CellRendererText()
    renderTxt8 = CellRendererText()
    set_gtk_property!(renderTxt7, :editable, true)
    set_gtk_property!(renderTxt8, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt8, Dict([("text", 0)]))
    c2 = TreeViewColumn("Process", renderTxt8, Dict([("text", 1)]))
    c3 = TreeViewColumn("Value", renderTxt7, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(crSettTreeView, c1, c2, c3)
    push!(crSettScroll, crSettTreeView)

    crSettGrid[1:4, 1] = crSettFrameTree

    # Edited
    signal_connect(renderTxt7, "edited") do widget, path, text

    end

    deleteCrSett = Button("Delete")
    set_gtk_property!(deleteCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteCrSett, :sensitive, false)
    signal_connect(deleteCrSett, :clicked) do widget

    end

    clearCrSett = Button("Clear")
    set_gtk_property!(clearCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearCrSett, :sensitive, false)
    signal_connect(clearCrSett, :clicked) do widget

    end

    signal_connect(renderTxt7, "edited") do widget, path, text
        idxTreeCrM = parse(Int, path) + 1
        idxIDCrM = parse(Int, text) # Number provided by user

        crSettList[idxTreeCrM, 3] = idxIDCrM
    end

    crSettGrid[1:2, 2] = deleteCrSett
    crSettGrid[3:4, 2] = clearCrSett

    push!(crSettFrame, crSettGrid)


    push!(equitMetNotebook, processFrame, "Process")
    push!(equitMetNotebook, rawmaterialFrame, "Rawmaterial")

    ####################################################################################################################
    settingGridLeft[1, 1] = baseCaseFrame
    settingGridLeft[1, 2] = equitMetFrame

    settingGridRight[1, 1] = criterionFrame
    settingGridRight[1, 2] = crSettFrame

    settingGrid[1, 1] = settingGridLeft
    settingGrid[2, 1] = settingGridRight
    push!(settingFrame, settingGrid)

    ####################################################################################################################
    # Results frame
    ####################################################################################################################
    resultsFrame = Frame()
    set_gtk_property!(resultsFrame, :height_request, hNb)
    set_gtk_property!(resultsFrame, :width_request, h)

    resultsGrid = Grid()
    set_gtk_property!(resultsGrid, :column_spacing, 10)
    set_gtk_property!(resultsGrid, :row_spacing, 10)
    set_gtk_property!(resultsGrid, :margin_top, 10)
    set_gtk_property!(resultsGrid, :margin_bottom, 10)
    set_gtk_property!(resultsGrid, :margin_left, 10)
    set_gtk_property!(resultsGrid, :margin_right, 10)

    resultsGridLeft = Grid()
    set_gtk_property!(resultsGridLeft, :row_spacing, 5)

    resultsGridRight = Grid()
    set_gtk_property!(resultsGridRight, :row_spacing, 5)

    ibaseCaseScroll = ScrolledWindow()

    ibaseCaseFrameTree = Frame()
    set_gtk_property!(ibaseCaseFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(ibaseCaseFrameTree, :width_request, wBC - 20)

    # Table for Case Design
    ibaseCaseList = ListStore(String, String, String, String, String, String)

    push!(ibaseCaseList, ("Int/Base Case", "Process", "Rawmaterial", "Criterion", "Solved"))

    # Visual Table for Case Design
    ibaseCaseTreeView = TreeView(TreeModel(ibaseCaseList))
    set_gtk_property!(ibaseCaseTreeView, :reorderable, true)
    set_gtk_property!(ibaseCaseTreeView, :enable_grid_lines, 3)
    set_gtk_property!(ibaseCaseTreeView, :activate_on_single_click, true)
    iselBC = Gtk.GAccessor.selection(ibaseCaseTreeView)
    iselBC = Gtk.GAccessor.mode(iselBC, Gtk.GConstants.GtkSelectionMode.SINGLE)

    # Set selectable
    iselmodelBaseCase = G_.selection(ibaseCaseTreeView)

    renderTxti1 = CellRendererText()
    renderTxti2 = CellRendererText()
    set_gtk_property!(renderTxti1, :editable, true)
    set_gtk_property!(renderTxti2, :editable, false)

    c1 = TreeViewColumn("ID", renderTxti2, Dict([("text", 0)]))
    c2 = TreeViewColumn("Name", renderTxti1, Dict([("text", 1)]))
    c3 = TreeViewColumn("Processs", renderTxti2, Dict([("text", 2)]))
    c4 = TreeViewColumn("Rawmaterial", renderTxti2, Dict([("text", 3)]))
    c5 = TreeViewColumn("Criterion", renderTxti2, Dict([("text", 4)]))
    c6 = TreeViewColumn("Status", renderTxti2, Dict([("text", 5)]))
    for c in [c1, c2, c3, c4, c5, c6]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(ibaseCaseTreeView, c1, c2, c3, c4, c5, c6)

    println(111)
    push!(ibaseCaseScroll, ibaseCaseTreeView)
    push!(ibaseCaseFrameTree, ibaseCaseScroll)
    resultsGrid[1,1] = resultsGridLeft
    resultsGridLeft[1,1] = ibaseCaseFrameTree

    println(111)

    push!(resultsFrame, resultsGrid)
    ####################################################################################################################
    push!(mainNotebook, settingFrame, "Settings")
    push!(mainNotebook, resultsFrame, "Results")

    bGrid[1, 1] = mainNotebook

    mainGrid[1, 1] = gridToolbar
    mainGrid[1, 2] = bGrid

    push!(mainPIWin, mainGrid)
    Gtk.showall(mainPIWin)
end
