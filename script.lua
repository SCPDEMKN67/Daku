local centerPos = Vector3.new(0, 1, 0) -- adjust if needed

for _, model in pairs(workspace:GetChildren()) do
	if model:IsA("Model") and model.Name:lower():find("pet") then
		local part = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
		if part then
			spawn(function()
				while true do
					part.CFrame = CFrame.new(centerPos)
					task.wait(0.5)
				end
			end)
		end
	end
end
