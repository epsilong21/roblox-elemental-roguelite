--!strict

-- CameraMode, zoom distance, DevComputerCameraMovementMode, DevTouchCameraMovementMode
-- y DevCameraOcclusionMode viven como defaults estáticos de StarterPlayer en
-- default.project.json: un LocalScript no tiene permiso para escribirlos en runtime
-- (capability RobloxScript). Solo se mantienen aquí los valores que sí aplica
-- CameraController en runtime, para no duplicar una fuente de verdad que un lado no puede usar.

export type CameraConfig = {
	CameraOffset: Vector3,
	FieldOfView: number,
}

local CameraConfig: CameraConfig = {
	CameraOffset = Vector3.new(0, 2.5, 0),
	FieldOfView = 70,
}

return CameraConfig
