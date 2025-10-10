if getgenv().AnimeEternalScript then
    pcall(function()
        getgenv().AnimeEternalScript:Disconnect()
    end)
    getgenv().AnimeEternalScript = nil
    print("Removed old script")
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

local autoEnabled = false
local currentTargetId = nil
local speedMultiplier = 1
local autoSpinEnabled = false
local autoRankEnabled = false
local claimCodesEnabled = false
local lastRankTime = 0

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnimeEternalUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
getgenv().AnimeEternalUI = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 310)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

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

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Name = "AutoFarmBtn"
autoFarmBtn.Size = UDim2.new(0, 250, 0, 35)
autoFarmBtn.Position = UDim2.new(0, 15, 0, 40)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
autoFarmBtn.BorderSizePixel = 0
autoFarmBtn.Text = "Auto Farm: OFF"
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmBtn.TextSize = 12
autoFarmBtn.Font = Enum.Font.Gotham
autoFarmBtn.Parent = mainFrame

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 8)
autoFarmCorner.Parent = autoFarmBtn

local speedBtn = Instance.new("TextButton")
speedBtn.Name = "SpeedBtn"
speedBtn.Size = UDim2.new(0, 250, 0, 35)
speedBtn.Position = UDim2.new(0, 15, 0, 85)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
speedBtn.BorderSizePixel = 0
speedBtn.Text = "Speed: x1"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 12
speedBtn.Font = Enum.Font.Gotham
speedBtn.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedBtn

local autoSpinBtn = Instance.new("TextButton")
autoSpinBtn.Name = "AutoSpinBtn"
autoSpinBtn.Size = UDim2.new(0, 250, 0, 35)
autoSpinBtn.Position = UDim2.new(0, 15, 0, 130)
autoSpinBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
autoSpinBtn.BorderSizePixel = 0
autoSpinBtn.Text = "Auto Open Star: OFF"
autoSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoSpinBtn.TextSize = 12
autoSpinBtn.Font = Enum.Font.Gotham
autoSpinBtn.Parent = mainFrame

local autoSpinCorner = Instance.new("UICorner")
autoSpinCorner.CornerRadius = UDim.new(0, 8)
autoSpinCorner.Parent = autoSpinBtn

local autoRankBtn = Instance.new("TextButton")
autoRankBtn.Name = "AutoRankBtn"
autoRankBtn.Size = UDim2.new(0, 250, 0, 35)
autoRankBtn.Position = UDim2.new(0, 15, 0, 175)
autoRankBtn.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
autoRankBtn.BorderSizePixel = 0
autoRankBtn.Text = "Auto Rank Up: OFF"
autoRankBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoRankBtn.TextSize = 12
autoRankBtn.Font = Enum.Font.Gotham
autoRankBtn.Parent = mainFrame

local autoRankCorner = Instance.new("UICorner")
autoRankCorner.CornerRadius = UDim.new(0, 8)
autoRankCorner.Parent = autoRankBtn

local claimCodesBtn = Instance.new("TextButton")
claimCodesBtn.Name = "ClaimCodesBtn"
claimCodesBtn.Size = UDim2.new(0, 250, 0, 35)
claimCodesBtn.Position = UDim2.new(0, 15, 0, 220)
claimCodesBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
claimCodesBtn.BorderSizePixel = 0
claimCodesBtn.Text = "Claim All Codes"
claimCodesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
claimCodesBtn.TextSize = 12
claimCodesBtn.Font = Enum.Font.Gotham
claimCodesBtn.Parent = mainFrame

local claimCodesCorner = Instance.new("UICorner")
claimCodesCorner.CornerRadius = UDim.new(0, 8)
claimCodesCorner.Parent = claimCodesBtn

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
            wait(0.5)
        end
        
        print("All codes claimed!")
    else
        warn("No codes found!")
    end
end

autoFarmBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    if autoEnabled then
        autoFarmBtn.Text = "Auto Farm: ON"
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        print("AUTO: ON")
    else
        autoFarmBtn.Text = "Auto Farm: OFF"
        autoFarmBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        print("AUTO: OFF")
    end
end)

speedBtn.MouseButton1Click:Connect(function()
    speedMultiplier = speedMultiplier == 1 and 2 or 1
    speedBtn.Text = "Speed: x" .. speedMultiplier
    print("SPEED: x" .. speedMultiplier)

    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        if speedMultiplier == 2 then
            player.Character.Humanoid.WalkSpeed = 150
            speedBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        else
            player.Character.Humanoid.WalkSpeed = 16
            speedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        end
    end
end)

autoSpinBtn.MouseButton1Click:Connect(function()
    autoSpinEnabled = not autoSpinEnabled
    if autoSpinEnabled then
        autoSpinBtn.Text = "Auto Open Star: ON"
        autoSpinBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        print("AUTO OPEN STAR: ON")
    else
        autoSpinBtn.Text = "Auto Open Star: OFF"
        autoSpinBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        print("AUTO OPEN STAR: OFF")
    end
end)

autoRankBtn.MouseButton1Click:Connect(function()
    autoRankEnabled = not autoRankEnabled
    if autoRankEnabled then
        autoRankBtn.Text = "Auto Rank Up: ON"
        autoRankBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        print("AUTO RANK UP: ON")
    else
        autoRankBtn.Text = "Auto Rank Up: OFF"
        autoRankBtn.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        print("AUTO RANK UP: OFF")
    end
end)

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

local function findStarItem()
    local workspace = game:GetService("Workspace")
    local islands = workspace:FindFirstChild("Islands")
    
    if not islands then
        return nil
    end
    
    local function searchInChildren(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child.Name:match("^Star_%d+$") then
                return child.Name
            end
            local found = searchInChildren(child)
            if found then
                return found
            end
        end
        return nil
    end
    
    return searchInChildren(islands)
end

local function autoRankUp()
    if not autoRankEnabled then
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
        print("Auto ranking up...")
    end
end

local function autoSpin()
    if not autoSpinEnabled then
        return
    end
    
    local starName = findStarItem()
    if starName then
        local args = {
            [1] = {
                ["Open_Amount"] = 20,
                ["Action"] = "_Stars",
                ["Name"] = starName
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
        print("Auto spinning with: " .. starName)
    else
        warn("Star item not found")
    end
end

local function findAndKillMonster()
    if not autoEnabled then
        return false
    end
    
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local playerPosition = player.Character.HumanoidRootPart.Position
    local monster = findNearestMonster(playerPosition)
    
    if monster then
        if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
            local monsterId = monster.Name
            
            if currentTargetId ~= monsterId then
                currentTargetId = monsterId
                print("Started attacking monster: " .. monsterId)
            end
            
            local args = {
                [1] = {
                    ["Id"] = monsterId,
                    ["Action"] = "_Mouse_Click"
                }
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            
            wait()
            
            return true
        end
    end
    
    if currentTargetId then
        print("Monster defeated: " .. currentTargetId)
        currentTargetId = nil
    end
    
    warn("No monsters found")
    return false
end

getgenv().AnimeEternalSpeedEnforce = RunService.Heartbeat:Connect(function()
    if speedMultiplier and player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local expectedSpeed = speedMultiplier == 1 and 16 or 150
        player.Character.Humanoid.WalkSpeed = expectedSpeed
    end
end)

print("Starting AnimeEternal Script...")
getgenv().AnimeEternalScript = RunService.Heartbeat:Connect(function()
    if autoEnabled then
        local foundMonster = findAndKillMonster()
        if not foundMonster then
            wait()
        end
    else
        wait()
    end
    
    autoSpin()
    
    autoRankUp()
end)

print("AnimeEternal Script started successfully!")
print("UI created - Drag to move!")