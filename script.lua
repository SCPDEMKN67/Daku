-- Grow a Garden Pet Prediction + Auto Center UI
-- Author: SCPDEMKN67

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "PetPredictor"

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "🎯 Pet Prediction"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local predictBtn = Instance.new("TextButton", mainFrame)
predictBtn.Size = UDim2.new(1, -20, 0, 35)
predictBtn.Position = UDim2.new(0, 10, 0, 35)
predictBtn.Text = "🔮 Predict Egg"
predictBtn.BackgroundColor3 = Color3.fromRGB(65, 130, 195)
predictBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
predictBtn.Font = Enum.Font.GothamBold
predictBtn.TextSize = 16
predictBtn.BorderSizePixel = 0

local centerBtn = Instance.new("TextButton", mainFrame)
centerBtn.Size = UDim2.new(1, -20, 0, 35)
centerBtn.Position = UDim2.new(0, 10, 0, 75)
centerBtn.Text = "📍 Center Pet"
centerBtn.BackgroundColor3 = Color3.fromRGB(55, 190, 90)
centerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
centerBtn.Font = Enum.Font.GothamBold
centerBtn.TextSize = 16
centerBtn.BorderSizePixel = 0

-- Predict Egg Function
local function predictEgg()
	local predictFunc = ReplicatedStorage:FindFirstChild("PredictEgg")
	if predictFunc and predictFunc:IsA("RemoteFunction") then
		local result = predictFunc:InvokeServer()
		predictBtn.Text = "🎉 " .. tostring(result)
	else
		predictBtn.Text = "❌ Prediction Failed"
	end
end

-- Center Pet Function (Orange Tabby or Mooncat)
local function centerPet()
	local garden = workspace:FindFirstChild("Garden")
	local petsFolder = workspace:FindFirstChild("Pets")
	if not garden or not petsFolder then return end

	local middle = garden:FindFirstChild("Middle")
	if not middle then return end

	local preferredPets = {"Orange Tabby", "Mooncat"}
	for _, petName in ipairs(preferredPets) do
		local pet = petsFolder:FindFirstChild(petName)
		if pet and pet:IsDescendantOf(petsFolder) then
			pet:SetPrimaryPartCFrame(CFrame.new(middle.Position + Vector3.new(0, 1.5, 0)))
			centerBtn.Text = "✅ " .. petName .. " centered"
			return
		end
	end

	centerBtn.Text = "❌ Pet not found"
end

-- Bind Buttons
predictBtn.MouseButton1Click:Connect(predictEgg)
centerBtn.MouseButton1Click:Connect(centerPet)
