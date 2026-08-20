# Active Task

## Task
`M1-003 — Esquiva`

## Estado
READY FOR SPEC

## Importante
Claude NO debe implementar todavía hasta que esta ficha tenga:
- comportamiento aprobado
- arquitectura cliente/servidor
- archivos esperados
- criterios de aceptación
- plan de pruebas

Esta tarea será completada por ChatGPT antes de entregarse a implementación.

---

## Historial

`M1-002 — Cámara` — **DONE**. Cámara base sobre el sistema nativo de Roblox (`CameraConfig`, `CameraController`, defaults estáticos de `StarterPlayer` en `default.project.json`). QA completo PASS: spawn, distance, manual rotation, follow, movement compatibility, occlusion, respawn, multiplayer, mobile, output.

Game feel aprobado para prototipo (no balance definitivo):
- `CameraDistance = 18` → Bien
- `CameraOffset Y = 2.5` → Bien
- Follow → Bien
- Visibilidad general → **Aceptable** — a revisar cuando exista una sala de combate real con enemigos (no en M1-002).

`QA-CAM-BLOCKER-001` — **resuelto**. Arquitectura aprobada:
- Defaults estáticos/no-scriptables de cámara (`CameraMode`, `CameraMinZoomDistance`, `CameraMaxZoomDistance`, `DevComputerCameraMovementMode`, `DevTouchCameraMovementMode`, `DevCameraOcclusionMode`) viven en `StarterPlayer` vía `$properties` en `default.project.json`, no en runtime.
- **Deuda/limitación de proceso registrada:** Rojo live sync no puede escribir propiedades "Unscriptable" de `StarterPlayer`; cuando esos valores cambien, hay que regenerar el place (`rojo build -o Roguelite.rbxl`) y volver a abrirlo en Studio — live sync normal (scripts, resto de instancias) no se ve afectado.
- `CameraController.client.lua` solo controla valores runtime válidos: `FieldOfView` (sobre `Workspace.CurrentCamera`) y `Humanoid.CameraOffset`.

`ENV-001 — Configuración de Rojo` — **DONE**. Workspace Rojo configurado y validado.

`M1-001 — Movimiento` — **DONE**. Locomoción base sobre Humanoid estándar. `WalkSpeed = 16` aprobado como valor actual, no definitivo. Deuda técnica pendiente: evaluar validaciones server-side contra movimiento anómalo antes de beta.
