--!strict

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CameraConfig = require(ReplicatedStorage.Roguelite.Config.CameraConfig)

local localPlayer = Players.LocalPlayer

local characterConnection: RBXScriptConnection? = nil

local function applyCameraProperties(camera: Camera)
	camera.FieldOfView = CameraConfig.FieldOfView
end

local function onCharacterAdded(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 5)
	if not humanoid or not humanoid:IsA("Humanoid") then
		warn(string.format("[CameraController] Humanoid no encontrado para %s", character.Name))
		return
	end

	humanoid.CameraOffset = CameraConfig.CameraOffset
end

local function onCurrentCameraChanged()
	local camera = Workspace.CurrentCamera
	if camera then
		applyCameraProperties(camera)
	end
end

local function start()
	if Workspace.CurrentCamera then
		applyCameraProperties(Workspace.CurrentCamera)
	end
	Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)

	if characterConnection then
		characterConnection:Disconnect()
	end
	characterConnection = localPlayer.CharacterAdded:Connect(onCharacterAdded)

	if localPlayer.Character then
		onCharacterAdded(localPlayer.Character)
	end
end

start()
