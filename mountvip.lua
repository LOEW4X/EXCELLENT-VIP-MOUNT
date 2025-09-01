-- Rayfield UI Loader
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Window
local Window = Rayfield:CreateWindow({
    Name = "Excellent Mount Vip",
    LoadingTitle = "EXCELLENT",
    LoadingSubtitle = "by LOEW4X",
    ConfigurationSaving = {
        Enabled = false,
    }
})

-- Tabs
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local PlayerTab = Window:CreateTab("Players", 4483362458)

-- Auto Teleport (Mount Bohong)
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
    CFrame.new(-975, 1309, -1469) -- Puncak
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
                    game.Players.LocalPlayer.Character:PivotTo(point)
                    task.wait(1)
                end
            end
        end)
    end,
})

-- Player Features
PlayerTab:CreateToggle({
    Name = "Godmode",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            local char = game.Players.LocalPlayer.Character
            if char then
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("Humanoid") then
                        v.Name = "GodHumanoid"
                        v.MaxHealth = math.huge
                        v.Health = math.huge
                    end
                end
            end
        end
    end,
})

PlayerTab:CreateInput({
    Name = "Speedhack (16–150)",
    PlaceholderText = "Enter WalkSpeed",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed and speed >= 16 and speed <= 150 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end,
})

PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        -- simple fly
        local plr = game.Players.LocalPlayer
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if Value then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                plr.Character.HumanoidRootPart.Anchored = false
                -- basic fly loop (hold space to go up, shift to go down)
                task.spawn(function()
                    while Value do
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            if game.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                hrp.CFrame = hrp.CFrame + Vector3.new(0,1,0)
                            elseif game.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                hrp.CFrame = hrp.CFrame + Vector3.new(0,-1,0)
                            end
                        end
                        task.wait()
                    end
                end)
            end
        end
    end,
})

PlayerTab:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end,
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        local plr = game.Players.LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        if Value then
            UserInputService.JumpRequest:Connect(function()
                plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        end
    end,
})

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
        else
            game:GetService("Lighting").GlobalShadows = true
        end
    end,
})

-- Bypass basic anti-teleport
task.spawn(function()
    while task.wait(2) do
        local lp = game.Players.LocalPlayer
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.Anchored = false
        end
    end
end)
