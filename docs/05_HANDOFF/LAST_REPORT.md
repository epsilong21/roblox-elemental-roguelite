### Task
ENV-001 — Configuración de Rojo

### Result
Completed — DONE (cerrada tras validación real en Roblox Studio por el usuario)

### Environment
- Rojo: 7.7.0 (coincide con `rokit.toml`)
- Rokit: 1.2.0
- Nota: ambos binarios están instalados en `%USERPROFILE%\.rokit\bin`, pero ese directorio **no estaba en el PATH** de la sesión de terminal usada durante esta tarea (ni en Git Bash ni en PowerShell). Se invocaron con ruta completa para validar. Ver "Known issues".

### Files changed
- `default.project.json` (nuevo)
- `.gitignore` (nuevo)
- `README.md` (sección añadida: "Desarrollo local con Rojo")
- `docs/05_HANDOFF/ACTIVE_TASK.md` (actualizado)
- `docs/05_HANDOFF/LAST_REPORT.md` (este archivo)

### Implementation
Se configuró `default.project.json` (formato Rojo 7) para mapear la estructura existente de `src/` al árbol de Roblox Studio aprobado, sin usar `rojo init` y sin reorganizar carpetas.

Se creó `.gitignore` con `*.rbxl` y `*.rbxlx` para evitar que artefactos de build de Rojo queden versionados accidentalmente. Esto no estaba en la lista original de archivos esperados, pero es una necesidad técnica directa del requisito de validación de ENV-001 (asegurar que el archivo temporal de build nunca quede versionado), así que se documenta aquí como justificación.

`src/tests` se dejó fuera del árbol de `default.project.json` intencionalmente.

### Rojo mapping
| Filesystem | Roblox |
|---|---|
| `src/shared` | `ReplicatedStorage/Roguelite/Shared` |
| `src/config` | `ReplicatedStorage/Roguelite/Config` |
| `src/server` | `ServerScriptService/RogueliteServer` |
| `src/client` | `StarterPlayer/StarterPlayerScripts/RogueliteClient` |
| `src/tests` | No mapeado (fuera del runtime) |

### Validation
- JSON: válido (`ConvertFrom-Json` sin errores).
- Primer intento de `rojo build`: falló con `Instance "Roguelite" is missing some required information` porque el nodo intermedio `Roguelite` (carpeta contenedora dentro de `ReplicatedStorage`) no tenía `$path` ni era un servicio conocido, por lo que Rojo no podía inferir su clase. Se corrigió añadiendo `"$className": "Folder"` explícito a ese nodo.
- Segundo intento: `rojo build -o .env001-validation.rbxlx` finalizó correctamente ("Built project to .env001-validation.rbxlx").
- El archivo `.env001-validation.rbxlx` fue eliminado tras la validación y no quedó versionado (confirmado con `git status` y ahora cubierto por `.gitignore`).
- **Sincronización real Rojo → Roblox Studio validada por el usuario.** `rojo serve` levantado localmente (puerto 34872), plugin de Rojo conectado desde Studio, y se confirmó visualmente en el Explorer la presencia de:
  - `ReplicatedStorage/Roguelite/Config`
  - `ReplicatedStorage/Roguelite/Shared`
  - `ServerScriptService/RogueliteServer`
  - `StarterPlayer/StarterPlayerScripts/RogueliteClient`

  ENV-001 queda **DONE**.

### How to test
1. Abrir una terminal en la raíz del repositorio.
2. Ejecutar `rojo serve` (si el comando no se reconoce, usar la ruta completa `~/.rokit/bin/rojo.exe serve` o revisar el PATH — ver "Known issues").
3. Abrir Roblox Studio.
4. Abrir/activar el plugin de Rojo y usar **Connect** para conectarse al servidor local (por defecto `localhost:34872`).
5. En el Explorer de Studio, verificar el árbol resultante (ver sección 9 del informe final que sigue a continuación de este mensaje).
6. Confirmar que no aparece contenido de `src/tests`.

### Known issues
- Los ejecutables `rojo.exe` y `rokit.exe` existen en `%USERPROFILE%\.rokit\bin` pero ese directorio no estaba en el PATH de esta sesión de terminal. Puede requerir reiniciar la terminal, verificar la variable de entorno PATH del usuario, o que la instalación original de Rokit no completó el registro en PATH. Esto no bloquea la sincronización via Studio (el plugin no depende del PATH del sistema), pero sí afecta a `rojo serve`/`rojo build` invocados desde una terminal nueva.
- No se ha realizado todavía la prueba interactiva real Rojo → Roblox Studio (pendiente del usuario, según alcance de ENV-001).

### Design questions
Ninguna. No hubo bloqueos que requirieran decisión de diseño.

### Suggested next action
Especificar `M1-001 — Movimiento` (comportamiento, arquitectura cliente/servidor, archivos esperados, criterios de aceptación, plan de pruebas) antes de iniciar implementación.
