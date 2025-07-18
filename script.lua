--// Admin Panel Script
if game.CoreGui:FindFirstChild("AdminPanel") then
    game.CoreGui:FindFirstChild("AdminPanel"):Destroy()
end

local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")

-- UI Creation
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AdminPanel"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, -150, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "Admin Panel"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Minimize Button
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 40, 0, 40)
minimize.Position = UDim2.new(1, -40, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(100, 20, 20)

-- Button Container
local buttonHolder = Instance.new("Frame", frame)
buttonHolder.Position = UDim2.new(0, 0, 0, 40)
buttonHolder.Size = UDim2.new(1, 0, 1, -40)
buttonHolder.BackgroundTransparency = 1

-- Function to create buttons
local function createButton(name, callback)
    local btn = Instance.new("TextButton", buttonHolder)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, (#buttonHolder:GetChildren() - 1) * 45)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.MouseButton1Click:Connect(callback)
end

-- Example: Visual-only events
createButton("Explode Screen", function()
    local explosion = Instance.new("Explosion", workspace)
    explosion.Position = player.Character and player.Character.PrimaryPart.Position or Vector3.new(0, 10, 0)
    explosion.BlastRadius = 1
    explosion.Visible = true
end)

createButton("Flash Screen", function()
    local flash = Instance.new("Frame", gui)
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.new(1,1,1)
    flash.BackgroundTransparency = 1
    flash.ZIndex = 100
    flash:TweenTransparency(0, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
    wait(0.1)
    flash:TweenTransparency(1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    game:GetService("Debris"):AddItem(flash, 1)
end)

-- Get Pet Button (stub - will fill later)
createButton("Get Pet", function()
    warn("Get Pet clicked — function not implemented yet.")
end)

-- Minimize Logic
local isMinimized = false
minimize.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    buttonHolder.Visible = not isMinimized
    minimize.Text = isMinimized and "+" or "-"
end)
