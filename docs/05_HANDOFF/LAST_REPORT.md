### Task
M1-002 — Cámara

### Result
Completed — DONE (QA completo aprobado)

### Files changed
- `src/config/CameraConfig.lua` (nuevo — solo `CameraOffset`, `FieldOfView`)
- `src/client/CameraController.client.lua` (nuevo — LocalScript)
- `default.project.json` (defaults estáticos de cámara añadidos a `StarterPlayer` vía `$properties`, con `$className` explícito)
- `src/client/.gitkeep` (eliminado, reemplazado por contenido real)
- `.gitignore` (añadido `*.rbxl.lock`/`*.rbxlx.lock` — artefacto de Studio al abrir el place generado durante la investigación de live sync)
- `docs/05_HANDOFF/ACTIVE_TASK.md` (actualizado)
- `docs/05_HANDOFF/LAST_REPORT.md` (este archivo)
- `docs/00_PROJECT/CHANGELOG.md` (actualizado)
- `docs/00_PROJECT/STATUS.md` (actualizado)

### Implementation
Cámara nativa de Roblox (Classic + Follow), sin `CameraType.Scriptable`, sin tocar `PlayerModule`/`CameraModule`.

**Arquitectura final aprobada** (tras `QA-CAM-BLOCKER-001`):
- Defaults estáticos/no-scriptables de cámara — `CameraMode`, `CameraMinZoomDistance`, `CameraMaxZoomDistance`, `DevComputerCameraMovementMode`, `DevTouchCameraMovementMode`, `DevCameraOcclusionMode` — configurados en `StarterPlayer` vía `$properties` en `default.project.json` (fuente de verdad versionada). Se generan en el place mediante `rojo build`; Rojo live sync no puede escribirlos en caliente (propiedades "Unscriptable" para el plugin de Studio).
- `CameraConfig.lua` (ModuleScript en `src/config`) solo contiene `CameraOffset = Vector3.new(0, 2.5, 0)` y `FieldOfView = 70` — los únicos valores que sí se aplican en runtime.
- `CameraController.client.lua` (LocalScript en `src/client`): aplica `FieldOfView` sobre `Workspace.CurrentCamera` al iniciar y ante reemplazo de la cámara; escucha `CharacterAdded`, obtiene `Humanoid` de forma segura y aplica `CameraOffset` en cada spawn/respawn; evita conexiones duplicadas y limpia conexiones. No escribe ninguna propiedad `Dev*`/`CameraMode`/zoom.

Sin RemoteEvents, sin lógica de cámara en servidor, sin modificar `MovementService`.

### Client/server flow
1. Rojo sincroniza `src/client` → `StarterPlayer/StarterPlayerScripts/RogueliteClient`; `default.project.json` aplica los defaults estáticos de `StarterPlayer` (vía build, no live sync).
2. `CameraController` corre como `LocalScript` por cliente: fija `FieldOfView` y reacciona a `CharacterAdded`/reemplazo de `CurrentCamera`.
3. Todo ocurre en el cliente; el servidor no participa en cámara y no hay comunicación cliente→servidor relacionada.
4. `MovementService` (servidor) sigue siendo el único responsable de `WalkSpeed`/salto/`AutoRotate`; no fue tocado por M1-002.

### QA results
Confirmado por el usuario con pruebas reales en Roblox Studio:

| Caso | Resultado |
|---|---|
| QA-CAM-001 Spawn | PASS |
| QA-CAM-002 Distance | PASS |
| QA-CAM-003 Manual Rotation | PASS |
| QA-CAM-004 Follow | PASS |
| QA-CAM-005 Movement Compatibility | PASS |
| QA-CAM-006 Occlusion | PASS |
| QA-CAM-007 Respawn | PASS |
| QA-CAM-008 Multiplayer | PASS |
| QA-CAM-009 Mobile | PASS |
| QA-CAM-010 Output | PASS |

`QA-CAM-BLOCKER-001` — **resuelto**, confirmado en el QA final.

**Game feel — aprobado para prototipo, no balance definitivo:**
- `CameraDistance = 18` → Bien
- `CameraOffset Y = 2.5` → Bien
- Follow → Bien
- Visibilidad general → **Aceptable**. Registrado para revisión futura: reevaluar cuando exista una sala de combate real con enemigos (fuera de alcance de M1-002).

### Security
- Sin RemoteEvents/RemoteFunctions de cámara; sin lógica de cámara en servidor; CFrame de cámara nunca replicado.
- Defaults de cámara en `StarterPlayer` son configuración de experiencia (no datos de jugador), versionados en `default.project.json`; no otorgan autoridad al cliente sobre ningún sistema crítico.

### Known process limitation (registrada, no bloqueante)
**Rojo live sync no sincroniza propiedades "Unscriptable" de `StarterPlayer`** (confirmado: `rojo build` las serializa correctamente; el plugin de Studio no puede escribirlas en caliente por restricción de la API de Plugin/Scripting de Roblox). Procedimiento cuando estos valores cambien en el futuro: `rojo build -o Roguelite.rbxl` y reabrir el place en Studio; el resto del live sync (scripts, otras instancias) no se ve afectado. `Roguelite.rbxl`/`.lock` no se versionan (`.gitignore`).

### Known issues
- Shift Lock no fue deshabilitado (sin evidencia de inconsistencia detectada en QA).
- Deuda heredada de M1-001: evaluar validaciones server-side contra movimiento anómalo antes de beta.

### Design questions
Ninguna.

### Suggested next action
Especificar `M1-003 — Esquiva` (comportamiento, arquitectura cliente/servidor, archivos esperados, criterios de aceptación, plan de pruebas) antes de iniciar implementación.
