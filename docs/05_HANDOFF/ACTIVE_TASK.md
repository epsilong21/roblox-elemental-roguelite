# Active Task

## Task
`M1-002 — Cámara`

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

`ENV-001 — Configuración de Rojo` — **DONE**. Workspace Rojo configurado y validado (`rojo build` exitoso, sincronización real Rojo → Roblox Studio confirmada visualmente por el usuario). Ver `docs/05_HANDOFF/LAST_REPORT.md` para el detalle histórico (reemplazado por el reporte de M1-001).

`M1-001 — Movimiento` — **DONE**. Locomoción base implementada sobre Humanoid estándar (`MovementConfig`, `MovementService`, `MovementBootstrap`). QA completo PASS: spawn, cardinal, diagonal, stop, jump disabled, rotation, respawn, multiplayer, mobile, output — confirmado manualmente por el usuario junto con ChatGPT. `WalkSpeed = 16` aprobado como valor actual del prototipo, no como balance definitivo. Deuda técnica pendiente: evaluar validaciones server-side contra movimiento anómalo antes de beta. Ver `docs/05_HANDOFF/LAST_REPORT.md`.
