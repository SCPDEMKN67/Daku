-- UI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)

btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.6, 0)
btn.Text = "🧲 Center All Pets"
btn.BackgroundColor3 = Color3.fromRGB(120, 200, 255)
btn.TextColor3 = Color3.new(0, 0, 0)

local centerPos = Vector3.new(0, 1, 0) -- Set to garden center position (adjust if needed)

btn.MouseButton1Click:Connect(function()
	local lp = game.Players.LocalPlayer
	local petsFolder = workspace:FindFirstChild("Pets") or workspace:FindFirstChild("EquippedPets")

	if not petsFolder then
		warn("❌ Could not find pets folder in workspace.")
		return
	end

	for _, pet in pairs(petsFolder:GetChildren()) do
		if pet:IsA("Model") and pet:FindFirstChild("Owner") and pet.Owner.Value == lp then
			local hrp = pet:FindFirstChild("HumanoidRootPart") or pet:FindFirstChildWhichIsA("BasePart")
			if hrp then
				-- Constantly center the pet
				spawn(function()
					while pet.Parent do
						hrp.CFrame = CFrame.new(centerPos)
						wait(0.5)
					end
				end)
			end
		end
	end
end)
