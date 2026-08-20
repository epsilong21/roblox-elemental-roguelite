### Task
M1-001 — Movimiento

### Result
Completed — DONE (QA completo aprobado)

### Files changed
- `src/config/MovementConfig.lua` (nuevo)
- `src/server/MovementService.lua` (nuevo)
- `src/server/MovementBootstrap.server.lua` (nuevo)
- `src/config/.gitkeep` (eliminado, reemplazado por contenido real)
- `src/server/.gitkeep` (eliminado, reemplazado por contenido real)
- `docs/05_HANDOFF/ACTIVE_TASK.md` (actualizado)
- `docs/05_HANDOFF/LAST_REPORT.md` (este archivo)
- `docs/00_PROJECT/CHANGELOG.md` (actualizado)

### Implementation
`MovementConfig.lua` centraliza los valores canónicos de movimiento (`WalkSpeed = 16`, `AutoRotate = true`, `JumpEnabled = false`, `AutoJumpEnabled = false`) como ModuleScript tipado en `src/config`, sin duplicarlos por código.

`MovementService.lua` (ModuleScript en `src/server`) expone `Start()`, que:
- se suscribe a `Players.PlayerAdded` y `Players.PlayerRemoving`,
- procesa jugadores ya presentes al iniciar el servicio,
- por cada jugador, se suscribe a `CharacterAdded` (desconectando cualquier suscripción previa del mismo jugador para evitar duplicados) y procesa el personaje actual si ya existe,
- en `onCharacterAdded`, espera el `Humanoid` con `WaitForChild(..., 5)` y valida su existencia/tipo antes de usarlo,
- aplica `MovementConfig`: `WalkSpeed`, `AutoRotate`, `AutoJumpEnabled`, fuerza `JumpPower = 0` y `JumpHeight = 0`, y usa `Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)` para desactivar el salto de forma robusta (cubre ambos modos `UseJumpPower`/`JumpHeight`),
- en `onPlayerRemoving`, desconecta y limpia la conexión del jugador para no dejar conexiones vivas.

`MovementBootstrap.server.lua` (Script en `src/server`) solo hace `require` de `MovementService` y llama a `Start()`. Sin lógica adicional, sin framework de servicios.

No se creó código cliente (Roblox controla el input estándar) ni RemoteEvents/RemoteFunctions de movimiento.

### Client/server flow
1. Rojo sincroniza `src/server` → `ServerScriptService/RogueliteServer`. `MovementBootstrap` corre como `Script` al iniciar el servidor y llama a `MovementService.Start()`.
2. El servidor escucha `PlayerAdded`/`CharacterAdded` y, cada vez que aparece un `Humanoid` (spawn inicial, muerte/respawn, Reset Character), aplica los valores de `MovementConfig` directamente sobre ese `Humanoid`.
3. El cliente no interviene: usa los controles estándar de Roblox (WASD/thumbstick/gamepad) sin ningún script propio de input ni predicción de movimiento.
4. No hay comunicación cliente→servidor relacionada con movimiento; el servidor nunca confía en, ni acepta, WalkSpeed/posición/dirección/velocidad enviados por el cliente.

### Security
- Toda la configuración canónica de movimiento vive en `ReplicatedStorage/Roguelite/Config` (legible, no escribible por el cliente) y se aplica exclusivamente desde `MovementService` en el servidor.
- No existen remotes de movimiento explotables (no se crearon RemoteEvents/RemoteFunctions).
- No se implementó anti-speedhack complejo (fuera de alcance de M1-001), según lo especificado.
- **Deuda de seguridad registrada:** antes de beta, evaluar validaciones server-side contra movimiento anómalo (teleport/speed detection, reconciliation).

### Validation
- `rojo build -o .m1-001-validation.rbxlx`: **PASS**. Build exitoso, archivo temporal generado y eliminado después; no quedó versionado (cubierto además por `.gitignore`).
- `git diff --check`: sin errores de espacios en blanco (solo aviso informativo de conversión LF→CRLF, no un fallo).

### How to test
Ver checklist QA-001 a QA-010 en `docs/05_HANDOFF/ACTIVE_TASK.md`. Resumen:
1. Conectar Rojo → Roblox Studio (`rojo serve`, plugin Connect).
2. Play Solo: verificar spawn, WASD, diagonales, stop, Space repetido (no debe saltar), rotación al cambiar de dirección.
3. Reset Character: reconfirmar WalkSpeed, movimiento, salto desactivado, AutoRotate.
4. Probar con ≥2 jugadores (Studio → Test → 2 Players) moviéndose independientemente.
5. Emulación móvil de Studio: thumbstick, movimiento, ausencia de auto-jump, sin errores.
6. Revisar Output: sin errores ni spam.

### QA results
Confirmado manualmente por el usuario junto con ChatGPT, con pruebas reales en Roblox Studio:

| Caso | Resultado |
|---|---|
| QA-001 Spawn | PASS |
| QA-002 Cardinal | PASS |
| QA-003 Diagonal | PASS |
| QA-004 Stop | PASS |
| QA-005 Jump disabled | PASS |
| QA-006 Rotation | PASS |
| QA-007 Respawn | PASS |
| QA-008 Multiplayer | PASS |
| QA-009 Mobile | PASS |
| QA-010 Output | PASS |

**Game feel:** `WalkSpeed = 16` evaluado como "Bien" y aprobado como valor actual del prototipo — no se establece como balance definitivo, queda abierto a ajuste en milestones posteriores.

### Known issues
Ninguno. QA completo sin fallos.

### Design questions
Ninguna.

### Known debt (registrada, no bloqueante)
Antes de beta: evaluar validaciones server-side contra movimiento anómalo (teleport/speed detection, reconciliation). Ver sección "Security" arriba.

### Suggested next action
Especificar `M1-002 — Cámara` (comportamiento, arquitectura cliente/servidor, archivos esperados, criterios de aceptación, plan de pruebas) antes de iniciar implementación.
