-- EXCELLENT VIP MOUNT

-- Rayfield UI Loader
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Window
local Window = Rayfield:CreateWindow({
    Name = "EXCELLENT VIP MOUNT",
    LoadingTitle = "EXCELLENT VIP",
    LoadingSubtitle = "by LOEW4X",
    ConfigurationSaving = { Enabled = false }
})

-- Tabs
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local PlayerTab = Window:CreateTab("Players", 4483362458)

-- Notification helper (bottom-right)
local function notifyBottomRight(text, duration)
    duration = duration or 3
    local player = game.Players.LocalPlayer
    if not player or not player:FindFirstChild("PlayerGui") then return end
    local pg = player:FindFirstChild("PlayerGui")

    -- create ScreenGui container
    local sg = Instance.new("ScreenGui")
    sg.Name = "EXCELLENTNotify"
    sg.ResetOnSpawn = false
    sg.Parent = pg

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0,250,0,40)
    label.Position = UDim2.new(1,-260,1,-60)
    label.AnchorPoint = Vector2.new(0,0)
    label.BackgroundTransparency = 0.25
    label.BackgroundColor3 = Color3.fromRGB(25,25,25)
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Text = text
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.BorderSizePixel = 0
    label.Parent = sg

    spawn(function()
        task.wait(duration)
        pcall(function() sg:Destroy() end)
    end)
end

-- Teleport (Mount Bohong)
local TeleportEnabled = false
local TeleportPoints = {
    CFrame.new(918, 56, 143),   -- Basecamp
    CFrame.new(1158, 165, -453),
    CFrame.new(927, 274, -1016),
    CFrame.new(590, 662, -896),
    CFrame.new(43, 808, -1009),
    CFrame.new(-34, 905, -1141),
    CFrame.new(-690, 889, -1381),
    CFrame.new(-652, 898, -1776),
    CFrame.new(-1196, 994, -1740),
    CFrame.new(-1335, 898, -1158),
    CFrame.new(-974, 1306, -1474) -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Bohong",
    CurrentValue = false,
    Flag = "MountBohongTP",
    Callback = function(Value)
        TeleportEnabled = Value
        task.spawn(function()
            while TeleportEnabled do
                for _, point in ipairs(TeleportPoints) do
                    if not TeleportEnabled then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)
                    task.wait(1)
                end
            end
        end)
    end,
})

-- =========================
-- Teleport Mount Lawak (Auto)
local LawakEnabled = false
local LawakPoints = {
    CFrame.new(-204, 35, -279),   -- Basecamp
    CFrame.new(-250, 31, -16),    -- Checkpoint 1
    CFrame.new(-194, 178, 245),   -- Checkpoint 2
    CFrame.new(283, 322, -191),   -- Checkpoint 3
    CFrame.new(324, 404, 132),    -- Checkpoint 4
    CFrame.new(451, 391, -72),    -- Checkpoint 5
    CFrame.new(530, 569, -313),   -- Checkpoint 6
    CFrame.new(1441, 1128, -1300),-- Checkpoint 7
    CFrame.new(1794, 1478, -1963),-- Checkpoint 8
    CFrame.new(2832, 2623, -1849) -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Lawak",
    CurrentValue = false,
    Flag = "MountLawakTP",
    Callback = function(Value)
        LawakEnabled = Value
        task.spawn(function()
            while LawakEnabled do
                for _, point in ipairs(LawakPoints) do
                    if not LawakEnabled then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)
                    task.wait(1) -- delay antar titik 5 detik
                end
            end
        end)
    end,
})

-- Player features state & helpers
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

local STATE = {
    Godmode = false,
    GodConnection = nil,
    InfiniteJump = false,
    Fly = false,
    SpeedDesired = nil,
    SpeedApplied = false,
    HideNick = false,
    OriginalNick = nil
}

-- store connections so toggles stay persistent
local connections = {}
local function disconnectAll(tbl)
    for i, con in pairs(tbl) do
        pcall(function() con:Disconnect() end)
        tbl[i] = nil
    end
end

local NamaDepan = {"Andi","Budi","Rizky","Dewi","Siti","Putra","Fajar","Dian","Agus","Citra"}
local NamaBelakang = {"Saputra","Santoso","Pratama","Wibowo","Kurniawan","Wijaya","Hidayat","Puspita","Utami","Anggraini"}

local function generateNama()
    local depan = NamaDepan[math.random(1,#NamaDepan)]
    local belakang = NamaBelakang[math.random(1,#NamaBelakang)]
    return depan.." "..belakang
end

local function setNickname(name)
    local lp = Players.LocalPlayer
    if lp then
        pcall(function() lp.DisplayName = name end) -- ganti DisplayName (yang kelihatan di game)
    end
end

-- Helper to apply godmode to a character
local function enforceGodmode(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum.Name = "GodHumanoid"
            hum.MaxHealth = math.huge
            hum.Health = math.huge
            -- override HealthChanged to keep it high
            if not hum:FindFirstChild("_GodHealConn") then
                local c = hum.HealthChanged:Connect(function()
                    if STATE.Godmode then
                        hum.Health = math.huge
                    end
                end)
                -- store connection as value in table to disconnect later
                connections[#connections+1] = c
            end
        end)
    end
end

-- Apply/Remove Godmode (persistent across respawn)
local function setGodmode(on)
    STATE.Godmode = on
    -- apply to current character
    local lp = Players.LocalPlayer
    if lp and lp.Character then
        enforceGodmode(lp.Character)
    end
    -- ensure it persists on CharacterAdded
    if on then
        -- avoid duplicate connection
        if not connections._godCharAdded then
            connections._godCharAdded = Players.LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.1)
                enforceGodmode(char)
            end)
        end
        notifyBottomRight("Godmode aktif", 2)
    else
        -- turn off: disconnect CharacterAdded connection and other stored hum connections
        if connections._godCharAdded then
            connections._godCharAdded:Disconnect()
            connections._godCharAdded = nil
        end
        -- we won't be able to set humanoid back to normal reliably so just notify
        notifyBottomRight("Godmode non-aktif", 2)
    end
end

-- Infinite jump implementation that persists
local jumpConn = nil
local function setInfiniteJump(on)
    STATE.InfiniteJump = on
    if on then
        if jumpConn then jumpConn:Disconnect() end
        jumpConn = UserInputService.JumpRequest:Connect(function()
            local plr = Players.LocalPlayer
            local hum = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        connections._infiniteJump = jumpConn
        -- persist on respawn
        if not connections._jumpCharAdded then
            connections._jumpCharAdded = Players.LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.1)
                -- no action needed; JumpRequest will work for new humanoid
            end)
        end
        notifyBottomRight("Infinite Jump aktif", 2)
    else
        if jumpConn then jumpConn:Disconnect() jumpConn = nil end
        if connections._jumpCharAdded then connections._jumpCharAdded:Disconnect() connections._jumpCharAdded = nil end
        notifyBottomRight("Infinite Jump non-aktif", 2)
    end
end

-- Speedhack: input -> set desired value, Apply button enforces it until turned off
local enforcedSpeedConn = nil
local function applySpeed()
    if not STATE.SpeedDesired then
        notifyBottomRight("Masukkan nilai WalkSpeed sebelum apply", 3)
        return
    end
    STATE.SpeedApplied = true
    -- disconnect old
    if enforcedSpeedConn then enforcedSpeedConn:Disconnect() enforcedSpeedConn = nil end
    -- enforce every frame (more robust than single set)
    enforcedSpeedConn = RunService.Heartbeat:Connect(function()
        local plr = Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            pcall(function()
                plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = STATE.SpeedDesired
            end)
        end
    end)
    connections._speedEnf = enforcedSpeedConn
    notifyBottomRight("Speedhack diterapkan: " .. tostring(STATE.SpeedDesired), 2)
end

local function removeSpeedEnforce()
    STATE.SpeedApplied = false
    if enforcedSpeedConn then enforcedSpeedConn:Disconnect() enforcedSpeedConn = nil end
    if connections._speedEnf then connections._speedEnf:Disconnect() connections._speedEnf = nil end
    notifyBottomRight("Speedhack dilepas", 2)
end

-- Fly: improved and Android-compatible (on-screen buttons)
local flyLoopConn = nil
local flyGui = nil
local function createFlyGui()
    -- only create once
    if flyGui and flyGui.Parent then return end
    local lp = Players.LocalPlayer
    if not lp or not lp:FindFirstChild("PlayerGui") then return end
    local pg = lp.PlayerGui
    flyGui = Instance.new("ScreenGui")
    flyGui.Name = "EXCELLENTFlyGUI"
    flyGui.ResetOnSpawn = false
    flyGui.Parent = pg

    -- up button
    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0,60,0,60)
    upBtn.Position = UDim2.new(1,-80,1,-140)
    upBtn.AnchorPoint = Vector2.new(0,0)
    upBtn.Text = "Up"
    upBtn.BackgroundTransparency = 0.4
    upBtn.Parent = flyGui

    -- down button
    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0,60,0,60)
    downBtn.Position = UDim2.new(1,-80,1,-70)
    downBtn.AnchorPoint = Vector2.new(0,0)
    downBtn.Text = "Down"
    downBtn.BackgroundTransparency = 0.4
    downBtn.Parent = flyGui

    -- hold flags
    local holdingUp = false
    local holdingDown = false

    upBtn.MouseButton1Down:Connect(function() holdingUp = true end)
    upBtn.MouseButton1Up:Connect(function() holdingUp = false end)
    downBtn.MouseButton1Down:Connect(function() holdingDown = true end)
    downBtn.MouseButton1Up:Connect(function() holdingDown = false end)

    -- return state accessor
    return function()
        return holdingUp, holdingDown
    end
end

local function destroyFlyGui()
    if flyGui then pcall(function() flyGui:Destroy() end) flyGui = nil end
end

local function setFly(on)
    STATE.Fly = on
    if on then
        -- prepare GUI for touch devices
        local touchMode = UserInputService.TouchEnabled
        local getHolding = nil
        if touchMode then
            getHolding = createFlyGui()
        end

        -- avoid duplicate loop
        if flyLoopConn then flyLoopConn:Disconnect() flyLoopConn = nil end
        flyLoopConn = RunService.Heartbeat:Connect(function()
            local plr = Players.LocalPlayer
            if not plr or not plr.Character then return end
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            -- put humanoid into physics/flying state
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)

            -- movement speed multipliers
            local moveVec = Vector3.new(0,0,0)
            -- keyboard controls
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec = moveVec + Vector3.new(0,-1,0) end

            -- touch controls (from GUI)
            if getHolding then
                local up, down = getHolding()
                if up then moveVec = moveVec + Vector3.new(0,1,0) end
                if down then moveVec = moveVec + Vector3.new(0,-1,0) end
            end

            -- also allow directional movement while flying
            local cam = workspace.CurrentCamera
            if cam then
                local look = cam.CFrame.LookVector
                -- forward/back using W/S
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + look end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - look end
                -- left/right using A/D
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + cam.CFrame.RightVector end
            end

            if moveVec.Magnitude > 0 then
                local newC = hrp.CFrame + moveVec.Unit * 6 * RunService.RenderStepped:Wait()
                hrp.CFrame = hrp.CFrame:Lerp(newC, 0.6)
            end
        end)

        notifyBottomRight("Fly aktif", 2)
    else
        if flyLoopConn then flyLoopConn:Disconnect() flyLoopConn = nil end
        destroyFlyGui()
        notifyBottomRight("Fly non-aktif", 2)
    end
end

local function setHideNickname(on)
    if on then
        if not HideNick then
            OriginalNick = Players.LocalPlayer.DisplayName
            local newName = generateNama()
            setNickname(newName)
            notifyBottomRight("Hide Nickname aktif → "..newName, 3)
            HideNick = true
        end
    else
        if HideNick and OriginalNick then
            setNickname(OriginalNick)
            notifyBottomRight("Hide Nickname non-aktif → "..OriginalNick, 3)
            HideNick = false
        end
    end
end

-- Anti-AFK (unchanged)
PlayerTab:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        notifyBottomRight("Anti AFK aktif", 2)
    end,
})

-- Godmode toggle (persistent)
PlayerTab:CreateToggle({
    Name = "Godmode",
    CurrentValue = false,
    Callback = function(Value)
        setGodmode(Value)
    end,
})

-- Speedhack input + Apply button
PlayerTab:CreateInput({
    Name = "Speedhack (16–150)",
    PlaceholderText = "Enter WalkSpeed",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed and speed >= 16 and speed <= 150 then
            STATE.SpeedDesired = speed
            notifyBottomRight("Speed yang dipilih: " .. tostring(speed), 2)
        else
            notifyBottomRight("Masukkan nilai antara 16 sampai 150", 3)
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Apply Speedhack",
    Callback = function()
        if STATE.SpeedApplied then
            removeSpeedEnforce()
        else
            applySpeed()
        end
    end,
})

-- Fly Toggle
PlayerTab:CreateToggle({
    Name = "Fly (PC ONLY)",
    CurrentValue = false,
    Callback = function(Value)
        setFly(Value)
    end,
})

-- Infinite Jump Toggle (persistent)
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        setInfiniteJump(Value)
    end,
})

-- Full Bright Toggle (keeps previous minimal revert behavior)
PlayerTab:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 12
            game:GetService("Lighting").FogEnd = 1e10
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.new(1,1,1)
            notifyBottomRight("Full Bright aktif", 2)
        else
            game:GetService("Lighting").GlobalShadows = true
            notifyBottomRight("Full Bright non-aktif", 2)
        end
    end,
})

-- Hide Nickname Toggle
PlayerTab:CreateToggle({
    Name = "Hide Nickname",
    CurrentValue = false,
    Callback = function(Value)
        setHideNickname(Value)
    end,
})

-- Bypass basic anti-teleport (keep HumanoidRootPart unanchored)
task.spawn(function()
    while task.wait(2) do
        local lp = game.Players.LocalPlayer
        if lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

-- Cleanup on script unload / disconnect
Players.LocalPlayer.AncestryChanged:Connect(function()
    -- attempt to disconnect everything when player leaves or gui removed
    disconnectAll(connections)
    if flyLoopConn then flyLoopConn:Disconnect() flyLoopConn = nil end
    if jumpConn then jumpConn:Disconnect() jumpConn = nil end
    if enforcedSpeedConn then enforcedSpeedConn:Disconnect() enforcedSpeedConn = nil end
end)

local function setGodmode(on)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if humanoid then
        if on then
            if not Godmode then
                Godmode = true
                GodConnection = humanoid.HealthChanged:Connect(function()
                    if humanoid and humanoid.Health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
                notifyBottomRight("Godmode aktif", 3)
            end
        else
            if Godmode then
                Godmode = false
                if GodConnection then
                    GodConnection:Disconnect()
                    GodConnection = nil
                end
                notifyBottomRight("Godmode non-aktif", 3)
            end
        end
    end
end

-- Initial notification
notifyBottomRight("EXCELLENT VIP loaded", 4)
