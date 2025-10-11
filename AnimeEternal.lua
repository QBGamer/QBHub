
local saveConfig
local loadConfig = function()
    if not isfile("AE_config.json") then
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


if not _G.autoEnabled then _G.autoEnabled = false end
if not _G.speedMultiplier then _G.speedMultiplier = 1 end
if not _G.autoSpinEnabled then _G.autoSpinEnabled = false end
if not _G.autoRankEnabled then _G.autoRankEnabled = false end
if not _G.autoGachaEnabled then _G.autoGachaEnabled = false end
if not _G.selectedGacha then _G.selectedGacha = "Dragon_Race" end
if not _G.autoDungeonEnabled then _G.autoDungeonEnabled = false end
if not _G.selectedDungeonDifficulties then _G.selectedDungeonDifficulties = {"Easy"} end


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


local autoEnabled = _G.autoEnabled
local speedMultiplier = _G.speedMultiplier
local autoSpinEnabled = _G.autoSpinEnabled
local autoRankEnabled = _G.autoRankEnabled

saveConfig = function()
    
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
    
    local HttpService = game:GetService("HttpService")
    pcall(function() HttpService.HttpEnabled = true end)
    
    local success, encoded = pcall(function()
        return HttpService:JSONEncode(config)
    end)
    
    if success then
        local filePath = "AE_config.json"
        writefile(filePath, encoded)
    else
        warn("Failed to save configuration!")
    end
end

loadConfig = function()
    if not isfile("AE_config.json") then
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


if getgenv().AnimeEternalScript then
    pcall(function()
        getgenv().AnimeEternalScript:Disconnect()
    end)
    getgenv().AnimeEternalScript = nil
    wait(0.5) 
end


if getgenv().AnimeEternalInputConnection then
    pcall(function()
        getgenv().AnimeEternalInputConnection:Disconnect()
    end)
    getgenv().AnimeEternalInputConnection = nil
end


if getgenv().AnimeEternalSpeedCheck then
    pcall(function()
        getgenv().AnimeEternalSpeedCheck:Disconnect()
    end)
    getgenv().AnimeEternalSpeedCheck = nil
end


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




local config = loadConfig()


_G.autoEnabled = config.autoEnabled or false
_G.speedMultiplier = config.speedMultiplier or 1
_G.autoSpinEnabled = config.autoSpinEnabled or false
_G.autoRankEnabled = config.autoRankEnabled or false
_G.selectedStar = config.selectedStar or "Star_1"
_G.autoGachaEnabled = config.autoGachaEnabled or false
_G.selectedGacha = config.selectedGacha or "Dragon_Race"
_G.autoDungeonEnabled = config.autoDungeonEnabled or false
_G.selectedDungeonDifficulties = config.selectedDungeonDifficulties or {"Easy"}


local currentTargetId = nil
local claimCodesEnabled = false
local lastRankTime = 0
local dungeonEnterTime = 0


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnimeEternalUI"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 9999 
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true 
screenGui.Parent = playerGui
getgenv().AnimeEternalUI = screenGui


local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 310) 
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui


local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(0, 60, 1, -30) 
tabContainer.Position = UDim2.new(0, 0, 0, 30) 
tabContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame


local gameTab = Instance.new("TextButton")
gameTab.Name = "GameTab"
gameTab.Size = UDim2.new(1, 0, 0, 70) 
gameTab.Position = UDim2.new(0, 0, 0, 0)
gameTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
gameTab.BorderSizePixel = 0
gameTab.Text = "Game"
gameTab.TextColor3 = Color3.fromRGB(255, 255, 255)
gameTab.TextSize = 16
gameTab.Font = Enum.Font.GothamBold
gameTab.Parent = tabContainer


local miscTab = Instance.new("TextButton")
miscTab.Name = "MiscTab"
miscTab.Size = UDim2.new(1, 0, 0, 70) 
miscTab.Position = UDim2.new(0, 0, 0, 70) 
miscTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
miscTab.BorderSizePixel = 0
miscTab.Text = "Misc"
miscTab.TextColor3 = Color3.fromRGB(200, 200, 200)
miscTab.TextSize = 16
miscTab.Font = Enum.Font.GothamBold
miscTab.Parent = tabContainer


local gameFrame = Instance.new("Frame")
gameFrame.Name = "GameFrame"
gameFrame.Size = UDim2.new(1, -50, 1, -30) 
gameFrame.Position = UDim2.new(0, 50, 0, 30) 
gameFrame.BackgroundTransparency = 1
gameFrame.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ContentScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -10) 
scrollFrame.Position = UDim2.new(0, 5, 0, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 490) 
scrollFrame.Parent = gameFrame


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
upgradeCategory.Position = UDim2.new(0, 15, 0, 140) 
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
gachaCategory.Position = UDim2.new(0, 15, 0, 205) 
gachaCategory.BackgroundTransparency = 1
gachaCategory.Text = "GACHA"
gachaCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
gachaCategory.TextSize = 18
gachaCategory.Font = Enum.Font.GothamBlack
gachaCategory.TextXAlignment = Enum.TextXAlignment.Left
gachaCategory.Parent = scrollFrame


local miscFrame = Instance.new("Frame")
miscFrame.Name = "MiscFrame"
miscFrame.Size = UDim2.new(1, -50, 1, -30) 
miscFrame.Position = UDim2.new(0, 50, 0, 30) 
miscFrame.BackgroundTransparency = 1
miscFrame.Visible = false
miscFrame.Parent = mainFrame


local function switchTab(toGame)
    
    
    
    
    gameFrame.Visible = toGame
    miscFrame.Visible = not toGame
    
    
    local activeIndicator = Instance.new("Frame")
    activeIndicator.Name = "ActiveIndicator"
    activeIndicator.Size = UDim2.new(0, 3, 1, 0)
    activeIndicator.Position = UDim2.new(0, 0, 0, 0)
    activeIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    activeIndicator.BorderSizePixel = 0
    
    
    for _, tab in pairs(tabContainer:GetChildren()) do
        if tab:FindFirstChild("ActiveIndicator") then
            tab.ActiveIndicator:Destroy()
        end
    end
    
    
    activeIndicator:Clone().Parent = toGame and gameTab or miscTab
end

gameTab.MouseButton1Click:Connect(function()
    switchTab(true)
end)

miscTab.MouseButton1Click:Connect(function()
    switchTab(false)
end)


local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame


local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 0
title.Text = "QBHUB - Anime Eternal"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame


local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title


local function createToggleButton(name, text, parent)
    if not parent or not parent.Parent then
        warn("Parent is null or destroyed when creating toggle button:", name)
        return nil, nil, nil
    end

        
        local container = Instance.new("Frame")
        container.Name = name .. "Container"
        container.Size = UDim2.new(0, 250, 0, 40) 
        container.BackgroundTransparency = 1
        container.Parent = parent    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 1, 0) 
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    
    local hitbox = Instance.new("TextButton")
    hitbox.Name = "ToggleHitbox"
    hitbox.Size = UDim2.new(0, 40, 0, 20)
    hitbox.Position = UDim2.new(1, -40, 0.5, -10)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.Parent = container
    
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBackground"
    toggleBg.Size = UDim2.new(1, 0, 1, 0)
    toggleBg.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggleBg.Parent = hitbox
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = toggleBg
    
    
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


local function updateToggleState(button, toggleKnob, toggleBg, enabled)
    
    if not toggleKnob or not toggleKnob.Parent then
        warn("Toggle knob is null or destroyed")
        return
    end
    
    if not toggleBg or not toggleBg.Parent then
        warn("Toggle background is null or destroyed")
        return
    end
    
    
    local targetPosition = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    local targetColor = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(70, 70, 70)
    
    
    local success, knobTween = pcall(function()
        return TweenService:Create(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPosition})
    end)
    
    if success and knobTween then
        knobTween:Play()
    else
        
        toggleKnob.Position = targetPosition
    end
    
    local success2, bgTween = pcall(function()
        return TweenService:Create(toggleBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor})
    end)
    
    if success2 and bgTween then
        bgTween:Play()
    else
        
        toggleBg.BackgroundColor3 = targetColor
    end
end


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
    
    
    local selected = Instance.new("TextBox")
    selected.Name = "Selected"
    selected.Size = UDim2.new(1, -30, 1, 0)
    selected.Position = UDim2.new(0, 10, 0, 0)
    selected.BackgroundTransparency = 1
    selected.Text = options[1]
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
    optionsFrame.Size = UDim2.new(1, 0, 0, 175) 
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 100
    optionsFrame.Parent = screenGui
    
    
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
    
    
    if name == "DungeonSelector" then
        searchBox.Visible = false
    end
    
    
    local searchBoxCorner = Instance.new("UICorner")
    searchBoxCorner.CornerRadius = UDim.new(0, 6)
    searchBoxCorner.Parent = searchBox
    
    local optionsList = Instance.new("ScrollingFrame")
    optionsList.Name = "OptionsList"
    optionsList.Size = UDim2.new(1, -10, 1, -45) 
    optionsList.Position = UDim2.new(0, 5, 0, 40) 
    optionsList.BackgroundTransparency = 1
    optionsList.BorderSizePixel = 0
    optionsList.ScrollBarThickness = 4
    optionsList.ScrollingDirection = Enum.ScrollingDirection.Y
    optionsList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    optionsList.ZIndex = 100
    optionsList.Parent = optionsFrame
    
    
    local closeButton = nil
    if name == "DungeonSelector" then
        
        optionsFrame.Size = UDim2.new(1, 0, 0, 145) 
        
        
        optionsList.Size = UDim2.new(1, -10, 1, -35) 
        optionsList.Position = UDim2.new(0, 5, 0, 5) 
        
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
    
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    
    local function updateOptionsFramePosition()
        local dropdownPos = dropdownContainer.AbsolutePosition
        local dropdownSize = dropdownContainer.AbsoluteSize
        optionsFrame.Position = UDim2.new(0, dropdownPos.X, 0, dropdownPos.Y + dropdownSize.Y + 5)
        optionsFrame.Size = UDim2.new(0, dropdownSize.X, 0, 140)
    end
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsFrame
    
    
    local function createOptionButtons(filterText)
        
        for _, child in pairs(optionsList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local yOffset = 0
        
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
                
                
                if name == "DungeonSelector" and _G.selectedDungeonDifficulties then
                    for _, selected in ipairs(_G.selectedDungeonDifficulties) do
                        if selected == option then
                            optionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                            optionButton.BackgroundTransparency = 0.2
                            break
                        end
                    end
                end
                
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 6)
                buttonCorner.Parent = optionButton
                
                
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
                        
                        if not _G.selectedDungeonDifficulties then
                            _G.selectedDungeonDifficulties = {}
                        end
                        
                        
                        local found = false
                        for i, difficulty in ipairs(_G.selectedDungeonDifficulties) do
                            if difficulty == option then
                                
                                table.remove(_G.selectedDungeonDifficulties, i)
                                found = true
                                optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                optionButton.BackgroundTransparency = 0.95
                                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                break
                            end
                        end
                        
                        if not found then
                            
                            table.insert(_G.selectedDungeonDifficulties, option)
                            optionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                            optionButton.BackgroundTransparency = 0.2
                            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                        
                        
                        local selectedText = #_G.selectedDungeonDifficulties > 0 and 
                                           table.concat(_G.selectedDungeonDifficulties, ", ") or "None"
                        selected.Text = selectedText
                        searchBox.Text = selectedText
                        
                        saveConfig()
                        
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
    
    
    createOptionButtons("")
    
    
    if name ~= "DungeonSelector" then
        searchBox.Changed:Connect(function(property)
            if property == "Text" then
                createOptionButtons(searchBox.Text)
            end
        end)
    end
    
    
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
    
    
    searchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and name ~= "DungeonSelector" then
            
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
    
    
    RunService.RenderStepped:Connect(function()
        if optionsFrame.Visible then
            updateOptionsFramePosition()
        end
    end)
    
    
    local function onMouseClick(input)
        local inBounds = false
        local mousePos = input.Position
        local framePos = dropdownContainer.AbsolutePosition
        local frameSize = dropdownContainer.AbsoluteSize
        local optionsPos = optionsFrame.AbsolutePosition
        local optionsSize = optionsFrame.AbsoluteSize
        
        
        if mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
           mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y then
            inBounds = true
        end
        
        if optionsFrame.Visible and
           mousePos.X >= optionsPos.X and mousePos.X <= optionsPos.X + optionsSize.X and
           mousePos.Y >= optionsPos.Y and mousePos.Y <= optionsPos.Y + optionsSize.Y then
            inBounds = true
        end
        
        
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



local autoFarmToggle, autoFarmKnob, autoFarmBg = createToggleButton("AutoFarm", "Auto Attack", scrollFrame)
if autoFarmToggle and autoFarmToggle.Parent then
    autoFarmToggle.Parent.Position = UDim2.new(0, 30, 0, 25) 
else
    warn("Failed to create Auto Farm toggle")
    return
end


local autoDungeonToggle, autoDungeonKnob, autoDungeonBg = createToggleButton("AutoDungeon", "Auto Dungeon", scrollFrame)
if autoDungeonToggle and autoDungeonToggle.Parent then
    autoDungeonToggle.Parent.Position = UDim2.new(0, 30, 0, 55) 
else
    warn("Failed to create Auto Dungeon toggle")
    return
end


local dungeonDifficulties = {
    "Easy",
    "Medium",
    "Hard",
    "Insane",
    "Crazy",
    "Nightmare"
}
local dungeonDropdown, dungeonSelected = createDropdown("DungeonSelector", dungeonDifficulties, scrollFrame, UDim2.new(0, 30, 0, 95)) 
if not dungeonDropdown then
    warn("Failed to create Dungeon difficulty selector dropdown")
    return
end



local autoStarToggle, autoStarKnob, autoStarBg = createToggleButton("AutoStar", "Open Star", scrollFrame)
if autoStarToggle and autoStarToggle.Parent then
    autoStarToggle.Parent.Position = UDim2.new(0, 30, 0, 235) 
else
    warn("Failed to create Auto Star toggle")
    return
end


local starOptions = {}
for i = 1, 22 do
    table.insert(starOptions, "Star_" .. i)
end
local starDropdown, starSelected = createDropdown("StarSelector", starOptions, scrollFrame, UDim2.new(0, 30, 0, 270)) 
if not starDropdown then
    warn("Failed to create Star selector dropdown")
    return
end


local autoRankToggle, autoRankKnob, autoRankBg = createToggleButton("AutoRank", "Auto Rank Up", scrollFrame)
if autoRankToggle and autoRankToggle.Parent then
    autoRankToggle.Parent.Position = UDim2.new(0, 30, 0, 165) 
else
    warn("Failed to create Auto Rank toggle")
    return
end



local formattedGachaList = {}
for _, gachaName in pairs(worldGachaMap) do
    table.insert(formattedGachaList, gachaName)
end

table.sort(formattedGachaList)


local autoGachaToggle, autoGachaKnob, autoGachaBg = createToggleButton("AutoGacha", "Open Gacha", scrollFrame)
if autoGachaToggle and autoGachaToggle.Parent then
    autoGachaToggle.Parent.Position = UDim2.new(0, 30, 0, 305) 
else
    warn("Failed to create Auto Gacha toggle")
    return
end


local gachaDropdown, gachaSelected = createDropdown("GachaSelector", formattedGachaList, scrollFrame, UDim2.new(0, 30, 0, 340)) 
if not gachaDropdown then
    warn("Failed to create Gacha selector dropdown")
    return
end



local speedToggle, speedKnob, speedBg = createToggleButton("Speed", "Speed", miscFrame)
speedToggle.Parent.Position = UDim2.new(0, 20, 0, 10)


local claimCodesBtn = Instance.new("TextButton")
claimCodesBtn.Name = "ClaimCodesBtn"
claimCodesBtn.Size = UDim2.new(0, 250, 0, 35)
claimCodesBtn.Position = UDim2.new(0, 20, 0, 55) 
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


local function updateUIFromConfig()
    
    updateToggleState(autoFarmToggle, autoFarmKnob, autoFarmBg, _G.autoEnabled)
    
    
    updateToggleState(autoDungeonToggle, autoDungeonKnob, autoDungeonBg, _G.autoDungeonEnabled)
    
    
    updateToggleState(speedToggle, speedKnob, speedBg, _G.speedHack)
    
    
    updateToggleState(autoStarToggle, autoStarKnob, autoStarBg, _G.autoSpinEnabled)
    
    
    updateToggleState(autoRankToggle, autoRankKnob, autoRankBg, _G.autoRankEnabled)
    
        
    if starSelected then
        starSelected.Text = _G.selectedStar or "Star_1"
    end
    
    
    if dungeonSelected then
        local selectedText = table.concat(_G.selectedDungeonDifficulties or {"Easy"}, ", ")
        dungeonSelected.Text = selectedText
    end
    
    
    if gachaSelected then
        gachaSelected.Text = _G.selectedGacha or gachaList[1]
    end
    updateToggleState(autoGachaToggle, autoGachaKnob, autoGachaBg, _G.autoGachaEnabled)
end


updateUIFromConfig()


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


local function claimAllCodes()
    local codes = getCodes()
    
    if #codes > 0 then
        
        for i, code in ipairs(codes) do
            local args = {
                [1] = {
                    ["Action"] = "_Redeem_Code",
                    ["Text"] = code
                }
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            wait(0.5) 
        end
        
    else
        warn("No codes found!")
    end
end


_G.selectedStar = "Star_1"
if not _G.speedHack then _G.speedHack = false end


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
        if onToggle then onToggle() end
        saveConfig()
    end)
end


connectToggleButton(autoFarmToggle, autoFarmKnob, autoFarmBg, "autoEnabled", "Auto Farm")


connectToggleButton(autoDungeonToggle, autoDungeonKnob, autoDungeonBg, "autoDungeonEnabled", "Auto Dungeon")


connectToggleButton(speedToggle, speedKnob, speedBg, "speedHack", "Speed Hack", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        if not _G.speedHack then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)


connectToggleButton(autoStarToggle, autoStarKnob, autoStarBg, "autoSpinEnabled", "Auto Star", function()
    if _G.autoSpinEnabled and starSelected then
    end
end)


starSelected.FocusLost:Connect(function()
    _G.selectedStar = starSelected.Text
    saveConfig()
end)


connectToggleButton(autoRankToggle, autoRankKnob, autoRankBg, "autoRankEnabled", "Auto Rank")

claimCodesBtn.MouseButton1Click:Connect(function()
    claimCodesBtn.Text = "Claiming..."
    claimCodesBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
    
    
    claimAllCodes()
    
    wait(2)
    claimCodesBtn.Text = "Claim All Codes"
    claimCodesBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
end)


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


local function autoRankUp()
    if not _G.autoRankEnabled then
        return
    end
    
    local currentTime = tick()
    if currentTime - lastRankTime >= 5 then 
        lastRankTime = currentTime
        
        local args = {
            [1] = {
                ["Upgrading_Name"] = "Rank",
                ["Action"] = "_Upgrades", 
                ["Upgrade_Name"] = "Rank_Up"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
    end
end


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
    else
        warn("No star selected")
    end
end


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
    
    
    local dungeonUI = playerGui:FindFirstChild("Dungeon")
    local inDungeon = false
    if dungeonUI then
        local defaultHeader = dungeonUI:FindFirstChild("Default_Header")
        inDungeon = defaultHeader and defaultHeader.Visible
        
        
        if inDungeon and dungeonEnterTime == 0 then
            dungeonEnterTime = tick()
        elseif not inDungeon and dungeonEnterTime > 0 then
            
            dungeonEnterTime = 0
        end
    end
    
    if monster then
        if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
            local monsterId = monster.Name
            
            
            if inDungeon and dungeonEnterTime > 0 then
                local currentTime = tick()
                local timeSinceEnter = currentTime - dungeonEnterTime
                
                
                if timeSinceEnter >= 5 then
                    player.Character.HumanoidRootPart.CFrame = monster.HumanoidRootPart.CFrame
                end
            end
            
            
            local args = {
                [1] = {
                    ["Id"] = monsterId,
                    ["Action"] = "_Mouse_Click"
                }
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            
            return true 
        end
    else
        
        local args = {
            [1] = {
                ["Action"] = "_Mouse_Click"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
        
        
        if currentTargetId then
            currentTargetId = nil
        end
    end
    
    return false
end


getgenv().AnimeEternalSpeedEnforce = RunService.Heartbeat:Connect(function()
    if _G.speedHack and player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 150
    end
end)


getgenv().AnimeEternalUICheck = RunService.Heartbeat:Connect(function()
    if screenGui and not screenGui.Enabled then
        screenGui.Enabled = true
    end
end)


getgenv().AnimeEternalScript = RunService.Heartbeat:Connect(function()
    if _G.autoEnabled then
        local foundMonster = findAndKillMonster()
        if not foundMonster then
            wait(0.1) 
        end
    end
    
    
    autoSpin()
    
    
    autoRankUp()
    
    
    if _G.autoGachaEnabled and _G.selectedGacha then
        
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
        end
    end
    
    
    if _G.autoDungeonEnabled and _G.selectedDungeonDifficulties and #_G.selectedDungeonDifficulties > 0 then
        
        local dungeonUI = playerGui:FindFirstChild("Dungeon")
        if dungeonUI then
            
            local defaultHeader = dungeonUI:FindFirstChild("Default_Header")
            if defaultHeader and defaultHeader.Visible then
                
                return
            end
            
            local dungeonNotification = dungeonUI:FindFirstChild("Dungeon_Notification")
            if dungeonNotification and dungeonNotification.Visible then
                local textLabel = dungeonNotification:FindFirstChild("TextLabel")
                if textLabel then
                    local notificationText = textLabel.Text
                    
                    local difficulty = notificationText:match('Dungeon%s+(%w+)</font>')
                    
                    if difficulty then
                        
                        for _, selectedDifficulty in ipairs(_G.selectedDungeonDifficulties) do
                            if selectedDifficulty == difficulty then
                                
                                local args = {
                                    [1] = {
                                        ["Action"] = "_Enter_Dungeon",
                                        ["Name"] = "Dungeon_" .. difficulty
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
                                
                                
                                wait(0.5) 
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


connectToggleButton(autoGachaToggle, autoGachaKnob, autoGachaBg, "autoGachaEnabled", "Auto Gacha")


gachaSelected.FocusLost:Connect(function()
    _G.selectedGacha = gachaSelected.Text
    saveConfig()
end)