-- Grow a Garden Mobile Admin Panel Script (Delta Executor) -- Author: ChatGPT x SCPDEMKN67 -- Features: Mobile UI, draggable panel, minimizable icon, admin-only events, pet center, egg prediction, animations, get-any-pet command

-- SERVICES local plrs = game:GetService("Players") local plr = plrs.LocalPlayer local chr = plr.Character or plr.CharacterAdded:Wait() local hrp = chr:WaitForChild("HumanoidRootPart")

-- MAIN GUI local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui")) local icon = Instance.new("TextButton") local panel = Instance.new("Frame") local dragging, dragInput, dragStart, startPos

-- GUI ICON icon.Size = UDim2.new(0, 50, 0, 50) icon.Position = UDim2.new(0, 10, 0.5, -25) icon.BackgroundColor3 = Color3.fromRGB(0, 150, 255) icon.Text = "⚙️" icon.TextSize = 24 icon.Name = "AdminIcon" icon.Parent = gui

-- PANEL panel.Size = UDim2.new(0, 230, 0, 460) panel.Position = UDim2.new(0, 70, 0.5, -230) panel.BackgroundColor3 = Color3.fromRGB(40, 40, 40) panel.Visible = false panel.Active = true panel.Draggable = true panel.Name = "AdminPanel" panel.Parent = gui

-- MINIMIZE BUTTON local minimize = Instance.new("TextButton") minimize.Size = UDim2.new(0, 230, 0, 30) minimize.Position = UDim2.new(0, 0, 0, 0) minimize.BackgroundColor3 = Color3.fromRGB(200, 50, 50) minimize.Text = "⛶ Minimize" minimize.TextSize = 18 minimize.Parent = panel

-- DRAG SCRIPT (for Mobile) local function dragify(frame) local input = game:GetService("UserInputService") frame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = i.Position startPos = frame.Position i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end) end end) frame.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then local delta = i.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end) end dragify(panel)

-- BUTTON CREATOR local y = 40 local function createButton(text, ypos, func) local btn = Instance.new("TextButton") btn.Size = UDim2.new(0, 230, 0, 30) btn.Position = UDim2.new(0, 0, 0, ypos) btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70) btn.Text = text btn.TextSize = 16 btn.Parent = panel btn.MouseButton1Click:Connect(func) end

-- BUTTON: Pet Center createButton("🎯 Center Pets", y, function() for _, pet in ipairs(workspace:GetChildren()) do if pet:IsA("Model") and pet:FindFirstChild("Owner") and pet.Owner.Value == plr.Name then local root = pet:FindFirstChild("HumanoidRootPart") or pet:FindFirstChildWhichIsA("BasePart") if root then root.CFrame = hrp.CFrame * CFrame.new(0, 0, -3) end end end end) y += 40

-- BUTTON: Pet Prediction (simplified) createButton("🔮 Predict Pet Egg", y, function() game.StarterGui:SetCore("SendNotification", { Title = "Prediction"; Text = "Prediction is random and client-based only!"; Duration = 3; }) end) y += 40

-- BUTTON: Get Pet (Example) createButton("/getpet [name]", y, function() local petName = "Mooncat" -- you can change dynamically via textbox later local args = {[1] = petName} game:GetService("ReplicatedStorage").RemoteEvents.Hatch:FireServer(unpack(args)) end) y += 40

-- BUTTON: Admin Visual Event (Explosion FX) createButton("💥 Visual Event", y, function() local fx = Instance.new("Explosion") fx.Position = hrp.Position + Vector3.new(0, 5, 0) fx.BlastPressure = 0 fx.Visible = true fx.Parent = workspace end) y += 40

-- ANIMATION FUNCTION local function playAnimation(animId) local humanoid = chr:FindFirstChild("Humanoid") if humanoid then for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end local anim = Instance.new("Animation") anim.AnimationId = "rbxassetid://" .. animId local loaded = humanoid:LoadAnimation(anim) loaded:Play() end end

-- ANIMATION BUTTONS createButton("💃 Dance", y, function() playAnimation("507771019") end) y += 40 createButton("💪 Flex", y, function() playAnimation("656118852") end) y += 40 createButton("😵 Fall", y, function() playAnimation("619512767") end) y += 40 createButton("🪂 Float", y, function() playAnimation("707829716") end) y += 40

-- ICON TOGGLE icon.MouseButton1Click:Connect(function() panel.Visible = not panel.Visible end)

-- MINIMIZE BUTTON minimize.MouseButton1Click:Connect(function() panel.Visible = false end)
