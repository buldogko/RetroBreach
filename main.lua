local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

---------------------------------------------------------------------
-- SETTINGS & CONFIGURATION
---------------------------------------------------------------------

local Settings = {
    MasterToggle = true,
    
    -- SCP Rooms
    SCP914_Enabled = true,
    SCP035_Enabled = true,
    
    -- LCZ
    ElevatorA_LCZ_Enabled = true,
    ElevatorB_LCZ_Enabled = true,
    
    -- HCZ
    ElevatorA_HCZ_Enabled = true,
    ElevatorB_HCZ_Enabled = true,
    
    -- Gates
    GateA_EZ_Enabled = true,
    GateB_EZ_Enabled = true,

    -- Keycards
    Keycards_Enabled = true,
    Keycard_Lvl1 = true,
    Keycard_Lvl2 = true,
    Keycard_Lvl3 = true,
    Keycard_Lvl4 = true,
    Keycard_Lvl5 = true,

    -- Medical Items
    Medical_Enabled = true,
    Med_Bandages = true,
    Med_Medkit = true
}

-- Keycard Level Mappings
local CARD_LEVELS = {
    -- Level 1
    ["Janitor Card"] = 1,
    ["Handyman Keycard"] = 1,
    
    -- Level 2
    ["Doctor Card"] = 2,
    ["Doctor Keycard"] = 2,
    ["Scientist Card"] = 2,
    ["Scientist Keycard"] = 2,
    ["Technician Card"] = 2,
    ["Technician Keycard"] = 2,
    
    -- Level 3
    ["Medical Specialist Card"] = 3,
    ["Containment Engineer Card"] = 3,
    ["Containment Technician Card"] = 3,
    ["Senior Scientist Card"] = 3,
    ["Senior Scientist Keycard"] = 3,
    ["Security Guard Card"] = 3,
    ["Security Guard Keycard"] = 3,
    ["Area Administrator Card"] = 3,
    ["Major Scientist Card"] = 3,
    
    -- Level 4
    ["Commander Card"] = 4,
    ["Commander Keycard"] = 4,
    ["Resident Card"] = 4,
    ["Resident Keycard"] = 4,
    ["MTF Agent Card"] = 4,
    ["MTF Agent Keycard"] = 4,
    ["MTF Operative Card"] = 4,
    ["Facility Manager Card"] = 4,
    ["Facility Manager Keycard"] = 4,
    ["Hacking Device"] = 4,
    
    -- Level 5
    ["O5 Card"] = 5,
    ["O5 Council Card"] = 5,
    ["o5 card"] = 5
}

-- Medical Item Mappings
local MEDICAL_ITEMS = {
    ["Bandages"] = "Bandages",
    ["Bandage"] = "Bandages",
    ["Medkit"] = "Medkit",
    ["Med Kit"] = "Medkit",
    ["First Aid Kit"] = "Medkit"
}

-- Color Schemes
local LEVEL_COLORS = {
    [1] = Color3.fromRGB(180, 180, 180), -- Light Gray
    [2] = Color3.fromRGB(85, 170, 255),  -- Blue
    [3] = Color3.fromRGB(255, 170, 0),   -- Orange/Amber
    [4] = Color3.fromRGB(170, 0, 0),     -- Red
    [5] = Color3.fromRGB(170, 0, 255)    -- Purple
}

local MEDICAL_COLOR = Color3.fromRGB(50, 220, 100) -- Light Green

---------------------------------------------------------------------
-- RAYFIELD UI WINDOW & TABS
---------------------------------------------------------------------

local Window = Rayfield:CreateWindow({
    Name = "Zone & Item Markers Controller",
    LoadingTitle = "Loading Markers...",
    LoadingSubtitle = "by Assistant",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Locations", 4483362458)
local KeycardsTab = Window:CreateTab("Keycards", 4483362458)
local MedicalTab = Window:CreateTab("Medical", 4483362458)

---------------------------------------------------------------------
-- LOCATIONS TAB
---------------------------------------------------------------------

-- Master Toggle All Switch
MainTab:CreateToggle({
    Name = "Toggle All Markers",
    CurrentValue = Settings.MasterToggle,
    Flag = "MasterToggle",
    Callback = function(Value)
        Settings.MasterToggle = Value
        Settings.SCP914_Enabled = Value
        Settings.SCP035_Enabled = Value
        Settings.ElevatorA_LCZ_Enabled = Value
        Settings.ElevatorB_LCZ_Enabled = Value
        Settings.ElevatorA_HCZ_Enabled = Value
        Settings.ElevatorB_HCZ_Enabled = Value
        Settings.GateA_EZ_Enabled = Value
        Settings.GateB_EZ_Enabled = Value
        Settings.Keycards_Enabled = Value
        Settings.Medical_Enabled = Value

        if Rayfield.Flags["SCP914Toggle"] then Rayfield.Flags["SCP914Toggle"]:Set(Value) end
        if Rayfield.Flags["SCP035Toggle"] then Rayfield.Flags["SCP035Toggle"]:Set(Value) end
        if Rayfield.Flags["ElevatorAToggle_LCZ"] then Rayfield.Flags["ElevatorAToggle_LCZ"]:Set(Value) end
        if Rayfield.Flags["ElevatorBToggle_LCZ"] then Rayfield.Flags["ElevatorBToggle_LCZ"]:Set(Value) end
        if Rayfield.Flags["ElevatorAToggle_HCZ"] then Rayfield.Flags["ElevatorAToggle_HCZ"]:Set(Value) end
        if Rayfield.Flags["ElevatorBToggle_HCZ"] then Rayfield.Flags["ElevatorBToggle_HCZ"]:Set(Value) end
        if Rayfield.Flags["GateAToggle_EZ"] then Rayfield.Flags["GateAToggle_EZ"]:Set(Value) end
        if Rayfield.Flags["GateBToggle_EZ"] then Rayfield.Flags["GateBToggle_EZ"]:Set(Value) end
        if Rayfield.Flags["KeycardsToggle"] then Rayfield.Flags["KeycardsToggle"]:Set(Value) end
        if Rayfield.Flags["MedicalToggle"] then Rayfield.Flags["MedicalToggle"]:Set(Value) end
    end,
})

-- SCP Rooms Category
MainTab:CreateSection("SCP Rooms")

MainTab:CreateToggle({
    Name = "SCP-914 Marker",
    CurrentValue = Settings.SCP914_Enabled,
    Flag = "SCP914Toggle",
    Callback = function(Value) Settings.SCP914_Enabled = Value end,
})

MainTab:CreateToggle({
    Name = "SCP-035 Marker",
    CurrentValue = Settings.SCP035_Enabled,
    Flag = "SCP035Toggle",
    Callback = function(Value) Settings.SCP035_Enabled = Value end,
})

-- LCZ Category
MainTab:CreateSection("LCZ")

MainTab:CreateToggle({
    Name = "LCZ Elevator A Marker",
    CurrentValue = Settings.ElevatorA_LCZ_Enabled,
    Flag = "ElevatorAToggle_LCZ",
    Callback = function(Value) Settings.ElevatorA_LCZ_Enabled = Value end,
})

MainTab:CreateToggle({
    Name = "LCZ Elevator B Marker",
    CurrentValue = Settings.ElevatorB_LCZ_Enabled,
    Flag = "ElevatorBToggle_LCZ",
    Callback = function(Value) Settings.ElevatorB_LCZ_Enabled = Value end,
})

-- HCZ Category
MainTab:CreateSection("HCZ")

MainTab:CreateToggle({
    Name = "HCZ Elevator A Marker",
    CurrentValue = Settings.ElevatorA_HCZ_Enabled,
    Flag = "ElevatorAToggle_HCZ",
    Callback = function(Value) Settings.ElevatorA_HCZ_Enabled = Value end,
})

MainTab:CreateToggle({
    Name = "HCZ Elevator B Marker",
    CurrentValue = Settings.ElevatorB_HCZ_Enabled,
    Flag = "ElevatorBToggle_HCZ",
    Callback = function(Value) Settings.ElevatorB_HCZ_Enabled = Value end,
})

-- Gates Category
MainTab:CreateSection("Gates")

MainTab:CreateToggle({
    Name = "Gate A Marker",
    CurrentValue = Settings.GateA_EZ_Enabled,
    Flag = "GateAToggle_EZ",
    Callback = function(Value) Settings.GateA_EZ_Enabled = Value end,
})

MainTab:CreateToggle({
    Name = "Gate B Marker",
    CurrentValue = Settings.GateB_EZ_Enabled,
    Flag = "GateBToggle_EZ",
    Callback = function(Value) Settings.GateB_EZ_Enabled = Value end,
})

---------------------------------------------------------------------
-- KEYCARDS TAB
---------------------------------------------------------------------

KeycardsTab:CreateSection("Keycard ESP Settings")

KeycardsTab:CreateToggle({
    Name = "Enable Keycard Markers",
    CurrentValue = Settings.Keycards_Enabled,
    Flag = "KeycardsToggle",
    Callback = function(Value) Settings.Keycards_Enabled = Value end,
})

KeycardsTab:CreateToggle({
    Name = "Show Level 1 Cards",
    CurrentValue = Settings.Keycard_Lvl1,
    Flag = "KeycardLvl1Toggle",
    Callback = function(Value) Settings.Keycard_Lvl1 = Value end,
})

KeycardsTab:CreateToggle({
    Name = "Show Level 2 Cards",
    CurrentValue = Settings.Keycard_Lvl2,
    Flag = "KeycardLvl2Toggle",
    Callback = function(Value) Settings.Keycard_Lvl2 = Value end,
})

KeycardsTab:CreateToggle({
    Name = "Show Level 3 Cards",
    CurrentValue = Settings.Keycard_Lvl3,
    Flag = "KeycardLvl3Toggle",
    Callback = function(Value) Settings.Keycard_Lvl3 = Value end,
})

KeycardsTab:CreateToggle({
    Name = "Show Level 4 Cards",
    CurrentValue = Settings.Keycard_Lvl4,
    Flag = "KeycardLvl4Toggle",
    Callback = function(Value) Settings.Keycard_Lvl4 = Value end,
})

KeycardsTab:CreateToggle({
    Name = "Show Level 5 Cards",
    CurrentValue = Settings.Keycard_Lvl5,
    Flag = "KeycardLvl5Toggle",
    Callback = function(Value) Settings.Keycard_Lvl5 = Value end,
})

---------------------------------------------------------------------
-- MEDICAL TAB
---------------------------------------------------------------------

MedicalTab:CreateSection("Medical ESP Settings")

MedicalTab:CreateToggle({
    Name = "Enable Medical Markers",
    CurrentValue = Settings.Medical_Enabled,
    Flag = "MedicalToggle",
    Callback = function(Value) Settings.Medical_Enabled = Value end,
})

MedicalTab:CreateToggle({
    Name = "Show Bandages",
    CurrentValue = Settings.Med_Bandages,
    Flag = "BandagesToggle",
    Callback = function(Value) Settings.Med_Bandages = Value end,
})

MedicalTab:CreateToggle({
    Name = "Show Medkits",
    CurrentValue = Settings.Med_Medkit,
    Flag = "MedkitToggle",
    Callback = function(Value) Settings.Med_Medkit = Value end,
})

---------------------------------------------------------------------
-- KEYCARD MARKER LOGIC
---------------------------------------------------------------------

local activeCards = {}

local function setupCardMarker(card, level)
    if card:FindFirstChild("CardMarker_UI") then return end

    local color = LEVEL_COLORS[level] or Color3.fromRGB(255, 255, 255)

    -- 1. BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "CardMarker_UI"
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Adornee = card
    billboardGui.Parent = card

    -- 2. TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Text = string.format("%s\n[Level %d]", card.Name, level)
    textLabel.Parent = billboardGui

    -- 3. Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "CardHighlight"
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = card
    highlight.Parent = card

    table.insert(activeCards, {
        Instance = card,
        Gui = billboardGui,
        Highlight = highlight,
        Label = textLabel,
        BaseName = card.Name,
        Level = level
    })
end

local function checkAndRegisterCard(instance)
    local level = CARD_LEVELS[instance.Name]
    if level then
        setupCardMarker(instance, level)
    end
end

---------------------------------------------------------------------
-- MEDICAL MARKER LOGIC
---------------------------------------------------------------------

local activeMedical = {}

local function setupMedicalMarker(item, itemType)
    if item:FindFirstChild("MedicalMarker_UI") then return end

    -- 1. BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "MedicalMarker_UI"
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Adornee = item
    billboardGui.Parent = item

    -- 2. TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = MEDICAL_COLOR
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Text = item.Name
    textLabel.Parent = billboardGui

    -- 3. Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "MedicalHighlight"
    highlight.FillColor = MEDICAL_COLOR
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = item
    highlight.Parent = item

    table.insert(activeMedical, {
        Instance = item,
        Gui = billboardGui,
        Highlight = highlight,
        Label = textLabel,
        BaseName = item.Name,
        Type = itemType
    })
end

local function checkAndRegisterMedical(instance)
    local itemType = MEDICAL_ITEMS[instance.Name]
    if itemType then
        setupMedicalMarker(instance, itemType)
    end
end

-- Shared ItemSpawns Listener (Keycards & Medical)
task.spawn(function()
    local itemSpawns = workspace:WaitForChild("ItemSpawns", 10)
    if not itemSpawns then return end

    for _, descendant in ipairs(itemSpawns:GetDescendants()) do
        checkAndRegisterCard(descendant)
        checkAndRegisterMedical(descendant)
    end

    itemSpawns.DescendantAdded:Connect(function(descendant)
        checkAndRegisterCard(descendant)
        checkAndRegisterMedical(descendant)
    end)
end)

---------------------------------------------------------------------
-- DYNAMIC LOCATION MARKER LOGIC
---------------------------------------------------------------------

local activeMarkers = {}

local function getPosition(instance)
    if instance:IsA("Model") then
        return instance:GetPivot().Position
    elseif instance:IsA("BasePart") then
        return instance.Position
    end
    return nil
end

local targetsConfig = {
    {
        Name = "SCP-914",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local lcz = dyn and dyn:FindFirstChild("LCZ")
            local gen = lcz and lcz:FindFirstChild("_GeneratedLayout")
            local room = gen and gen:FindFirstChild("#914")
            local sys = room and room:FindFirstChild("Systems")
            return sys and sys:FindFirstChild("SCP-914")
        end,
        HasHighlight = true,
        IsEnabled = function() return Settings.SCP914_Enabled end
    },
    {
        Name = "SCP-035",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local hcz = dyn and dyn:FindFirstChild("HCZ")
            local gen = hcz and hcz:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("#035")
        end,
        HasHighlight = true,
        IsEnabled = function() return Settings.SCP035_Enabled end
    },
    {
        Name = "LCZ Elevator A",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local lcz = dyn and dyn:FindFirstChild("LCZ")
            local gen = lcz and lcz:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("EX-A")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.ElevatorA_LCZ_Enabled end
    },
    {
        Name = "LCZ Elevator B",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local lcz = dyn and dyn:FindFirstChild("LCZ")
            local gen = lcz and lcz:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("EX-B")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.ElevatorB_LCZ_Enabled end
    },
    {
        Name = "HCZ Elevator A",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local hcz = dyn and dyn:FindFirstChild("HCZ")
            local gen = hcz and hcz:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("EX-A")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.ElevatorA_HCZ_Enabled end
    },
    {
        Name = "HCZ Elevator B",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local hcz = dyn and dyn:FindFirstChild("HCZ")
            local gen = hcz and hcz:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("EX-B")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.ElevatorB_HCZ_Enabled end
    },
    {
        Name = "Gate A",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local ez = dyn and dyn:FindFirstChild("EZ")
            local gen = ez and ez:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("G8-A")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.GateA_EZ_Enabled end
    },
    {
        Name = "Gate B",
        Find = function()
            local map = workspace:FindFirstChild("Map")
            local dyn = map and map:FindFirstChild("Dynamic")
            local ez = dyn and dyn:FindFirstChild("EZ")
            local gen = ez and ez:FindFirstChild("_GeneratedLayout")
            return gen and gen:FindFirstChild("G8-B")
        end,
        HasHighlight = false,
        IsEnabled = function() return Settings.GateB_EZ_Enabled end
    }
}

task.spawn(function()
    while true do
        task.wait(1)

        -- Clean up lost location markers
        for i = #activeMarkers, 1, -1 do
            local marker = activeMarkers[i]
            if not marker.Instance or not marker.Instance:IsDescendantOf(workspace) then
                if marker.Gui then pcall(function() marker.Gui:Destroy() end) end
                if marker.Highlight then pcall(function() marker.Highlight:Destroy() end) end
                table.remove(activeMarkers, i)
            end
        end

        -- Check missing locations and re-attach
        for _, config in ipairs(targetsConfig) do
            local isTracked = false
            for _, marker in ipairs(activeMarkers) do
                if marker.Name == config.Name then
                    isTracked = true
                    break
                end
            end

            if not isTracked then
                local targetInstance = config.Find()
                if targetInstance and targetInstance:IsDescendantOf(workspace) then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Name = config.Name:gsub("%s+", "") .. "_UI"
                    billboardGui.Size = UDim2.new(0, 200, 0, 50)
                    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
                    billboardGui.AlwaysOnTop = true
                    billboardGui.Adornee = targetInstance
                    billboardGui.Parent = targetInstance

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextStrokeTransparency = 0
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.Text = config.Name
                    textLabel.Parent = billboardGui

                    local highlight = nil
                    if config.HasHighlight then
                        highlight = Instance.new("Highlight")
                        highlight.Adornee = targetInstance
                        highlight.Parent = targetInstance
                    end

                    table.insert(activeMarkers, {
                        Name = config.Name,
                        Instance = targetInstance,
                        Gui = billboardGui,
                        Label = textLabel,
                        Highlight = highlight,
                        IsEnabled = config.IsEnabled
                    })
                end
            end
        end
    end
end)

---------------------------------------------------------------------
-- COMBINED DISTANCE & VISIBILITY LOOP
---------------------------------------------------------------------

RunService.Heartbeat:Connect(function()
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local hrpPosition = character.HumanoidRootPart.Position

    -- 1. Update Zone Markers
    for _, marker in ipairs(activeMarkers) do
        local pos = getPosition(marker.Instance)
        if pos then
            local distance = math.floor((hrpPosition - pos).Magnitude)
            marker.Label.Text = string.format("%s\n[%d studs]", marker.Name, distance)

            local shouldShow = Settings.MasterToggle and marker.IsEnabled()
            marker.Gui.Enabled = shouldShow
            if marker.Highlight then
                marker.Highlight.Enabled = shouldShow
            end
        end
    end

    -- 2. Update Keycard Markers
    for i = #activeCards, 1, -1 do
        local cardData = activeCards[i]
        local card = cardData.Instance

        if not card or not card:IsDescendantOf(workspace) then
            table.remove(activeCards, i)
        else
            local cardPos = card:IsA("Model") and card:GetPivot().Position or card.Position
            local distance = math.floor((hrpPosition - cardPos).Magnitude)

            cardData.Label.Text = string.format("%s [Lvl %d]\n[%d studs]", cardData.BaseName, cardData.Level, distance)

            local levelKey = "Keycard_Lvl" .. tostring(cardData.Level)
            local levelEnabled = Settings[levelKey] ~= false
            local shouldShowCard = Settings.MasterToggle and Settings.Keycards_Enabled and levelEnabled

            if cardData.Gui then cardData.Gui.Enabled = shouldShowCard end
            if cardData.Highlight then cardData.Highlight.Enabled = shouldShowCard end
        end
    end

    -- 3. Update Medical Markers
    for i = #activeMedical, 1, -1 do
        local medData = activeMedical[i]
        local med = medData.Instance

        if not med or not med:IsDescendantOf(workspace) then
            table.remove(activeMedical, i)
        else
            local medPos = med:IsA("Model") and med:GetPivot().Position or med.Position
            local distance = math.floor((hrpPosition - medPos).Magnitude)

            medData.Label.Text = string.format("%s\n[%d studs]", medData.BaseName, distance)

            local typeEnabled = (medData.Type == "Bandages" and Settings.Med_Bandages) or (medData.Type == "Medkit" and Settings.Med_Medkit)
            local shouldShowMed = Settings.MasterToggle and Settings.Medical_Enabled and typeEnabled

            if medData.Gui then medData.Gui.Enabled = shouldShowMed end
            if medData.Highlight then medData.Highlight.Enabled = shouldShowMed end
        end
    end
end)
