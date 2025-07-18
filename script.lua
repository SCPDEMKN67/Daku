-- Admin UI Script for "Grow a Garden" (LocalScript)

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Pets you want to be able to spawn
local petList = {"Orange Tabby", "Mooncat", "Bone Blossom", "AnyPetNameHere"}

-- UI Creation
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AdminPanel"

-- Main Button (toggle)
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.Image = "rbxassetid://77339698" -- Gear icon or change if needed
ToggleButton.BackgroundTransparency = 1
ToggleButton.ZIndex = 10

-- Admin Frame
local AdminFrame = Instance.new("Frame", ScreenGui)
AdminFrame.Name = "AdminFrame"
AdminFrame.Size = UDim2.new(0, 300, 0, 200)
AdminFrame.Position = UDim2.new(0, 60, 0.5, -100)
AdminFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AdminFrame.BorderSizePixel = 0
AdminFrame.Visible = false
AdminFrame.Draggable = true
AdminFrame.Active = true
AdminFrame.ZIndex = 10

-- UICorner + UIStroke
local UICorner = Instance.new("UICorner", AdminFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", AdminFrame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- Minimize Button
local MinBtn = Instance.new("TextButton", AdminFrame)
MinBtn.Size = UDim2.new(0, 60, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 10)
MinBtn.Text = "Minimize"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1,1,1)

local UICorner2 = Instance.new("UICorner", MinBtn)
UICorner2.CornerRadius = UDim.new(0, 6)

-- Pet Input
local PetBox = Instance.new("TextBox", AdminFrame)
PetBox.PlaceholderText = "Enter Pet Name"
PetBox.Size = UDim2.new(0, 200, 0, 30)
PetBox.Position = UDim2.new(0, 10, 0, 50)
PetBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PetBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PetBox).CornerRadius = UDim.new(0, 6)

-- Spawn Button
local SpawnBtn = Instance.new("TextButton", AdminFrame)
SpawnBtn.Text = "Get Pet"
SpawnBtn.Size = UDim2.new(0, 80, 0, 30)
SpawnBtn.Position = UDim2.new(0, 220, 0, 50)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpawnBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnBtn).CornerRadius = UDim.new(0, 6)

-- Visual Events Button
local VisualBtn = Instance.new("TextButton", AdminFrame)
VisualBtn.Text = "Trigger Visual"
VisualBtn.Size = UDim2.new(0, 260, 0, 30)
VisualBtn.Position = UDim2.new(0, 20, 0, 100)
VisualBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
VisualBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", VisualBtn).CornerRadius = UDim.new(0, 6)

-- Functionality
ToggleButton.MouseButton1Click:Connect(function()
	AdminFrame.Visible = not AdminFrame.Visible
end)

MinBtn.MouseButton1Click:Connect(function()
	AdminFrame.Visible = false
end)

-- Spawn Pet Function (Assumes RemoteEvent exists)
SpawnBtn.MouseButton1Click:Connect(function()
	local petName = PetBox.Text
	if table.find(petList, petName) then
		local args = {[1] = petName}
		local remote = game:GetService("ReplicatedStorage"):FindFirstChild("GivePet") -- Change if your remote is different
		if remote then
			remote:FireServer(unpack(args))
		else
			warn("GivePet Remote not found!")
		end
	else
		warn("Invalid pet name!")
	end
end)

-- Visual Effect (only you see it)
VisualBtn.MouseButton1Click:Connect(function()
	local part = Instance.new("Part", workspace)
	part.Size = Vector3.new(4, 1, 4)
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	part.BrickColor = BrickColor.Random()
	part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)

	local tween = TweenService:Create(part, TweenInfo.new(1, Enum.EasingStyle.Bounce), {Transparency = 1, Size = Vector3.new(8, 0.1, 8)})
	tween:Play()

	game:GetService("Debris"):AddItem(part, 2)
end)
