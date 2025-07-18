-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "Center Pets"
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)

-- Core Logic
local function centerEquippedPets()
	for _, model in ipairs(workspace:GetDescendants()) do
		if model:IsA("Model") and model.Name:lower():find("pet") then
			local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
			if root then
				spawn(function()
					while true do
						root.CFrame = CFrame.new(0, 1, 0)
						wait(0.5)
					end
				end)
			end
		end
	end
end

Button.MouseButton1Click:Connect(centerEquippedPets)
