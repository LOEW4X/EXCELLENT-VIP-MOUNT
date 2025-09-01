--// EXCELLENT VIP SCRIPT (Mount Bohong Edition)
--// UI Library by Rayfield

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "EXCELLENT MOUNT VIP",
   LoadingTitle = "EXCELLENT VIP",
   LoadingSubtitle = "By LOEW4X",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "EXCELLENTVIP",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

---------------------------------------------------------------------
-- TELEPORT TAB
---------------------------------------------------------------------
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

local MountToggle = TeleportTab:CreateToggle({
   Name = "Mount Bohong",
   CurrentValue = false,
   Flag = "MountBohong",
   Callback = function(Value)
       getgenv().AutoMount = Value
       if Value then
           task.spawn(function()
               while getgenv().AutoMount do
                   local char = game.Players.LocalPlayer.Character
                   if char and char:FindFirstChild("HumanoidRootPart") then
                       local points = {
                           CFrame.new(918, 56, 143),
                           CFrame.new(1158, 165, -453),
                           CFrame.new(927, 274, -1016),
                           CFrame.new(590, 662, -896),
                           CFrame.new(43, 808, -1009),
                           CFrame.new(-34, 905, -1141),
                           CFrame.new(-690, 889, -1381),
                           CFrame.new(-652, 898, -1776),
                           CFrame.new(-1196, 994, -1740),
                           CFrame.new(-1335, 898, -1158),
                           CFrame.new(-975, 1309, -1469),
                       }
                       for _, point in ipairs(points) do
                           if not getgenv().AutoMount then break end
                           char:PivotTo(point)
                           task.wait(5) -- delay 5 detik antar teleport
                       end
                   end
               end
           end)
       end
   end,
})

---------------------------------------------------------------------
-- PLAYERS TAB
---------------------------------------------------------------------
local PlayersTab = Window:CreateTab("Players", 4483362458)

-- GODMODE
PlayersTab:CreateToggle({
   Name = "Godmode",
   CurrentValue = false,
   Flag = "Godmode",
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       if Value then
           getgenv().GodConn = player.CharacterAdded:Connect(function(char)
               task.wait(1)
               if char:FindFirstChild("Humanoid") then
                   char.Humanoid.Name = "GodHumanoid"
               end
           end)
           if player.Character and player.Character:FindFirstChild("Humanoid") then
               player.Character.Humanoid.Name = "GodHumanoid"
           end
       else
           if getgenv().GodConn then getgenv().GodConn:Disconnect() end
           if player.Character and player.Character:FindFirstChild("GodHumanoid") then
               player.Character.GodHumanoid.Name = "Humanoid"
           end
       end
   end,
})

-- INFINITE JUMP
PlayersTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
       getgenv().InfJump = Value
   end,
})
game:GetService("UserInputService").JumpRequest:Connect(function()
   if getgenv().InfJump and game.Players.LocalPlayer.Character then
       game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- SPEEDHACK
local speedValue = 16
PlayersTab:CreateInput({
   Name = "WalkSpeed",
   PlaceholderText = "16 - 150",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local num = tonumber(Text)
       if num and num >= 16 and num <= 150 then
           speedValue = num
       end
   end,
})
PlayersTab:CreateButton({
   Name = "Apply SpeedHack",
   Callback = function()
       local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
       if hum then
           hum.WalkSpeed = speedValue
       end
   end,
})

-- FLY (Android support)
PlayersTab:CreateButton({
   Name = "Toggle Fly",
   Callback = function()
       getgenv().flying = not getgenv().flying
       local player = game.Players.LocalPlayer
       local char = player.Character or player.CharacterAdded:Wait()
       local hum = char:WaitForChild("HumanoidRootPart")
       local UIS = game:GetService("UserInputService")
       local speed = 50
       if getgenv().flying then
           task.spawn(function()
               while getgenv().flying do
                   local move = Vector3.new()
                   if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + (workspace.CurrentCamera.CFrame.LookVector) end
                   if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - (workspace.CurrentCamera.CFrame.LookVector) end
                   if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - (workspace.CurrentCamera.CFrame.RightVector) end
                   if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + (workspace.CurrentCamera.CFrame.RightVector) end
                   hum.Velocity = move * speed
                   task.wait()
               end
               hum.Velocity = Vector3.zero
           end)
       end
   end,
})

-- FULL BRIGHT
PlayersTab:CreateToggle({
   Name = "Full Bright",
   CurrentValue = false,
   Flag = "FullBright",
   Callback = function(Value)
       if Value then
           game.Lighting.Brightness = 2
           game.Lighting.ClockTime = 14
           game.Lighting.FogEnd = 100000
       else
           game.Lighting.Brightness = 1
           game.Lighting.ClockTime = 0
           game.Lighting.FogEnd = 1000
       end
   end,
})

-- ANTI AFK
local vu = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   task.wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
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
