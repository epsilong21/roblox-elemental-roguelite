--!strict

export type MovementConfig = {
	WalkSpeed: number,
	AutoRotate: boolean,
	JumpEnabled: boolean,
	AutoJumpEnabled: boolean,
}

local MovementConfig: MovementConfig = {
	WalkSpeed = 16,
	AutoRotate = true,
	JumpEnabled = false,
	AutoJumpEnabled = false,
}

return MovementConfig
