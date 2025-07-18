-- Grow a Garden Admin Panel 2.0 by ChatGPT 😈

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame")
local toggle = Instance.new("TextButton")
local minimize = Instance.new("TextButton")
local commandBox = Instance.new("TextBox")

-- Panel UI setup
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0.5, -150, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Visible = true
main.Active = true
main.Draggable = true
main.Parent = ScreenGui

toggle.Size = UDim2.new(0, 40, 0, 40)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.Text = "⚙️"
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.Parent = ScreenGui

minimize.Size = UDim2.new(0, 40, 0, 25)
minimize.Position = UDim2.new(1, -45, 0, 5)
minimize.Text = "-"
minimize.TextScaled = true
minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimize.Parent = main

-- Buttons creator
local function makeButton(name, y, func)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, 0, y)
	btn.Text = name
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Parent = main
	btn.MouseButton1Click:Connect(func)
end

-- Explode function
makeButton("💣 Explode", 40, function()
	local char = game.Players.LocalPlayer.Character
	local hum = char and char:FindFirstChild("Humanoid")
	if hum then hum.Health = 0 end
end)

-- Invisibility
makeButton("👻 Invisibility", 85, function()
	local char = game.Players.LocalPlayer.Character
	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
			p.Transparency = 1
		end
	end
end)

-- Sparkle
makeButton("✨ Sparkle", 130, function()
	local char = game.Players.LocalPlayer.Character
	local spark = Instance.new("Sparkles", char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
end)

-- Fire
makeButton("🔥 Fire", 175, function()
	local char = game.Players.LocalPlayer.Character
	local f = Instance.new("Fire", char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
end)

-- Get Pet (Mooncat / Orange Tabby)
makeButton("🐾 Get Pet", 220, function()
	local petName = "Mooncat"
	local args = {
		[1] = petName
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Pets"):WaitForChild("GetPet"):FireServer(unpack(args))
end)

-- Pet Centering
makeButton("🎯 Center Pet", 265, function()
	local pet = game.Players.LocalPlayer.Character:FindFirstChild("Mooncat") or game.Players.LocalPlayer.Character:FindFirstChild("Orange Tabby")
	if pet then
		pet:MoveTo(Vector3.new(0, 1, 0)) -- Center of garden (adjust coords)
	end
end)

-- Command Box
commandBox.Size = UDim2.new(0.9, 0, 0, 35)
commandBox.Position = UDim2.new(0.05, 0, 1, -40)
commandBox.PlaceholderText = "Type :explode or :getpet Mooncat"
commandBox.Text = ""
commandBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
commandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
commandBox.Parent = main

commandBox.FocusLost:Connect(function()
	local text = commandBox.Text
	if text == ":explode" then
		local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.Health = 0 end
	elseif text:match(":getpet") then
		local pet = text:match(":getpet (.+)")
		if pet then
			game:GetService("ReplicatedStorage").Pets.GetPet:FireServer(pet)
		end
	end
	commandBox.Text = ""
end)

-- Toggle/minimize logic
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

minimize.MouseButton1Click:Connect(function()
	main.Visible = false
end)
