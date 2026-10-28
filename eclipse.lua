--[[
    Eclipse Hub - Flag Frenzy
    Clean Version | Rayfield
    Key: free_99
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Eclipse Hub | Flag Frenzy",
   LoadingTitle = "Eclipse Hub",
   LoadingSubtitle = "Flag Frenzy",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "EclipseHub",
      FileName = "FlagFrenzy"
   },
   Discord = {
      Enabled = true,
      Invite = "nE3vUVJnEU",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Eclipse Hub",
      Subtitle = "Key System",
      Note = "The key can be found in the Discord server.",
      FileName = "EclipseKey",
      SaveKey = true,
      GrabKeyFromUrl = false,
      Key = {"free_99"}
   }
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Char, Hum, HRP
local function refreshChar()
    Char = LP.Character or LP.CharacterAdded:Wait()
    Hum = Char:WaitForChild("Humanoid")
    HRP = Char:WaitForChild("HumanoidRootPart")
end
refreshChar()
LP.CharacterAdded:Connect(refreshChar)

-- States
local autoFarm = false
local killAura = false
local fly = false
local speedOn = false
local noclip = false
local infJump = false
local godMode = false
local espEnabled = false
local speedVal = 75
local auraRange = 16

-- ESP Folder
local espFolder = Instance.new("Folder")
espFolder.Name = "EclipseESP"
espFolder.Parent = game:GetService("CoreGui")

-- ========== TABS ==========
local HomeTab    = Window:CreateTab("Home", 4483362458)
local CombatTab  = Window:CreateTab("Combat", 4483362458)
local FarmTab    = Window:CreateTab("Farm", 4483362458)
local PlayerTab  = Window:CreateTab("Player", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

-- ========== HOME ==========
HomeTab:CreateSection("Welcome")
HomeTab:CreateParagraph({
    Title = "Eclipse Hub",
    Content = "Clean Flag Frenzy script.\nKey: free_99\nGet the key in the Discord."
})

HomeTab:CreateSection("Quick")
HomeTab:CreateButton({
    Name = "Rage Mode",
    Callback = function()
        killAura = true
        speedOn = true
        fly = true
        godMode = true
        if Hum then Hum.WalkSpeed = speedVal end
        Rayfield:Notify({Title = "Rage Mode", Content = "All power features enabled", Duration = 3})
    end,
})
HomeTab:CreateButton({
    Name = "Stop Everything",
    Callback = function()
        autoFarm = false
        killAura = false
        fly = false
        speedOn = false
        noclip = false
        infJump = false
        godMode = false
        if Hum then Hum.WalkSpeed = 16 end
        Rayfield:Notify({Title = "Stopped", Content = "All features disabled", Duration = 3})
    end,
})

-- ========== COMBAT ==========
CombatTab:CreateSection("Combat")
CombatTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(v) killAura = v end,
})
CombatTab:CreateSlider({
    Name = "Aura Range",
    Range = {8, 30},
    Increment = 1,
    CurrentValue = 16,
    Flag = "AuraRange",
    Callback = function(v) auraRange = v end,
})
CombatTab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(v) godMode = v end,
})

-- ========== FARM ==========
FarmTab:CreateSection("Flag Farm")
FarmTab:CreateToggle({
    Name = "Auto Flag Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(v) autoFarm = v end,
})
FarmTab:CreateButton({
    Name = "Teleport to Enemy Flag",
    Callback = function()
        local blue, red
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "BlueFlag" then blue = obj end
            if obj.Name == "RedFlag" then red = obj end
        end
        local myTeam = LP.Team and LP.Team.Name or ""
        local target = myTeam:lower():find("blue") and red or blue
        if target and HRP then
            local part = target:FindFirstChild("Pole") or target:FindFirstChildWhichIsA("BasePart")
            if part then
                HRP.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
            end
        end
    end,
})
FarmTab:CreateButton({
    Name = "Teleport to Base",
    Callback = function()
        local blue, red
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "BlueFlag" then blue = obj end
            if obj.Name == "RedFlag" then red = obj end
        end
        local myTeam = LP.Team and LP.Team.Name or ""
        local home = myTeam:lower():find("blue") and blue or red
        if home and HRP then
            local part = home:FindFirstChild("Pole") or home:FindFirstChildWhichIsA("BasePart")
            if part then
                HRP.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
            end
        end
    end,
})
FarmTab:CreateButton({
    Name = "Teleport to Nearest Player",
    Callback = function()
        local closest, dist = nil, 9999
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local d = (plr.Character.HumanoidRootPart.Position - HRP.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = plr.Character.HumanoidRootPart
                end
            end
        end
        if closest then
            HRP.CFrame = closest.CFrame + Vector3.new(0, 3, 0)
        end
    end,
})

-- ========== PLAYER ==========
PlayerTab:CreateSection("Movement")
PlayerTab:CreateToggle({
    Name = "Speed",
    CurrentValue = false,
    Flag = "Speed",
    Callback = function(v)
        speedOn = v
        if Hum then Hum.WalkSpeed = v and speedVal or 16 end
    end,
})
PlayerTab:CreateSlider({
    Name = "Speed Value",
    Range = {20, 140},
    Increment = 5,
    CurrentValue = 75,
    Flag = "SpeedVal",
    Callback = function(v)
        speedVal = v
        if speedOn and Hum then Hum.WalkSpeed = v end
    end,
})
PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(v) fly = v end,
})
PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(v) noclip = v end,
})
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(v) infJump = v end,
})

-- ========== VISUALS ==========
VisualsTab:CreateSection("ESP")
VisualsTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(v)
        espEnabled = v
        if not v then
            for _, child in pairs(espFolder:GetChildren()) do
                child:Destroy()
            end
        end
    end,
})

-- ========== LOGIC ==========
local function getFlags()
    local blue, red
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "BlueFlag" then blue = obj end
        if obj.Name == "RedFlag" then red = obj end
    end
    return blue, red
end

local function getFlagPos(flag)
    if not flag then return nil end
    local pole = flag:FindFirstChild("Pole") or flag:FindFirstChildWhichIsA("BasePart")
    if pole and pole:IsA("BasePart") then return pole.Position end
    if flag:IsA("Model") and flag.PrimaryPart then return flag.PrimaryPart.Position end
    for _, p in pairs(flag:GetDescendants()) do
        if p:IsA("BasePart") then return p.Position end
    end
end

-- Auto Farm
task.spawn(function()
    while true do
        task.wait(0.3)
        if autoFarm and HRP and Hum and Hum.Health > 0 then
            local blue, red = getFlags()
            local myTeam = LP.Team and LP.Team.Name or ""
            local target = myTeam:lower():find("blue") and red or blue
            local home = myTeam:lower():find("blue") and blue or red

            if LP:GetAttribute("CarryingFlag") then
                local pos = getFlagPos(home)
                if pos then
                    HRP.CFrame = CFrame.new(pos + Vector3.new(0, 4, 0))
                end
            else
                local pos = getFlagPos(target)
                if pos then
                    HRP.CFrame = CFrame.new(pos + Vector3.new(0, 4, 0))
                    for _, p in pairs(workspace:GetDescendants()) do
                        if p:IsA("ProximityPrompt") then
                            pcall(fireproximityprompt, p)
                        end
                    end
                end
            end
        end
    end
end)

-- Kill Aura
task.spawn(function()
    while true do
        task.wait(0.11)
        if killAura and HRP then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local eHRP = plr.Character:FindFirstChild("HumanoidRootPart")
                    local eHum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if eHRP and eHum and eHum.Health > 0 then
                        if (eHRP.Position - HRP.Position).Magnitude <= auraRange then
                            local ctf = ReplicatedStorage:FindFirstChild("CTF")
                            if ctf and ctf:FindFirstChild("Combat") then
                                pcall(function()
                                    ctf.Combat:FireServer("punch")
                                    ctf.Combat:FireServer("hit", plr)
                                    ctf.Combat:FireServer("laser", eHRP.Position)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ESP
task.spawn(function()
    while true do
        task.wait(0.4)
        -- clear old
        for _, child in pairs(espFolder:GetChildren()) do
            child:Destroy()
        end
        if not espEnabled then continue end

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                local bill = Instance.new("BillboardGui")
                bill.Size = UDim2.new(0, 120, 0, 30)
                bill.AlwaysOnTop = true
                bill.StudsOffset = Vector3.new(0, 3.2, 0)
                bill.Adornee = hrp
                bill.Parent = espFolder

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = plr.DisplayName
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                label.TextStrokeTransparency = 0.4
                label.Font = Enum.Font.GothamBold
                label.TextSize = 13
                label.Parent = bill
            end
        end
    end
end)

-- Movement + God
RunService.Heartbeat:Connect(function()
    if not Hum or not HRP then return end

    if speedOn then
        Hum.WalkSpeed = speedVal
    end

    if godMode then
        Hum.Health = Hum.MaxHealth
    end

    if noclip and Char then
        for _, part in pairs(Char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    if fly then
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end

        if dir.Magnitude > 0 then
            HRP.AssemblyLinearVelocity = dir.Unit * 90
        else
            HRP.AssemblyLinearVelocity = Vector3.zero
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if infJump and Hum then
        Hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

Rayfield:Notify({
    Title = "Eclipse Hub",
    Content = "Loaded successfully",
    Duration = 4
})
