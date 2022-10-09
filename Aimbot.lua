-- Gui to Lua
-- Version: 3.2

-- Instances:

local TutorialAimbot = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Toggle = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")

--Properties:

TutorialAimbot.Name = "TutorialAimbot"
TutorialAimbot.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
TutorialAimbot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = TutorialAimbot
MainFrame.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
MainFrame.Position = UDim2.new(0.389568985, 0, 0.251020342, 0)
MainFrame.Size = UDim2.new(0.219748572, 0, 0.495918363, 0)

UICorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Position = UDim2.new(0.0834064335, 0, 0.0370370373, 0)
Title.Size = UDim2.new(0.859877169, 0, 0.168724284, 0)
Title.Font = Enum.Font.FredokaOne
Title.Text = "Tutorial Aimbot"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UICorner_2.Parent = Title

Toggle.Name = "Toggle"
Toggle.Parent = MainFrame
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.Position = UDim2.new(0.0834064335, 0, 0.563786149, 0)
Toggle.Size = UDim2.new(0.859877288, 0, 0.390946627, 0)
Toggle.Font = Enum.Font.FredokaOne
Toggle.Text = "Aimbot: Disabled"
Toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
Toggle.TextScaled = true
Toggle.TextSize = 14.000
Toggle.TextWrapped = true

UICorner_3.Parent = Toggle

-- Scripts:

local function HHCZ_fake_script() -- MainFrame.AimbotLogic 
	local script = Instance.new('LocalScript', MainFrame)

	--// Variables //--
	local Toggle = script.Parent.Toggle
	local Camera = game.Workspace.CurrentCamera
	local localPlayer = game:GetService("Players").LocalPlayer
	_G.Aimbot = false
	
	--// Aimbot Activation
	Toggle.MouseButton1Click:Connect(function()
		if _G.Aimbot == false then
			_G.Aimbot = true
			Toggle.TextColor3 = Color3.fromRGB(0, 255, 0)
			Toggle.Text = "Aimbot: Enabled"
			function closestPlayer()
				local dist = math.huge
				local target = nil
				for i,v in pairs(game:GetService("Players"):GetPlayers()) do
					if v ~= localPlayer then
						if v.Character and v.Character:FindFirstChild("Head") and v.TeamColor ~= localPlayer.TeamColor and _G.Aimbot then
							local magnitude = (v.Character.Head.Position - localPlayer.Character.Head.Position).magnitude
							if magnitude < dist then
								dist = magnitude
								target = v
							end
						end
					end
				end
				return target
			end
		else
			_G.Aimbot = false
			Toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
			Toggle.Text = "Aimbot: Disabled"
		end
	end)
	
	--// Aimbot Functionality //--
	
	local settings = {
		keybind = Enum.UserInputType.MouseButton2
	}
	
	local UserInputService = game:GetService("UserInputService")
	local aiming = false
	
	UserInputService.InputBegan:Connect(function(inp)
		if inp.UserInputType == settings.keybind then
			aiming = true
		end
	end)
	
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == settings.keybind then
			aiming = false
		end
	end)
	
	game:GetService("RunService").RenderStepped:Connect(function()
		if aiming then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer().Character.Head.Position)
		end
	end)
end
coroutine.wrap(HHCZ_fake_script)()
