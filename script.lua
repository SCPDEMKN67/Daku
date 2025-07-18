-- Grow a Garden Script UI: Pet Center + Egg Prediction
local player = game.Players.LocalPlayer
local gardenCenter = Vector3.new(0, 5, 0) -- Change this to your garden center coords
local petPredictionEnabled = false
local petLockEnabled = false

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrowGardenUI"
ScreenGui.Parent = game.CoreGui

local function createButton(name, pos, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 180, 0, 40)
	button.Position = pos
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.Parent = ScreenGui
	button.MouseButton1Click:Connect(callback)
	return button
end

-- Pet Lock Button
createButton("🔒 Toggle Pet Center Lock", UDim2.new(0, 50, 0, 50), function()
	petLockEnabled = not petLockEnabled
	game.StarterGui:SetCore("SendNotification", {
		Title = "Pet Lock",
		Text = petLockEnabled and "Enabled" or "Disabled"
	})
end)

-- Egg Predictor Button
createButton("🐣 Predict Egg Pet", UDim2.new(0, 50, 0, 100), function()
	petPredictionEnabled = true
	game.StarterGui:SetCore("SendNotification", {
		Title = "Pet Predictor",
		Text = "Monitoring Eggs..."
	})
end)

-- 🌀 Pet Lock Loop
task.spawn(function()
	while true do
		if petLockEnabled then
			for _, obj in pairs(workspace:GetChildren()) do
				if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.Name ~= player.Name then
					-- Teleport pet to garden center
					pcall(function()
						obj:MoveTo(gardenCenter)
					end)
				end
			end
		end
		task.wait(1)
	end
end)

-- 🔮 Egg Predictor Loop
task.spawn(function()
	while true do
		if petPredictionEnabled then
			for _, egg in pairs(workspace:GetDescendants()) do
				if egg:IsA("Model") and egg.Name:lower():find("egg") then
					local hatchInfo = egg:FindFirstChild("PetToHatch")
					if hatchInfo and hatchInfo:IsA("StringValue") then
						game.StarterGui:SetCore("SendNotification", {
							Title = "Prediction",
							Text = "Pet: " .. hatchInfo.Value
						})
						petPredictionEnabled = false -- Only show once per click
					end
				end
			end
		end
		task.wait(1)
	end
end)
