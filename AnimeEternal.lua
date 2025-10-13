-- Config System Functions
local saveConfig
local loadConfig = function()
    if not isfile("AE_config.json") then
        print("No configuration file found, using defaults")
        return {
            autoEnabled = false,
            speedHack = false,
            autoSpinEnabled = false,
            autoRankEnabled = false,
            selectedStar = "Star_1",
            autoGachaEnabled = false,
            selectedGacha = "Dragon_Race",
            autoDungeonEnabled = false,
            selectedDungeonDifficulties = {"Easy"}
        }
    end
end

-- Initialize global variables with default values
if not _G.autoEnabled then _G.autoEnabled = false end
if not _G.speedMultiplier then _G.speedMultiplier = 1 end
if not _G.autoSpinEnabled then _G.autoSpinEnabled = false end
if not _G.autoRankEnabled then _G.autoRankEnabled = false end
if not _G.autoGachaEnabled then _G.autoGachaEnabled = false end
if not _G.selectedGacha then _G.selectedGacha = "Dragon_Race" end
if not _G.autoDungeonEnabled then _G.autoDungeonEnabled = false end
if not _G.selectedDungeonDifficulties then _G.selectedDungeonDifficulties = {"Easy"} end

-- Map of gachas with world numbers
local worldGachaMap = {
    ["Dragon_Race"] = "W01-Dragon_Race",
    ["Saiyan_Evolution"] = "W01-Saiyan_Evolution",
    ["Swords"] = "W02-Swords",
    ["Pirate_Crew"] = "W02-Pirate_Crew",
    ["Demon_Fruits"] = "W02-Demon_Fruits",
    ["Zanpakuto"] = "W03-Zanpakuto",
    ["Reiatsu_Color"] = "W03-Reiatsu_Color",
    ["Curses"] = "W04-Curses",
    ["Demon_Arts"] = "W05-Demon_Arts",
    ["Solo_Hunter_Rank"] = "W06-Solo_Hunter_Rank",
    ["Grimoire"] = "W07-Grimoire",
    ["Power_Eyes"] = "W08-Power_Eyes",
    ["Psychic_Mayhem"] = "W09-Psychic_Mayhem",
    ["Energy_Card_Shop"] = "W10-Energy_Card_Shop",
    ["Damage_Card_Shop"] = "W10-Damage_Card_Shop",
    ["Families"] = "W11-Families",
    ["Titans"] = "W11-Titans",
    ["Sins"] = "W12-Sins",
    ["Commandments"] = "W12-Commandments",
    ["Kaiju_Powers"] = "W13-Kaiju_Powers",
    ["Ultimate_Skills"] = "W14-Ultimate_Skills",
    ["Species"] = "W14-Species",
    ["Power_Energy_Runes"] = "W15-Power_Energy_Runes",
    ["Stands"] = "W16-Stands",
    ["Onomatopoeia"] = "W16-Onomatopoeia",
    ["Kagune"] = "W17-Kagune",
    ["Investigators"] = "W17-Investigators",
    ["Debiru_Hunter"] = "W18-Debiru_Hunter",
    ["Akuma_Powers"] = "W18-Akuma_Powers",
    ["Mushi_Bite"] = "W19-Mushi_Bite",
    ["Special_Fire_Force"] = "W19-Special_Fire_Force",
    ["Grand_Elder_Power"] = "W20-Grand_Elder_Power",
    ["Espada"] = "W21-Espada",
    ["Scythes"] = "W21-Scythes",
    ["Shadow_Arts"] = "W22-Shadow_Arts",
    ["Punch_Power"] = "W22-Punch_Power"
}

-- Reference global variables
local autoEnabled = _G.autoEnabled
local speedMultiplier = _G.speedMultiplier
local autoSpinEnabled = _G.autoSpinEnabled
local autoRankEnabled = _G.autoRankEnabled

saveConfig = function()
    -- Use global values
    local config = {
        autoEnabled = _G.autoEnabled,
        speedHack = _G.speedHack,
        autoSpinEnabled = _G.autoSpinEnabled,
        autoRankEnabled = _G.autoRankEnabled,
        selectedStar = _G.selectedStar,
        autoGachaEnabled = _G.autoGachaEnabled,
        selectedGacha = _G.selectedGacha,
        autoDungeonEnabled = _G.autoDungeonEnabled,
        selectedDungeonDifficulties = _G.selectedDungeonDifficulties
    }
    
    print("Global values before save:","autoEnabled=", tostring(_G.autoEnabled),"speedHack=", tostring(_G.speedHack),"autoSpinEnabled=", tostring(_G.autoSpinEnabled),"autoRankEnabled=", tostring(_G.autoRankEnabled),"selectedStar=", tostring(_G.selectedStar))

    -- Enable HttpService
    local HttpService = game:GetService("HttpService")
    pcall(function() HttpService.HttpEnabled = true end)
    
    local success, encoded = pcall(function()
        return HttpService:JSONEncode(config)
    end)
    
    if success then
        local filePath = "AE_config.json"
        writefile(filePath, encoded)
        print("Configuration saved successfully to: " .. filePath)
        print("Config values:", encoded)
    else
        warn("Failed to save configuration!")
    end
end

loadConfig = function()
    if not isfile("AE_config.json") then
        print("No configuration file found, using defaults")
        return {
            autoEnabled = false,
            speedMultiplier = 1,
            autoSpinEnabled = false,
            autoRankEnabled = false,
            selectedStar = "Star_1",
            autoGachaEnabled = false,
            selectedGacha = "Dragon_Race",
            autoDungeonEnabled = false,
            selectedDungeonDifficulties = {"Easy"}
        }
    end
    
    local success, decoded = pcall(function()
        local content = readfile("AE_config.json")
        return game:GetService("HttpService"):JSONDecode(content)
    end)
    
    if success then
        print("Configuration loaded successfully!")
        return decoded
    else
        warn("Failed to load configuration!")
        return {
            autoEnabled = false,
            speedMultiplier = 1,
            autoSpinEnabled = false,
            autoRankEnabled = false,
            selectedStar = "Star_1",
            autoGachaEnabled = false,
            selectedGacha = "Dragon_Race",
            autoDungeonEnabled = false,
            selectedDungeonDifficulties = {"Easy"}
        }
    end
end

-- Kiểm tra và xóa script cũ nếu tồn tại
if getgenv().AnimeEternalScript then
    pcall(function()
        getgenv().AnimeEternalScript:Disconnect()
    end)
    getgenv().AnimeEternalScript = nil
    print("Removed old script")
    wait(0.5) -- Đợi để đảm bảo script cũ đã dừng hoàn toàn
end

-- Xóa tất cả connection cũ có thể còn sót lại
if getgenv().AnimeEternalInputConnection then
    pcall(function()
        getgenv().AnimeEternalInputConnection:Disconnect()
    end)
    getgenv().AnimeEternalInputConnection = nil
end

-- Xóa speed check cũ
if getgenv().AnimeEternalSpeedCheck then
    pcall(function()
        getgenv().AnimeEternalSpeedCheck:Disconnect()
    end)
    getgenv().AnimeEternalSpeedCheck = nil
end

-- Xóa UI và connections cũ nếu tồn tại
if getgenv().AnimeEternalUI then
    pcall(function()
        getgenv().AnimeEternalUI:Destroy()
    end)
    getgenv().AnimeEternalUI = nil
end

if getgenv().AnimeEternalUICheck then
    pcall(function()
        getgenv().AnimeEternalUICheck:Disconnect()
    end)
    getgenv().AnimeEternalUICheck = nil
end



-- Load saved configuration
local config = loadConfig()

-- Update global values from config
_G.autoEnabled = config.autoEnabled or false
_G.speedMultiplier = config.speedMultiplier or 1
_G.autoSpinEnabled = config.autoSpinEnabled or false
_G.autoRankEnabled = config.autoRankEnabled or false
_G.selectedStar = config.selectedStar or "Star_1"
_G.autoGachaEnabled = config.autoGachaEnabled or false
_G.selectedGacha = config.selectedGacha or "Dragon_Race"
_G.autoDungeonEnabled = config.autoDungeonEnabled or false
_G.selectedDungeonDifficulties = config.selectedDungeonDifficulties or {"Easy"}

-- Other local variables
local currentTargetId = nil
local claimCodesEnabled = false
local lastRankTime = 0
local dungeonEnterTime = 0  -- Track when player entered dungeon

-- Debug print
print("Loaded config values into _G:", "_G.autoEnabled=", tostring(_G.autoEnabled),"_G.speedMultiplier=", tostring(_G.speedMultiplier),"_G.autoSpinEnabled=", tostring(_G.autoSpinEnabled),"_G.autoRankEnabled=", tostring(_G.autoRankEnabled))

-- Tạo UI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnimeEternalUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 9999 -- Đảm bảo UI luôn hiển thị trên cùng
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true -- Không bị ảnh hưởng bởi các GUI khác
screenGui.Parent = playerGui
getgenv().AnimeEternalUI = screenGui

-- Tạo Main Frame với kích thước cố định
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 310) -- Increased width to accommodate tab bar
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Container for tabs
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(0, 60, 1, -30) -- Even wider vertical tab bar for better text display
tabContainer.Position = UDim2.new(0, 0, 0, 30) -- Below title
tabContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

-- Game Tab Button
local gameTab = Instance.new("TextButton")
gameTab.Name = "GameTab"
gameTab.Size = UDim2.new(1, 0, 0, 70) -- Taller tab button
gameTab.Position = UDim2.new(0, 0, 0, 0)
gameTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
gameTab.BorderSizePixel = 0
gameTab.Text = "Game"
gameTab.TextColor3 = Color3.fromRGB(255, 255, 255)
gameTab.TextSize = 16
gameTab.Font = Enum.Font.GothamBold
gameTab.Parent = tabContainer

-- Misc Tab Button
local miscTab = Instance.new("TextButton")
miscTab.Name = "MiscTab"
miscTab.Size = UDim2.new(1, 0, 0, 70) -- Taller tab button
miscTab.Position = UDim2.new(0, 0, 0, 70) -- Below game tab, adjusted for new height
miscTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
miscTab.BorderSizePixel = 0
miscTab.Text = "Misc"
miscTab.TextColor3 = Color3.fromRGB(200, 200, 200)
miscTab.TextSize = 16
miscTab.Font = Enum.Font.GothamBold
miscTab.Parent = tabContainer

-- Game Content Frame with ScrollingFrame
local gameFrame = Instance.new("Frame")
gameFrame.Name = "GameFrame"
gameFrame.Size = UDim2.new(1, -50, 1, -30) -- Account for tab bar width and title height
gameFrame.Position = UDim2.new(0, 50, 0, 30) -- Position after tab bar and below title
gameFrame.BackgroundTransparency = 1
gameFrame.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ContentScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -10) -- Slightly smaller than gameFrame to show scrollbar
scrollFrame.Position = UDim2.new(0, 5, 0, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 490) -- Increased for dungeon section
scrollFrame.Parent = gameFrame

-- Category Labels (Bold Text)
local farmCategory = Instance.new("TextLabel")
farmCategory.Name = "FarmCategory"
farmCategory.Size = UDim2.new(1, -30, 0, 30)
farmCategory.Position = UDim2.new(0, 15, 0, 0)
farmCategory.BackgroundTransparency = 1
farmCategory.Text = "FARM"
farmCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
farmCategory.TextSize = 18
farmCategory.Font = Enum.Font.GothamBlack
farmCategory.TextXAlignment = Enum.TextXAlignment.Left
farmCategory.Parent = scrollFrame

local upgradeCategory = Instance.new("TextLabel")
upgradeCategory.Name = "UpgradeCategory"
upgradeCategory.Size = UDim2.new(1, -30, 0, 30)
upgradeCategory.Position = UDim2.new(0, 15, 0, 140) -- Adjusted for dungeon section
upgradeCategory.BackgroundTransparency = 1
upgradeCategory.Text = "UPGRADE"
upgradeCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
upgradeCategory.TextSize = 18
upgradeCategory.Font = Enum.Font.GothamBlack
upgradeCategory.TextXAlignment = Enum.TextXAlignment.Left
upgradeCategory.Parent = scrollFrame

local gachaCategory = Instance.new("TextLabel")
gachaCategory.Name = "GachaCategory"
gachaCategory.Size = UDim2.new(1, -30, 0, 30)
gachaCategory.Position = UDim2.new(0, 15, 0, 205) -- Adjusted for dungeon section
gachaCategory.BackgroundTransparency = 1
gachaCategory.Text = "GACHA"
gachaCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
gachaCategory.TextSize = 18
gachaCategory.Font = Enum.Font.GothamBlack
gachaCategory.TextXAlignment = Enum.TextXAlignment.Left
gachaCategory.Parent = scrollFrame

-- Misc Content Frame
local miscFrame = Instance.new("Frame")
miscFrame.Name = "MiscFrame"
miscFrame.Size = UDim2.new(1, -50, 1, -30) -- Account for tab bar width and title height
miscFrame.Position = UDim2.new(0, 50, 0, 30) -- Position after tab bar and below title
miscFrame.BackgroundTransparency = 1
miscFrame.Visible = false
miscFrame.Parent = mainFrame

-- Tab switching function
local function switchTab(toGame)
    -- gameTab.BackgroundColor3 = toGame and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(35, 35, 35)
    -- miscTab.BackgroundColor3 = toGame and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(45, 45, 45)
    -- gameTab.TextColor3 = toGame and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    -- miscTab.TextColor3 = toGame and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(255, 255, 255)
    gameFrame.Visible = toGame
    miscFrame.Visible = not toGame
    
    -- Add a small indicator on the active tab
    local activeIndicator = Instance.new("Frame")
    activeIndicator.Name = "ActiveIndicator"
    activeIndicator.Size = UDim2.new(0, 3, 1, 0)
    activeIndicator.Position = UDim2.new(0, 0, 0, 0)
    activeIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    activeIndicator.BorderSizePixel = 0
    
    -- Remove existing indicators
    for _, tab in pairs(tabContainer:GetChildren()) do
        if tab:FindFirstChild("ActiveIndicator") then
            tab.ActiveIndicator:Destroy()
        end
    end
    
    -- Add indicator to active tab
    activeIndicator:Clone().Parent = toGame and gameTab or miscTab
end

gameTab.MouseButton1Click:Connect(function()
    switchTab(true)
end)

miscTab.MouseButton1Click:Connect(function()
    switchTab(false)
end)

-- Bo góc cho frame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -30, 0, 30) -- Make room for hide button
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 0
title.Text = "QBHUB - Anime Eternal"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Hide/Show UI Button
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0, 25, 0, 25)
hideButton.Position = UDim2.new(1, -28, 0, 2.5)
hideButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hideButton.BorderSizePixel = 0
hideButton.Text = "−"
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 16
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = mainFrame

local hideButtonCorner = Instance.new("UICorner")
hideButtonCorner.CornerRadius = UDim.new(0, 4)
hideButtonCorner.Parent = hideButton

-- Create show button (appears when UI is hidden)
local showButton = Instance.new("TextButton")
showButton.Name = "ShowButton"
showButton.Size = UDim2.new(0, 50, 0, 50) -- Make it square and larger for dragging
showButton.Position = UDim2.new(0, 10, 0, 10) -- Fixed top-left corner
showButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
showButton.BorderSizePixel = 0
showButton.Text = "QB"
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.TextSize = 16
showButton.Font = Enum.Font.GothamBold
showButton.Visible = false
showButton.ZIndex = 1000 -- Ensure it's always on top
showButton.Parent = screenGui

local showButtonCorner = Instance.new("UICorner")
showButtonCorner.CornerRadius = UDim.new(0, 6)
showButtonCorner.Parent = showButton

-- Bo góc cho title
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Helper function to create toggle buttons with sliding toggle
local function createToggleButton(name, text, parent)
    if not parent or not parent.Parent then
        warn("Parent is null or destroyed when creating toggle button:", name)
        return nil, nil, nil
    end

        -- Create container frame
        local container = Instance.new("Frame")
        container.Name = name .. "Container"
        container.Size = UDim2.new(0, 250, 0, 40) -- Increased height
        container.BackgroundTransparency = 1
        container.Parent = parent    -- Create text label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 1, 0) -- Leave space for toggle
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    -- Create toggle hitbox
    local hitbox = Instance.new("TextButton")
    hitbox.Name = "ToggleHitbox"
    hitbox.Size = UDim2.new(0, 40, 0, 20)
    hitbox.Position = UDim2.new(1, -40, 0.5, -10)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.Parent = container
    
    -- Create toggle background
    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBackground"
    toggleBg.Size = UDim2.new(1, 0, 1, 0)
    toggleBg.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggleBg.Parent = hitbox
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = toggleBg
    
    -- Create sliding knob
    local toggleKnob = Instance.new("Frame")
    toggleKnob.Name = "ToggleKnob"
    toggleKnob.Size = UDim2.new(0, 16, 0, 16)
    toggleKnob.Position = UDim2.new(0, 2, 0.5, -8)
    toggleKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    toggleKnob.Parent = toggleBg
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = toggleKnob
    
    return hitbox, toggleKnob, toggleBg
end

-- Helper function to update toggle state
local function updateToggleState(button, toggleKnob, toggleBg, enabled)
    -- Check if instances exist
    if not toggleKnob or not toggleKnob.Parent then
        warn("Toggle knob is null or destroyed")
        return
    end
    
    if not toggleBg or not toggleBg.Parent then
        warn("Toggle background is null or destroyed")
        return
    end
    
    -- Update knob position
    local targetPosition = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    local targetColor = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    
    -- Safely create and play tweens
    local success, knobTween = pcall(function()
        return TweenService:Create(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPosition})
    end)
    
    if success and knobTween then
        knobTween:Play()
    else
        -- Fallback to instant position change if tween fails
        toggleKnob.Position = targetPosition
    end
    
    local success2, bgTween = pcall(function()
        return TweenService:Create(toggleBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor})
    end)
    
    if success2 and bgTween then
        bgTween:Play()
    else
        -- Fallback to instant color change if tween fails
        toggleBg.BackgroundColor3 = targetColor
    end
end

-- Helper function to create dropdown
local function createDropdown(name, options, parent, position)
    local dropdownContainer = Instance.new("Frame")
    dropdownContainer.Name = name .. "Container"
    dropdownContainer.Size = UDim2.new(0, 250, 0, 35)
    dropdownContainer.Position = position
    dropdownContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    dropdownContainer.BorderSizePixel = 0
    dropdownContainer.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dropdownContainer
    
    -- Searchable textbox
    local selected = Instance.new("TextBox")
    selected.Name = "Selected"
    selected.Size = UDim2.new(1, -30, 1, 0)
    selected.Position = UDim2.new(0, 10, 0, 0)
    selected.BackgroundTransparency = 1
    -- Use config value for initial text if available
    if name == "StarSelector" then
        selected.Text = _G.selectedStar or options[1]
    elseif name == "GachaSelector" then
        selected.Text = _G.selectedGacha or options[1]
    elseif name == "DungeonSelector" then
        local selectedText = table.concat(_G.selectedDungeonDifficulties or {"Easy"}, ", ")
        selected.Text = selectedText
    else
        selected.Text = options[1]
    end
    selected.PlaceholderText = "Search or select..."
    selected.TextColor3 = Color3.fromRGB(255, 255, 255)
    selected.TextXAlignment = Enum.TextXAlignment.Left
    selected.TextSize = 12
    selected.Font = Enum.Font.Gotham
    selected.Parent = dropdownContainer
    selected.ClearTextOnFocus = false
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Size = UDim2.new(0, 30, 1, 0)
    dropdownButton.Position = UDim2.new(1, -30, 0, 0)
    dropdownButton.BackgroundTransparency = 1
    dropdownButton.Text = "▼"
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.TextSize = 12
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.Parent = dropdownContainer
    
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Name = "OptionsFrame"
    optionsFrame.Size = UDim2.new(1, 0, 0, 175) -- Height for search + options
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 100
    optionsFrame.Parent = screenGui
    
    -- Search box in options frame
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchBox"
    searchBox.Size = UDim2.new(1, -20, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 5)
    searchBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    searchBox.BorderSizePixel = 0
    searchBox.Text = selected.Text
    searchBox.PlaceholderText = "Search..."
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.TextXAlignment = Enum.TextXAlignment.Left
    searchBox.TextSize = 14
    searchBox.Font = Enum.Font.Gotham
    searchBox.ZIndex = 100
    searchBox.Parent = optionsFrame
    
    -- Hide search box for dungeon selector
    if name == "DungeonSelector" then
        searchBox.Visible = false
    end
    
    -- Corner for search box
    local searchBoxCorner = Instance.new("UICorner")
    searchBoxCorner.CornerRadius = UDim.new(0, 6)
    searchBoxCorner.Parent = searchBox
    
    local optionsList = Instance.new("ScrollingFrame")
    optionsList.Name = "OptionsList"
    optionsList.Size = UDim2.new(1, -10, 1, -45) -- Leave space for search box
    optionsList.Position = UDim2.new(0, 5, 0, 40) -- Position below search box
    optionsList.BackgroundTransparency = 1
    optionsList.BorderSizePixel = 0
    optionsList.ScrollBarThickness = 4
    optionsList.ScrollingDirection = Enum.ScrollingDirection.Y
    optionsList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    optionsList.ZIndex = 100
    optionsList.Parent = optionsFrame
    
    -- Add close button for multi-select (DungeonSelector)
    local closeButton = nil
    if name == "DungeonSelector" then
        -- Adjust options frame size for dungeon selector (no search box)
        optionsFrame.Size = UDim2.new(1, 0, 0, 145) -- Smaller height without search box
        
        -- Adjust options list to fill the frame (no search box)
        optionsList.Size = UDim2.new(1, -10, 1, -35) -- Leave space for close button
        optionsList.Position = UDim2.new(0, 5, 0, 5) -- Start from top
        
        closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.new(0, 60, 0, 25)
        closeButton.Position = UDim2.new(1, -70, 0, 5)
        closeButton.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
        closeButton.BorderSizePixel = 0
        closeButton.Text = "Close"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 12
        closeButton.Font = Enum.Font.GothamBold
        closeButton.ZIndex = 100
        closeButton.Parent = optionsFrame
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 4)
        closeCorner.Parent = closeButton
        
        closeButton.MouseButton1Click:Connect(function()
            optionsFrame.Visible = false
        end)
    end
    
    -- Corner for options frame
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    -- Keep the options frame positioned correctly relative to the dropdown
    local function updateOptionsFramePosition()
        local dropdownPos = dropdownContainer.AbsolutePosition
        local dropdownSize = dropdownContainer.AbsoluteSize
        optionsFrame.Position = UDim2.new(0, dropdownPos.X, 0, dropdownPos.Y + dropdownSize.Y + 5)
        optionsFrame.Size = UDim2.new(0, dropdownSize.X, 0, 140)
    end
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    -- Function to create option buttons
    local function createOptionButtons(filterText)
        -- Clear existing options
        for _, child in pairs(optionsList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local yOffset = 0
        -- Filter options based on search text (only for non-dungeon selectors)
        for _, option in ipairs(options) do
            local shouldShow = true
            if name ~= "DungeonSelector" then
                shouldShow = filterText == "" or string.lower(option):find(string.lower(filterText))
            end
            
            if shouldShow then
                local optionButton = Instance.new("TextButton")
                optionButton.Name = option
                optionButton.Size = UDim2.new(1, -8, 0, 35)
                optionButton.Position = UDim2.new(0, 4, 0, yOffset)
                optionButton.BackgroundTransparency = 0.95
                optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.Text = option
                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.TextSize = 14
                optionButton.Font = Enum.Font.GothamBold
                optionButton.ZIndex = 100
                optionButton.Parent = optionsList
                
                -- Check if this option is selected (for DungeonSelector multi-select)
                if name == "DungeonSelector" and _G.selectedDungeonDifficulties then
                    for _, selected in ipairs(_G.selectedDungeonDifficulties) do
                        if selected == option then
                            optionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                            optionButton.BackgroundTransparency = 0.2
                            break
                        end
                    end
                end
                
                -- Corner for option button
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 6)
                buttonCorner.Parent = optionButton
                
                -- Add hover effect (only for non-selected dungeon options)
                optionButton.MouseEnter:Connect(function()
                    if name ~= "DungeonSelector" or optionButton.BackgroundTransparency > 0.5 then
                        optionButton.BackgroundTransparency = 0.9
                        optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        optionButton.TextColor3 = Color3.fromRGB(0, 170, 255)
                    end
                end)
                
                optionButton.MouseLeave:Connect(function()
                    if name ~= "DungeonSelector" or optionButton.BackgroundTransparency > 0.5 then
                        optionButton.BackgroundTransparency = 0.95
                        optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    if name == "StarSelector" then
                        selected.Text = option
                        _G.selectedStar = option
                        optionsFrame.Visible = false
                        saveConfig()
                    elseif name == "GachaSelector" then
                        selected.Text = option
                        _G.selectedGacha = option
                        optionsFrame.Visible = false
                        saveConfig()
                    elseif name == "DungeonSelector" then
                        -- Multi-select for dungeon difficulties
                        if not _G.selectedDungeonDifficulties then
                            _G.selectedDungeonDifficulties = {}
                        end
                        
                        -- Toggle selection
                        local found = false
                        for i, difficulty in ipairs(_G.selectedDungeonDifficulties) do
                            if difficulty == option then
                                -- Remove if already selected
                                table.remove(_G.selectedDungeonDifficulties, i)
                                found = true
                                optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                optionButton.BackgroundTransparency = 0.95
                                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                print("Removed dungeon difficulty:", option)
                                break
                            end
                        end
                        
                        if not found then
                            -- Add if not selected
                            table.insert(_G.selectedDungeonDifficulties, option)
                            optionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                            optionButton.BackgroundTransparency = 0.2
                            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            print("Added dungeon difficulty:", option)
                        end
                        
                        -- Update selected text display
                        local selectedText = #_G.selectedDungeonDifficulties > 0 and 
                                           table.concat(_G.selectedDungeonDifficulties, ", ") or "None"
                        selected.Text = selectedText
                        searchBox.Text = selectedText
                        
                        saveConfig()
                        -- Don't close options frame for multi-select
                    else
                        selected.Text = option
                        optionsFrame.Visible = false
                        saveConfig()
                    end
                end)
                
                yOffset = yOffset + 35
            end
        end
    end
    
    -- Initialize option buttons
    createOptionButtons("")
    
    -- Add search functionality (only for non-dungeon selectors)
    if name ~= "DungeonSelector" then
        searchBox.Changed:Connect(function(property)
            if property == "Text" then
                createOptionButtons(searchBox.Text)
            end
        end)
    end
    
    -- Handle dropdown visibility
    dropdownButton.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
        if optionsFrame.Visible then
            updateOptionsFramePosition()
            if name ~= "DungeonSelector" then
                searchBox.Text = selected.Text
                createOptionButtons(searchBox.Text)
                searchBox:CaptureFocus()
            else
                createOptionButtons("")
            end
        end
    end)
    
    -- Handle selected textbox focus
    selected.Focused:Connect(function()
        optionsFrame.Visible = true
        updateOptionsFramePosition()
        if name ~= "DungeonSelector" then
            searchBox.Text = selected.Text
            createOptionButtons(searchBox.Text)
            searchBox:CaptureFocus()
        else
            createOptionButtons("")
        end
    end)
    
    -- Handle search box focus lost
    searchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and name ~= "DungeonSelector" then
            -- Only auto-select for single-select dropdowns
            local firstButton = optionsList:FindFirstChildWhichIsA("TextButton")
            if firstButton then
                selected.Text = firstButton.Text
                if name == "StarSelector" then
                    _G.selectedStar = firstButton.Text
                elseif name == "GachaSelector" then
                    _G.selectedGacha = firstButton.Text
                end
                optionsFrame.Visible = false
                saveConfig()
            end
        end
    end)
    
    -- Update position when screen changes
    RunService.RenderStepped:Connect(function()
        if optionsFrame.Visible then
            updateOptionsFramePosition()
        end
    end)
    
    -- Add click away handler (more lenient for DungeonSelector)
    local function onMouseClick(input)
        local inBounds = false
        local mousePos = input.Position
        local framePos = dropdownContainer.AbsolutePosition
        local frameSize = dropdownContainer.AbsoluteSize
        local optionsPos = optionsFrame.AbsolutePosition
        local optionsSize = optionsFrame.AbsoluteSize
        
        -- Check if click is within main dropdown or options frame
        if mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
           mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y then
            inBounds = true
        end
        
        if optionsFrame.Visible and
           mousePos.X >= optionsPos.X and mousePos.X <= optionsPos.X + optionsSize.X and
           mousePos.Y >= optionsPos.Y and mousePos.Y <= optionsPos.Y + optionsSize.Y then
            inBounds = true
        end
        
        -- Only close for single-select dropdowns or explicit close action
        if not inBounds and name ~= "DungeonSelector" then
            optionsFrame.Visible = false
        end
    end
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            onMouseClick(input)
        end
    end)
    
    return dropdownContainer, selected
end

-- Game Frame Content
-- Auto Farm Toggle (indented under FARM)
local autoFarmToggle, autoFarmKnob, autoFarmBg = createToggleButton("AutoFarm", "Auto Attack", scrollFrame)
if autoFarmToggle and autoFarmToggle.Parent then
    autoFarmToggle.Parent.Position = UDim2.new(0, 30, 0, 25) -- Indented
else
    warn("Failed to create Auto Farm toggle")
    return
end

-- Auto Dungeon Toggle (under Auto Attack in FARM category)
local autoDungeonToggle, autoDungeonKnob, autoDungeonBg = createToggleButton("AutoDungeon", "Auto Dungeon", scrollFrame)
if autoDungeonToggle and autoDungeonToggle.Parent then
    autoDungeonToggle.Parent.Position = UDim2.new(0, 30, 0, 55) -- Below Auto Attack
else
    warn("Failed to create Auto Dungeon toggle")
    return
end

-- Dungeon Difficulty MultiSelect Dropdown
local dungeonDifficulties = {
    "Easy",
    "Medium",
    "Hard",
    "Insane",
    "Crazy",
    "Nightmare"
}
local dungeonDropdown, dungeonSelected = createDropdown("DungeonSelector", dungeonDifficulties, scrollFrame, UDim2.new(0, 30, 0, 95)) -- Below Dungeon toggle
if not dungeonDropdown then
    warn("Failed to create Dungeon difficulty selector dropdown")
    return
end

-- Star section under GACHA
-- Star Toggle
local autoStarToggle, autoStarKnob, autoStarBg = createToggleButton("AutoStar", "Open Star", scrollFrame)
if autoStarToggle and autoStarToggle.Parent then
    autoStarToggle.Parent.Position = UDim2.new(0, 30, 0, 235) -- Adjusted position
else
    warn("Failed to create Auto Star toggle")
    return
end

-- Create Star selector dropdown
local starOptions = {}
for i = 1, 22 do
    table.insert(starOptions, "Star_" .. i)
end
local starDropdown, starSelected = createDropdown("StarSelector", starOptions, scrollFrame, UDim2.new(0, 30, 0, 270)) -- Adjusted position
if not starDropdown then
    warn("Failed to create Star selector dropdown")
    return
end

-- Auto Rank Toggle under UPGRADE category
local autoRankToggle, autoRankKnob, autoRankBg = createToggleButton("AutoRank", "Auto Rank Up", scrollFrame)
if autoRankToggle and autoRankToggle.Parent then
    autoRankToggle.Parent.Position = UDim2.new(0, 30, 0, 165) -- Adjusted position
else
    warn("Failed to create Auto Rank toggle")
    return
end

-- Gacha section
-- Create list of formatted gacha names
local formattedGachaList = {}
for _, gachaName in pairs(worldGachaMap) do
    table.insert(formattedGachaList, gachaName)
end
-- Sort the list by world number
table.sort(formattedGachaList)

-- Create Auto Gacha toggle
local autoGachaToggle, autoGachaKnob, autoGachaBg = createToggleButton("AutoGacha", "Open Gacha", scrollFrame)
if autoGachaToggle and autoGachaToggle.Parent then
    autoGachaToggle.Parent.Position = UDim2.new(0, 30, 0, 305) -- Adjusted position
else
    warn("Failed to create Auto Gacha toggle")
    return
end

-- Create Gacha selector dropdown
local gachaDropdown, gachaSelected = createDropdown("GachaSelector", formattedGachaList, scrollFrame, UDim2.new(0, 30, 0, 340)) -- Adjusted position
if not gachaDropdown then
    warn("Failed to create Gacha selector dropdown")
    return
end

-- Misc Frame Content
-- Speed Toggle
local speedToggle, speedKnob, speedBg = createToggleButton("Speed", "Speed", miscFrame)
speedToggle.Parent.Position = UDim2.new(0, 20, 0, 10)

-- Claim Codes Button (not a toggle)
local claimCodesBtn = Instance.new("TextButton")
claimCodesBtn.Name = "ClaimCodesBtn"
claimCodesBtn.Size = UDim2.new(0, 250, 0, 35)
claimCodesBtn.Position = UDim2.new(0, 20, 0, 55) -- Positioned below speed toggle
claimCodesBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
claimCodesBtn.BorderSizePixel = 0
claimCodesBtn.Text = "Claim All Codes"
claimCodesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
claimCodesBtn.TextSize = 14
claimCodesBtn.Font = Enum.Font.GothamBold
claimCodesBtn.Parent = miscFrame

local claimCodesCorner = Instance.new("UICorner")
claimCodesCorner.CornerRadius = UDim.new(0, 8)
claimCodesCorner.Parent = claimCodesBtn

-- Function to update UI based on config
local function updateUIFromConfig()
    -- Update Auto Farm toggle
    updateToggleState(autoFarmToggle, autoFarmKnob, autoFarmBg, _G.autoEnabled)
    
    -- Update Auto Dungeon toggle
    updateToggleState(autoDungeonToggle, autoDungeonKnob, autoDungeonBg, _G.autoDungeonEnabled)
    
    -- Update Speed toggle
    updateToggleState(speedToggle, speedKnob, speedBg, _G.speedHack)
    
    -- Update Auto Star toggle
    updateToggleState(autoStarToggle, autoStarKnob, autoStarBg, _G.autoSpinEnabled)
    
    -- Update Auto Rank toggle
    updateToggleState(autoRankToggle, autoRankKnob, autoRankBg, _G.autoRankEnabled)
    
    -- Update Star Selector
    if starSelected then
        starSelected.Text = _G.selectedStar or "Star_1"
        print("Updated star selector to:", _G.selectedStar)
    end
    
    -- Update Dungeon Selector
    if dungeonSelected then
        local selectedText = table.concat(_G.selectedDungeonDifficulties or {"Easy"}, ", ")
        dungeonSelected.Text = selectedText
    end
    
    -- Update Gacha Selector and Toggle
    if gachaSelected then
        -- Fix the reference to use the correct formatted gacha list
        _G.selectedGacha = _G.selectedGacha or formattedGachaList[1]
        gachaSelected.Text = _G.selectedGacha
        print("Updated gacha selector to:", _G.selectedGacha)
    end
    updateToggleState(autoGachaToggle, autoGachaKnob, autoGachaBg, _G.autoGachaEnabled)
end

-- Update UI based on loaded config
updateUIFromConfig()

-- Drag functionality
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Hide/Show UI functionality
local uiHidden = false
local showButtonDragging = false
local showButtonDragStart = nil
local showButtonStartPos = nil
local dragThreshold = 5 -- Minimum pixels to consider as dragging

hideButton.MouseButton1Click:Connect(function()
    uiHidden = true
    -- Store the current position of the main frame before hiding
    local currentPos = mainFrame.Position
    showButton.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale, currentPos.Y.Offset)
    mainFrame.Visible = false
    showButton.Visible = true
    print("UI hidden - drag 'QB' to move or click to restore")
end)

-- Drag functionality for show button
showButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        showButtonDragging = false -- Reset dragging state
        showButtonDragStart = input.Position
        showButtonStartPos = showButton.Position
    end
end)

showButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and showButtonDragStart then
        local delta = input.Position - showButtonDragStart
        local dragDistance = math.sqrt(delta.X^2 + delta.Y^2)
        
        -- Only start dragging if moved beyond threshold
        if dragDistance > dragThreshold then
            showButtonDragging = true
            showButton.Position = UDim2.new(showButtonStartPos.X.Scale, showButtonStartPos.X.Offset + delta.X, showButtonStartPos.Y.Scale, showButtonStartPos.Y.Offset + delta.Y)
        end
    end
end)

showButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Only restore UI if it wasn't a drag operation
        if not showButtonDragging then
            uiHidden = false
            -- Restore main frame to the current position of show button
            mainFrame.Position = showButton.Position
            mainFrame.Visible = true
            showButton.Visible = false
            print("UI restored")
        end
        
        -- Reset drag state
        showButtonDragging = false
        showButtonDragStart = nil
    end
end)

-- Hover effects for buttons
hideButton.MouseEnter:Connect(function()
    hideButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)

hideButton.MouseLeave:Connect(function()
    hideButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

showButton.MouseEnter:Connect(function()
    showButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

showButton.MouseLeave:Connect(function()
    showButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
end)

-- Function to get codes from GitHub
local function getCodes()
    local codes = {}
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/QBGamer/AE/refs/heads/main/code")
    end)
    
    if success and result then
        for code in result:gmatch("[^\r\n]+") do
            if code and code ~= "" then
                table.insert(codes, code)
            end
        end
    else
        warn("Failed to fetch codes from GitHub")
    end
    
    return codes
end

-- Function to claim all codes
local function claimAllCodes()
    print("Fetching codes from GitHub...")
    local codes = getCodes()
    
    if #codes > 0 then
        print("Found " .. #codes .. " codes. Claiming...")
        
        for i, code in ipairs(codes) do
            local args = {
                [1] = {
                    ["Action"] = "_Redeem_Code",
                    ["Text"] = code
                }
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            print("Claimed code: " .. code)
        end
        
        print("All codes claimed!")
    else
        warn("No codes found!")
    end
end

-- Initialize state variables
-- _G.selectedStar is already set from config, don't override it
if not _G.speedHack then _G.speedHack = false end

-- Button Functions
local function connectToggleButton(toggle, knob, bg, globalVar, name, onToggle)
    if not toggle or not toggle.Parent then
        warn("Failed to connect", name, "toggle - Toggle button is null or destroyed")
        return
    end
    if not knob or not knob.Parent then
        warn("Failed to connect", name, "toggle - Toggle knob is null or destroyed")
        return
    end
    if not bg or not bg.Parent then
        warn("Failed to connect", name, "toggle - Toggle background is null or destroyed")
        return
    end
    
    toggle.MouseButton1Click:Connect(function()
        _G[globalVar] = not _G[globalVar]
        updateToggleState(toggle, knob, bg, _G[globalVar])
        print(name .. ":", _G[globalVar] and "ON" or "OFF")
        if onToggle then onToggle() end
        saveConfig()
    end)
end

-- Connect Auto Farm toggle
connectToggleButton(autoFarmToggle, autoFarmKnob, autoFarmBg, "autoEnabled", "Auto Farm")

-- Connect Auto Dungeon toggle
connectToggleButton(autoDungeonToggle, autoDungeonKnob, autoDungeonBg, "autoDungeonEnabled", "Auto Dungeon")

-- Connect Speed toggle
connectToggleButton(speedToggle, speedKnob, speedBg, "speedHack", "Speed Hack", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        if not _G.speedHack then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Connect Auto Star toggle
connectToggleButton(autoStarToggle, autoStarKnob, autoStarBg, "autoSpinEnabled", "Auto Star", function()
    if _G.autoSpinEnabled and starSelected then
        print("Selected Star:", starSelected.Text)
    end
end)

-- Update selected star when changed
starSelected.FocusLost:Connect(function()
    _G.selectedStar = starSelected.Text
    print("Selected Star updated to:", _G.selectedStar)
    saveConfig()
end)

-- Connect Auto Rank toggle
connectToggleButton(autoRankToggle, autoRankKnob, autoRankBg, "autoRankEnabled", "Auto Rank")

claimCodesBtn.MouseButton1Click:Connect(function()
    claimCodesBtn.Text = "Claiming..."
    claimCodesBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
    
    -- Claim all codes
    claimAllCodes()
    
    wait(2)
    claimCodesBtn.Text = "Claim All Codes"
    claimCodesBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
end)

-- Tìm quái gần nhất
local function findNearestMonster(playerPosition)
    local workspace = game:GetService("Workspace")
    local debris = workspace:FindFirstChild("Debris")
    
    if not debris then
        return nil
    end
    
    local monsters = debris:FindFirstChild("Monsters")
    if not monsters then
        return nil
    end
    
    local nearestMonster = nil
    local shortestDistance = math.huge
    
    for _, monster in pairs(monsters:GetChildren()) do
        if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
            local distance = (monster.HumanoidRootPart.Position - playerPosition).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestMonster = monster
            end
        end
    end
    
    return nearestMonster
end

-- Auto rank up function (mỗi 5 giây)
local function autoRankUp()
    if not _G.autoRankEnabled then
        return
    end
    
    local currentTime = tick()
    if currentTime - lastRankTime >= 5 then -- 5 giây
        lastRankTime = currentTime
        
        local args = {
            [1] = {
                ["Upgrading_Name"] = "Rank",
                ["Action"] = "_Upgrades", 
                ["Upgrade_Name"] = "Rank_Up"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
        print("Auto ranking up...")
    end
end

-- Anti-AFK function
local function antiAFK()
    local virtualUser = game:GetService('VirtualUser')
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
        print("Anti-AFK: Prevented AFK kick!")
    end)
end

-- Auto quay function
local function autoSpin()
    if not _G.autoSpinEnabled then
        return
    end
    
    if _G.selectedStar then
        local args = {
            [1] = {
                ["Open_Amount"] = 20,
                ["Action"] = "_Stars",
                ["Name"] = _G.selectedStar
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
        print("Auto spinning with: " .. _G.selectedStar)
    else
        warn("No star selected")
    end
end

-- Tìm và đánh quái liên tục cho đến khi chết
local function findAndKillMonster()
    if not _G.autoEnabled then
        return false
    end
    
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local playerPosition = player.Character.HumanoidRootPart.Position
    local monster = findNearestMonster(playerPosition)
    
    -- Check if player is in dungeon for teleportation
    local dungeonUI = playerGui:FindFirstChild("Dungeon")
    local inDungeon = false
    if dungeonUI then
        local defaultHeader = dungeonUI:FindFirstChild("Default_Header")
        inDungeon = defaultHeader and defaultHeader.Visible
        
        -- Update dungeon enter time when first entering dungeon
        if inDungeon and dungeonEnterTime == 0 then
            dungeonEnterTime = tick()
            -- Reset current monster ID when entering dungeon to avoid teleporting outside
            currentTargetId = nil
            print("Entered dungeon, waiting 5 seconds before teleporting to monsters...")
            print("Reset monster ID for fresh dungeon start")
        elseif not inDungeon and dungeonEnterTime > 0 then
            -- Reset when leaving dungeon
            dungeonEnterTime = 0
        end
    end
    
    if monster then
        if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
            local monsterId = monster.Name
            
            -- Teleport to monster if in dungeon
            if inDungeon and dungeonEnterTime > 0 then
                local currentTime = tick()
                local timeSinceEnter = currentTime - dungeonEnterTime

                -- Only teleport if at least 10 seconds have passed since entering dungeon
                if timeSinceEnter >= 10 then
                    player.Character.HumanoidRootPart.CFrame = monster.HumanoidRootPart.CFrame
                end
            end
            
            -- Đánh quái
            local args = {
                [1] = {
                    ["Id"] = monsterId,
                    ["Action"] = "_Mouse_Click"
                }
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            
            return true -- Trả về true để tiếp tục đánh
        end
    else
        -- Không có quái gần, gọi _Mouse_Click không cần monster ID
        local args = {
            [1] = {
                ["Action"] = "_Mouse_Click"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
        
        -- Reset current target when no monsters found
        if currentTargetId then
            print("Monster defeated: " .. currentTargetId)
            currentTargetId = nil
        end
    end
    
    return false
end

-- Gắn speed chỉ khi bật speed hack
getgenv().AnimeEternalSpeedEnforce = RunService.Heartbeat:Connect(function()
    if _G.speedHack and player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 150
    end
end)

-- Setup Anti-AFK (only needs to be called once)
antiAFK()

-- Tạo connection để đảm bảo UI luôn hiển thị
getgenv().AnimeEternalUICheck = RunService.Heartbeat:Connect(function()
    if screenGui and not screenGui.Enabled then
        screenGui.Enabled = true
    end
    -- Don't force mainFrame to be visible if user intentionally hid it
    if not uiHidden and mainFrame and not mainFrame.Visible then
        mainFrame.Visible = true
    end
end)

-- Chạy script liên tục
print("Starting AnimeEternal Script...")
getgenv().AnimeEternalScript = RunService.Heartbeat:Connect(function()
    if _G.autoEnabled then
        local foundMonster = findAndKillMonster()
        if not foundMonster then
            wait(0.1) -- Thêm wait khi không tìm thấy quái để tránh đơ
        end
    end
    
    -- Auto quay (chạy độc lập với auto đánh quái)
    autoSpin()
    
    -- Auto rank up (chạy độc lập)
    autoRankUp()
    
    -- Auto gacha (chạy độc lập)
    if _G.autoGachaEnabled and _G.selectedGacha then
        -- Extract the actual gacha name from the formatted string (e.g., "W16-Stands" -> "Stands")
        local actualGachaName = _G.selectedGacha:match("W%d+%-(.+)")
        if actualGachaName then
            local args = {
                [1] = {
                    ["Open_Amount"] = 4,
                    ["Action"] = "_Gacha_Activate",
                    ["Name"] = actualGachaName
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            print("Auto opening gacha:", _G.selectedGacha)
        end
    end
    
    -- Auto dungeon (chạy độc lập)
    if _G.autoDungeonEnabled and _G.selectedDungeonDifficulties and #_G.selectedDungeonDifficulties > 0 then
        -- Check if there's a dungeon notification
        local dungeonUI = playerGui:FindFirstChild("Dungeon")
        if dungeonUI then
            -- First check if player is already in dungeon
            local defaultHeader = dungeonUI:FindFirstChild("Default_Header")
            if defaultHeader and defaultHeader.Visible then
                -- Player is already in dungeon, don't enter another one
                return
            end
            
            local dungeonNotification = dungeonUI:FindFirstChild("Dungeon_Notification")
            if dungeonNotification and dungeonNotification.Visible then
                local textLabel = dungeonNotification:FindFirstChild("TextLabel")
                if textLabel then
                    local notificationText = textLabel.Text
                    -- Extract difficulty from text like "<font color="#ff0073">Dungeon Hard</font> is starting! Ready to dive in?"
                    local difficulty = notificationText:match('Dungeon%s+(%w+)</font>')
                    
                    if difficulty then
                        -- Check if this difficulty is selected by player
                        for _, selectedDifficulty in ipairs(_G.selectedDungeonDifficulties) do
                            if selectedDifficulty == difficulty then
                                -- Found matching difficulty, enter the dungeon
                                local args = {
                                    [1] = {
                                        ["Action"] = "_Enter_Dungeon",
                                        ["Name"] = "Dungeon_" .. difficulty
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
                                print("Auto entering dungeon with difficulty:", difficulty)
                                
                                -- Hide the dungeon notification after entering
                                wait(0.5) -- Wait a bit for the server to process
                                dungeonNotification.Visible = false
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Gacha toggle handler
connectToggleButton(autoGachaToggle, autoGachaKnob, autoGachaBg, "autoGachaEnabled", "Auto Gacha")

-- Update selected gacha when changed
gachaSelected.FocusLost:Connect(function()
    _G.selectedGacha = gachaSelected.Text
    print("Selected Gacha updated to:", _G.selectedGacha)
    saveConfig()
end)

print("AnimeEternal Script started successfully!")
print("UI created - Drag to move!")