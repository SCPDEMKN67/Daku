-- Admin Panel Script for Grow a Garden (Delta Executor Compatible)
-- GitHub Version - by Akash ⚡

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Setup GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Icon Button
local mainIcon = Instance.new("ImageButton")
mainIcon.Size = UDim2.new(0, 40, 0, 40)
mainIcon.Position = UDim2.new(0, 20, 0, 150)
mainIcon.Image = "rbxassetid://3926305904"
mainIcon.ImageRectOffset = Vector2.new(924, 724)
mainIcon.ImageRectSize = Vector2.new(36, 36)
mainIcon.BackgroundTransparency = 1
mainIcon.Parent = ScreenGui

-- Main Panel
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 80, 0, 150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = ScreenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Size = UDim2.new(0, 60, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
Instance.new("UICorner", minimizeBtn)

-- Show/Hide Logic
mainIcon.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
end)

minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Reusable Button Creator
local function createButton(text, posY, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, 260, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, posY)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn)
	btn.MouseButton1Click:Connect(callback)
end

-- Center Pet Function
local function centerPet()
	local char = LocalPlayer.Character
	if not char then return end
	for _, pet in pairs(workspace:GetDescendants()) do
		if pet:IsA("Model") and pet:FindFirstChild("Owner") and pet.Owner.Value == LocalPlayer then
			if pet.Name == "Orange Tabby" or pet.Name == "Mooncat" then
				pet:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame)
				break
			end
		end
	end
end

-- Get Pet
local function getPet(petName)
	local event = ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("SpawnPet")
	if event then
		event:FireServer(petName)
	end
end

-- Admin Aura (Local Only)
local function showAura()
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local aura = Instance.new("ParticleEmitter", hrp)
	aura.Texture = "rbxassetid://48374994"
	aura.Rate = 10
	aura.Lifetime = NumberRange.new(1)
	aura.Size = NumberSequence.new(1.5)
	aura.Speed = NumberRange.new(0.5)
	task.delay(10, function()
		aura.Enabled = false
		wait(1)
		aura:Destroy()
	end)
end

-- Input Prompt for Any Pet
local function promptPetName()
	local name = tostring(game:GetService("Players"):PromptInput("Enter Pet Name"))
	if name then getPet(name) end
end

-- Create Buttons
createButton("🌟 Center Pet", 0.1, centerPet)
createButton("✨ Admin Aura (Local)", 0.25, showAura)
createButton("🐱 Spawn Orange Tabby", 0.4, function() getPet("Orange Tabby") end)
createButton("🌙 Spawn Mooncat", 0.55, function() getPet("Mooncat") end)
createButton("🦄 Get ANY Pet (Prompt)", 0.7, promptPetName)
