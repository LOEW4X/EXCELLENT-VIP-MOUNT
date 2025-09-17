-- EXCELLENT VIP MOUNT

-- === ADVANCED ANTI-CHEAT DETECTOR ===
task.spawn(function()
    local suspicious = {}

    -- Lokasi umum dev taruh anti-cheat
    local checkServices = {
        game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"),
        game:GetService("ReplicatedFirst"),
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer"),
    }

    for _, container in ipairs(checkServices) do
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                local lowerName = obj.Name:lower()

                -- Deteksi dari nama
                if string.find(lowerName, "anti") or string.find(lowerName, "cheat") or string.find(lowerName, "hack") then
                    table.insert(suspicious, "[NameMatch] " .. obj:GetFullName())
                end

                -- Deteksi script yang mencoba Kick / WalkSpeed
                pcall(function()
                    local source = obj.Source
                    if source then
                        if string.find(source:lower(), "kick") then
                            table.insert(suspicious, "[KickCheck] " .. obj:GetFullName())
                        end
                        if string.find(source:lower(), "walkspeed") or string.find(source:lower(), "jumppower") then
                            table.insert(suspicious, "[SpeedCheck] " .. obj:GetFullName())
                        end
                    end
                end)
            end
        end
    end

    if #suspicious > 0 then
        if notifyBottomRight then
            notifyBottomRight("⚠️ Detected possible Anti-Cheat:\n" .. table.concat(suspicious, "\n"), 6)
        else
            warn("⚠️ Anti-Cheat scripts detected:", table.concat(suspicious, ", "))
        end
    else
        if notifyBottomRight then
            notifyBottomRight("✅ Tidak terdeteksi anti-cheat mencurigakan", 3)
        end
    end
end)

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
local UtilityTab = Window:CreateTab("Utility", 4483362458)
local PerformanceTab = Window:CreateTab("Performance", 4483362458)
local WeatherTab = Window:CreateTab("Weather", 4483362458)

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
    CFrame.new(-250, 31, 16),    -- Checkpoint 1
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
                    task.wait(2) -- delay antar titik 5 detik
                end
            end
        end)
    end,
})

-- Teleport (Mount Hilih)
local TeleportEnabled_Hilih = false
local TeleportPoints_Hilih = {
    CFrame.new(-911, 23, -722),  -- Basecamp
    CFrame.new(448, 16, -608),   -- Checkpoint 1
    CFrame.new(-209, 50, -125),  -- Checkpoint 2
    CFrame.new(-840, 36, -82),   -- Checkpoint 3
    CFrame.new(-713, 402, 394),  -- Checkpoint 4
    CFrame.new(-341, 150, 216),  -- Checkpoint 5
    CFrame.new(-371, 363, 463),  -- Checkpoint 6
    CFrame.new(-70, 337, 241),   -- Checkpoint 7
    CFrame.new(254, 529, 140)    -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Hilih",
    CurrentValue = false,
    Flag = "MountHilihTP",
    Callback = function(Value)
        TeleportEnabled_Hilih = Value
        task.spawn(function()
            while TeleportEnabled_Hilih do
                for i, point in ipairs(TeleportPoints_Hilih) do
                    if not TeleportEnabled_Hilih then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)

                    -- Delay default 5 detik antar checkpoint
                    task.wait(1)

                    -- Kalau sudah sampai Puncak (titik terakhir), tambahin delay ekstra
                    if i == #TeleportPoints_Hilih then
                        task.wait(5) -- delay tambahan khusus Puncak
                    end
                end
            end
        end)
    end,
})

-- Teleport (Mount Sakahayang)
local TeleportEnabled_Sakahayang = false
local TeleportPoints_Sakahayang = {
    CFrame.new(777, 56, 651),    -- Basecamp
    CFrame.new(650, 55, 586),    -- Checkpoint 1
    CFrame.new(-957, 3146, 529)  -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Sakahayang",
    CurrentValue = false,
    Flag = "MountSakahayangTP",
    Callback = function(Value)
        TeleportEnabled_Sakahayang = Value
        task.spawn(function()
            while TeleportEnabled_Sakahayang do
                for i, point in ipairs(TeleportPoints_Sakahayang) do
                    if not TeleportEnabled_Sakahayang then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)

                    -- Delay khusus Checkpoint 1
                    if i == 2 then
                        task.wait(3) -- beri waktu pilih mode manual
                    else
                        task.wait(1)
                    end

                    -- Auto mati saat sampai Puncak
                    if i == #TeleportPoints_Sakahayang then
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                            plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
                        end
                        task.wait(5) -- jeda biar respawn dulu
                    end
                end
            end
        end)
    end,
})


local TeleportEnabled_Galunggung = false
local TeleportPoints_Galunggung = {
    CFrame.new(-25, 6, -47),  -- Basecamp
    CFrame.new(-715, 178, 411),   -- Checkpoint 1
    CFrame.new(-928, 169, 101),  -- Checkpoint 2
    CFrame.new(-1240, 152, -56),   -- Checkpoint 3
    CFrame.new(-1355, 167, -824),  -- Checkpoint 4
    CFrame.new(-1317, 230, -994),  -- Checkpoint 5
    CFrame.new(-1360, 375, -1492),  -- Checkpoint 6
    CFrame.new(-1323, 259, -2256),   -- Checkpoint 7
    CFrame.new(-1240, 225, -2650),   -- Checkpoint 8
    CFrame.new(-1242, 471, -3389)    -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Galunggung",
    CurrentValue = false,
    Flag = "MountGalunggungTP",
    Callback = function(Value)
        TeleportEnabled_Galunggung = Value
        task.spawn(function()
            while TeleportEnabled_Galunggung do
                for i, point in ipairs(TeleportPoints_Galunggung) do
                    if not TeleportEnabled_Galunggung then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)

                    -- Delay default 5 detik antar checkpoint
                    task.wait(1)

                    -- Kalau sudah sampai Puncak (titik terakhir), tambahin delay ekstra
                    if i == #TeleportPoints_Galunggung then
                        task.wait(2) -- delay tambahan khusus Puncak
                    end
                end
            end
        end)
    end,
})

-- Teleport (Mount Atin)
local TeleportEnabled_Atin = false
local TeleportPoints_Atin = {
    CFrame.new(16, 57, -1083),    -- Basecamp
    CFrame.new(624, 1801, 3432),    -- Checkpoint 1
    CFrame.new(791, 2176, 3940)  -- Puncak
}

TeleportTab:CreateToggle({
    Name = "Mount Atin",
    CurrentValue = false,
    Flag = "MountAtinTP",
    Callback = function(Value)
        TeleportEnabled_Atin = Value
        task.spawn(function()
            while TeleportEnabled_Atin do
                for i, point in ipairs(TeleportPoints_Atin) do
                    if not TeleportEnabled_Atin then break end
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character then
                            plr.Character:PivotTo(point)
                        end
                    end)

                    task.wait(1)

                    -- Auto mati saat sampai Puncak
                    if i == #TeleportPoints_Atin then
                        local plr = game.Players.LocalPlayer
                        if plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                            plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
                        end
                        task.wait(5) -- jeda biar respawn dulu
                    end
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

local NormalLighting = {
    Brightness = game.Lighting.Brightness,
    ClockTime = game.Lighting.ClockTime,
    FogEnd = game.Lighting.FogEnd,
    Ambient = game.Lighting.Ambient,
    OutdoorAmbient = game.Lighting.OutdoorAmbient,
    GlobalShadows = game.Lighting.GlobalShadows
}

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Lighting = game:GetService("Lighting")

local STATE = {
    Godmode = false,
    GodConnection = nil,
    InfiniteJump = false,
    Fly = false,
    NormalWalkSpeed = 16,
    SpeedDesired = nil,
    SpeedApplied = false,
    HideNick = false,
    OriginalNick = nil,
    currentRain = nil
}

-- State & penyimpanan nilai asli agar bisa di-restore
local PerfState = {
    BoosterOn = false,
    FpsCap = nil,
    saved = {
        lighting = nil,           -- tabel
        postEffects = {},         -- {inst=postEffectInstance, enabled=bool}
        terrain = nil,            -- tabel
        particles = {},           -- {inst=emitter/trail/smoke/fire, enabled/rate}
        meshFidelity = {},        -- {inst=MeshPart, rf=Enum.RenderFidelity}
    }
}

-- Simpan kondisi default lighting
local DefaultLighting = {
    ClockTime = Lighting.ClockTime,
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
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

-- apply speedhack
local function applySpeed()
    if not STATE.SpeedDesired then
        notifyBottomRight("Masukkan nilai WalkSpeed sebelum apply", 3)
        return
    end

    STATE.SpeedApplied = true

    local plr = Players.LocalPlayer
    local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

    -- simpan WalkSpeed asli (sekali saja, biar bisa direset)
    if humanoid and not STATE.NormalWalkSpeed then
        STATE.NormalWalkSpeed = humanoid.WalkSpeed
    end

    -- disconnect Heartbeat lama kalau ada
    if enforcedSpeedConn then enforcedSpeedConn:Disconnect() enforcedSpeedConn = nil end

    -- enforce setiap frame
    enforcedSpeedConn = RunService.Heartbeat:Connect(function()
        local plr = Players.LocalPlayer
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if hum and STATE.SpeedApplied then
            hum.WalkSpeed = STATE.SpeedDesired
        end
    end)

    connections._speedEnf = enforcedSpeedConn
    notifyBottomRight("WalkSpeed On: " .. tostring(STATE.SpeedDesired), 2)
end

-- Perbaikan removeSpeedEnforce
local function removeSpeedEnforce()
    local plr = game.Players.LocalPlayer
    local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

    STATE.SpeedApplied = false

    -- disconnect semua koneksi lama
    if enforcedSpeedConn then enforcedSpeedConn:Disconnect() enforcedSpeedConn = nil end
    if connections._speedEnf then connections._speedEnf:Disconnect() connections._speedEnf = nil end

    -- reset ke normal WalkSpeed
    if humanoid then
        humanoid.WalkSpeed = STATE.NormalWalkSpeed or 16
    end

    notifyBottomRight("WalkSpeed Off", 2)
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

local function captureLighting()
    return {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        GlobalShadows = Lighting.GlobalShadows,
        ShadowSoftness = (pcall(function() return Lighting.ShadowSoftness end) and Lighting.ShadowSoftness) or nil,
        EnvironmentDiffuseScale = (pcall(function() return Lighting.EnvironmentDiffuseScale end) and Lighting.EnvironmentDiffuseScale) or nil,
        EnvironmentSpecularScale = (pcall(function() return Lighting.EnvironmentSpecularScale end) and Lighting.EnvironmentSpecularScale) or nil,
        ExposureCompensation = (pcall(function() return Lighting.ExposureCompensation end) and Lighting.ExposureCompensation) or nil,
    }
end

local function restoreLighting(saved)
    if not saved then return end
    Lighting.Brightness = saved.Brightness
    Lighting.ClockTime = saved.ClockTime
    Lighting.FogEnd = saved.FogEnd
    Lighting.Ambient = saved.Ambient
    Lighting.OutdoorAmbient = saved.OutdoorAmbient
    Lighting.GlobalShadows = saved.GlobalShadows
    if saved.ShadowSoftness ~= nil then Lighting.ShadowSoftness = saved.ShadowSoftness end
    if saved.EnvironmentDiffuseScale ~= nil then Lighting.EnvironmentDiffuseScale = saved.EnvironmentDiffuseScale end
    if saved.EnvironmentSpecularScale ~= nil then Lighting.EnvironmentSpecularScale = saved.EnvironmentSpecularScale end
    if saved.ExposureCompensation ~= nil then Lighting.ExposureCompensation = saved.ExposureCompensation end
end

local function captureTerrain()
    if not Terrain then return nil end
    return {
        Decoration = Terrain.Decoration,
        WaterWaveSize = Terrain.WaterWaveSize,
        WaterWaveSpeed = Terrain.WaterWaveSpeed,
        WaterReflectance = Terrain.WaterReflectance,
        WaterTransparency = Terrain.WaterTransparency,
    }
end

local function restoreTerrain(saved)
    if not Terrain or not saved then return end
    Terrain.Decoration = saved.Decoration
    Terrain.WaterWaveSize = saved.WaterWaveSize
    Terrain.WaterWaveSpeed = saved.WaterWaveSpeed
    Terrain.WaterReflectance = saved.WaterReflectance
    Terrain.WaterTransparency = saved.WaterTransparency
end

local function disablePostEffects()
    -- Matikan Bloom, SunRays, DOF, ColorCorrection, dll
    local classes = {
        "BloomEffect","ColorCorrectionEffect","DepthOfFieldEffect",
        "SunRaysEffect","BlurEffect","Atmosphere"
    }
    for _, inst in ipairs(Lighting:GetChildren()) do
        for _, cn in ipairs(classes) do
            if inst:IsA(cn) then
                table.insert(PerfState.saved.postEffects, {inst = inst, enabled = inst.Enabled ~= nil and inst.Enabled or true})
                if inst.Enabled ~= nil then inst.Enabled = false end
                if inst:IsA("Atmosphere") then
                    -- Atmosphere nggak punya Enabled; bisa dikurangi intensitasnya
                    pcall(function()
                        inst.Density = 0
                        inst.Offset = 0
                        inst.Glare = 0
                        inst.Haze = 0
                    end)
                end
            end
        end
    end
end

local function restorePostEffects()
    for _, info in ipairs(PerfState.saved.postEffects) do
        if info.inst and info.inst.Parent then
            if info.inst.Enabled ~= nil then
                info.inst.Enabled = info.enabled
            end
        end
    end
    PerfState.saved.postEffects = {}
end

local function downscaleTerrain()
    if not Terrain then return end
    Terrain.Decoration = false
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

local function calmParticlesAndTrails()
    -- Matikan emitter, trail, smoke, fire
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("ParticleEmitter") then
            table.insert(PerfState.saved.particles, {inst=d, enabled=d.Enabled, rate=d.Rate})
            d.Enabled = false
            d.Rate = 0
        elseif d:IsA("Trail") then
            table.insert(PerfState.saved.particles, {inst=d, enabled=d.Enabled})
            d.Enabled = false
        elseif d:IsA("Smoke") or d:IsA("Fire") then
            table.insert(PerfState.saved.particles, {inst=d, enabled=d.Enabled})
            d.Enabled = false
        elseif d:IsA("MeshPart") then
            -- Turunkan kualitas render fidelity
            table.insert(PerfState.saved.meshFidelity, {inst=d, rf=d.RenderFidelity})
            d.RenderFidelity = Enum.RenderFidelity.Performance
        end
    end
end

local function restoreParticlesAndTrails()
    for _, info in ipairs(PerfState.saved.particles) do
        local inst = info.inst
        if inst and inst.Parent then
            if inst:IsA("ParticleEmitter") then
                inst.Enabled = info.enabled
                if info.rate ~= nil then inst.Rate = info.rate end
            elseif inst:IsA("Trail") or inst:IsA("Smoke") or inst:IsA("Fire") then
                inst.Enabled = info.enabled
            end
        end
    end
    PerfState.saved.particles = {}

    for _, info in ipairs(PerfState.saved.meshFidelity) do
        local inst = info.inst
        if inst and inst.Parent then
            pcall(function() inst.RenderFidelity = info.rf end)
        end
    end
    PerfState.saved.meshFidelity = {}
end

local function applyFPSBooster()
    if PerfState.BoosterOn then return end
    PerfState.BoosterOn = true

    -- simpan kondisi awal
    if not PerfState.saved.lighting then PerfState.saved.lighting = captureLighting() end
    if not PerfState.saved.terrain then PerfState.saved.terrain = captureTerrain() end

    -- lighting “murah”
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.FogEnd = 800
    pcall(function()
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ExposureCompensation = 0
        if Lighting.ShadowSoftness then Lighting.ShadowSoftness = 0 end
    end)

    -- matikan efek, sederhana teren
    disablePostEffects()
    downscaleTerrain()
    calmParticlesAndTrails()

    notifyBottomRight("FPS Booster aktif", 2)
end

local function removeFPSBooster()
    if not PerfState.BoosterOn then return end
    PerfState.BoosterOn = false

    -- kembalikan semua setting
    restorePostEffects()
    restoreParticlesAndTrails()
    restoreTerrain(PerfState.saved.terrain)
    restoreLighting(PerfState.saved.lighting)

    notifyBottomRight("FPS Booster dinonaktifkan", 2)
end

-- Fungsi set weather
local function setWeather(mode)
    -- hapus hujan lama
    if currentRain then
        currentRain:Destroy()
        currentRain = nil
    end

    if mode == "Pagi" then
        Lighting.ClockTime = 6
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)

    elseif mode == "Senja" then
        Lighting.ClockTime = 18
        Lighting.Brightness = 1.5
        Lighting.Ambient = Color3.fromRGB(255, 170, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 170, 127)

    elseif mode == "Malam" then
        Lighting.ClockTime = 0
        Lighting.Brightness = 0.5
        Lighting.Ambient = Color3.fromRGB(80, 80, 120)
        Lighting.OutdoorAmbient = Color3.fromRGB(80, 80, 120)

    elseif mode == "Hujan" then
        Lighting.ClockTime = 14
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(100, 100, 100)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)

        -- efek hujan
        local rain = Instance.new("ParticleEmitter")
        rain.Rate = 500
        rain.Lifetime = NumberRange.new(2, 3)
        rain.Speed = NumberRange.new(20, 30)
        rain.Size = NumberSequence.new(0.2)
        rain.Texture = "http://www.roblox.com/asset/?id=48340627"
        rain.Parent = workspace.CurrentCamera
        currentRain = rain
    end
end  -- <<< ini yang kurang

-- Fungsi restore default bawaan server
local function restoreDefaultWeather()
    if currentRain then
        currentRain:Destroy()
        currentRain = nil
    end
    Lighting.ClockTime = DefaultLighting.ClockTime
    Lighting.Brightness = DefaultLighting.Brightness
    Lighting.Ambient = DefaultLighting.Ambient
    Lighting.OutdoorAmbient = DefaultLighting.OutdoorAmbient
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

--apply speedhack
PlayerTab:CreateInput({
    Name = "WalkSpeed (16–200)",
    PlaceholderText = "Enter WalkSpeed",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed and speed >= 16 and speed <= 200 then
            STATE.SpeedDesired = speed
            notifyBottomRight("Speed yang dipilih: " .. tostring(speed), 2)
        else
            notifyBottomRight("Masukkan nilai antara 16 sampai 200", 3)
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Apply WalkSpeed",
    Callback = function()
        if STATE.SpeedApplied then
            removeSpeedEnforce()
        else
            applySpeed()
        end
    end,
})

-- Fly Toggle
UtilityTab:CreateToggle({
    Name = "Fly (PC ONLY)",
    CurrentValue = false,
    Callback = function(Value)
        setFly(Value)
    end,
})

-- Infinite Jump Toggle (persistent)
UtilityTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        setInfiniteJump(Value)
    end,
})

--full bright
UtilityTab:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            -- Aktifkan Full Bright
            game.Lighting.Brightness = 2
            game.Lighting.ClockTime = 12
            game.Lighting.FogEnd = 1e10
            game.Lighting.Ambient = Color3.new(1,1,1)
            game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
            game.Lighting.GlobalShadows = false
        else
            -- Balikin ke kondisi asli
            game.Lighting.Brightness = NormalLighting.Brightness
            game.Lighting.ClockTime = NormalLighting.ClockTime
            game.Lighting.FogEnd = NormalLighting.FogEnd
            game.Lighting.Ambient = NormalLighting.Ambient
            game.Lighting.OutdoorAmbient = NormalLighting.OutdoorAmbient
            game.Lighting.GlobalShadows = NormalLighting.GlobalShadows
        end
    end,
})

-- Hide Nickname Toggle
PlayerTab:CreateToggle({
    Name = "Hide Nickname (Bug)",
    CurrentValue = false,
    Callback = function(Value)
        setHideNickname(Value)
    end,
})

-- X-Ray Feature
local XRAY_TRANSPARENCY = 0.5
local XRAY_ENABLED = false

UtilityTab:CreateToggle({
    Name = "X-Ray",
    CurrentValue = false,
    Callback = function(Value)
        XRAY_ENABLED = Value
        if XRAY_ENABLED then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    obj.LocalTransparencyModifier = XRAY_TRANSPARENCY
                end
            end
            if notifyBottomRight then notifyBottomRight("X-Ray aktif", 2) end
        else
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    obj.LocalTransparencyModifier = 0
                end
            end
            if notifyBottomRight then notifyBottomRight("X-Ray non-aktif", 2) end
        end
    end,
})

UtilityTab:CreateSlider({
    Name = "X-Ray Transparency",
    Range = {0.1, 1}, -- 0.1 = nyaris solid, 1 = full hilang
    Increment = 0.1,
    CurrentValue = XRAY_TRANSPARENCY,
    Callback = function(Value)
        XRAY_TRANSPARENCY = Value
        if XRAY_ENABLED then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation")) 
                   and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    obj.LocalTransparencyModifier = XRAY_TRANSPARENCY
                end
            end
        end
    end,
})

-- === AUTO JUMP / BUNNY HOP ===
local autoJumpConn = nil
local AUTO_JUMP = false

UtilityTab:CreateToggle({
    Name = "Auto Jump (Bunny Hop)",
    CurrentValue = false,
    Callback = function(Value)
        AUTO_JUMP = Value
        if AUTO_JUMP then
            if autoJumpConn then autoJumpConn:Disconnect() end
            autoJumpConn = game:GetService("RunService").Heartbeat:Connect(function()
                local lp = game.Players.LocalPlayer
                if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
                    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        -- kalau sudah nyentuh tanah → langsung lompat lagi
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            if notifyBottomRight then notifyBottomRight("Auto Jump aktif (Bunny Hop)", 2) end
        else
            if autoJumpConn then autoJumpConn:Disconnect() autoJumpConn = nil end
            if notifyBottomRight then notifyBottomRight("Auto Jump non-aktif", 2) end
        end
    end,
})

-- === FOV SLIDER ===
local cam = workspace.CurrentCamera
local defaultFOV = cam.FieldOfView

UtilityTab:CreateInput({
    Name = "Camera FOV",
    PlaceholderText = "Masukkan angka 50-120",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local num = tonumber(Text)
        if num and num >= 50 and num <= 120 then
            workspace.CurrentCamera.FieldOfView = num
            if notifyBottomRight then notifyBottomRight("FOV diset ke " .. num, 2) end
        else
            if notifyBottomRight then notifyBottomRight("Masukkan angka 50–120", 3) end
        end
    end,
})

-- === REJOIN BUTTON ===
PlayerTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer
        TeleportService:Teleport(game.PlaceId, lp)
    end,
})

-- === TELEPORT TO PLAYER ===
local targetName = nil

PlayerTab:CreateInput({
    Name = "Nama Player",
    PlaceholderText = "Ketik nama pemain",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        targetName = Text
        notifyBottomRight("Target player: " .. tostring(Text), 2)
    end,
})

PlayerTab:CreateButton({
    Name = "Teleport ke Player",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetName or "")
        if lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character:PivotTo(target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,2))
            notifyBottomRight("Teleport ke " .. target.Name, 2)
        else
            notifyBottomRight("Player tidak ditemukan atau belum spawn", 3)
        end
    end,
})

-- Toggle utama FPS Booster
PerformanceTab:CreateToggle({
    Name = "FPS Booster",
    CurrentValue = false,
    Flag = "FPSBooster",
    Callback = function(Value)
        if Value then
            applyFPSBooster()
        else
            removeFPSBooster()
        end
    end,
})

-- FPS Cap (butuh executor yang support setfpscap)
PerformanceTab:CreateDropdown({
    Name = "FPS Cap",
    Options = {"30","60","120","240","Unlimited"},
    CurrentOption = "60",
    Callback = function(opt)
        local cap = nil
        if opt == "Unlimited" then
            cap = 1000
        else
            cap = tonumber(opt)
        end
        PerfState.FpsCap = cap
        local ok, err = pcall(function()
            if setfpscap then setfpscap(cap) end
        end)
        if ok and setfpscap then
            notifyBottomRight("FPS cap di-set ke "..tostring(cap), 2)
        else
            notifyBottomRight("Executor tidak mendukung setfpscap", 3)
        end
    end,
})

-- Tombol bersih-bersih effect sekali jalan (opsional)
PerformanceTab:CreateButton({
    Name = "Clear Particles/Trails (Sekali)",
    Callback = function()
        calmParticlesAndTrails()
        notifyBottomRight("Particles/Trails dimatikan (sekali). Gunakan toggle untuk restore.", 3)
    end,
})

WeatherTab:CreateButton({
    Name = "Pagi",
    Callback = function()
        setWeather("Morning")
    end,
})

WeatherTab:CreateButton({
    Name = "Matahari Terbenam",
    Callback = function()
        setWeather("Sunset")
    end,
})

WeatherTab:CreateButton({
    Name = "Malam",
    Callback = function()
        setWeather("Night")
    end,
})

WeatherTab:CreateButton({
    Name = "Hujan",
    Callback = function()
        setWeather("Rain")
    end,
})

WeatherTab:CreateButton({
    Name = "Kembalikan Default",
    Callback = function()
        setWeather("Default")
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
