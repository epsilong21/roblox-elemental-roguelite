--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MovementConfig = require(ReplicatedStorage.Roguelite.Config.MovementConfig)

local MovementService = {}

local characterConnections: { [Player]: RBXScriptConnection } = {}

local function applyMovementConfig(humanoid: Humanoid)
	humanoid.WalkSpeed = MovementConfig.WalkSpeed
	humanoid.AutoRotate = MovementConfig.AutoRotate
	humanoid.AutoJumpEnabled = MovementConfig.AutoJumpEnabled
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, MovementConfig.JumpEnabled)
end

local function onCharacterAdded(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 5)
	if not humanoid or not humanoid:IsA("Humanoid") then
		warn(string.format("[MovementService] Humanoid no encontrado para %s", character.Name))
		return
	end

	applyMovementConfig(humanoid)
end

local function onPlayerAdded(player: Player)
	local existingConnection = characterConnections[player]
	if existingConnection then
		existingConnection:Disconnect()
	end

	characterConnections[player] = player.CharacterAdded:Connect(onCharacterAdded)

	if player.Character then
		onCharacterAdded(player.Character)
	end
end

local function onPlayerRemoving(player: Player)
	local connection = characterConnections[player]
	if connection then
		connection:Disconnect()
		characterConnections[player] = nil
	end
end

function MovementService.Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)

	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return MovementService
