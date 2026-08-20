# Changelog

## Unreleased

- Entorno de colaboración ChatGPT ↔ Claude definido.
- Arquitectura documental inicial creada.
- ENV-001 — Configuración del workspace Rojo: `default.project.json` mapea `src/` al árbol de Roblox Studio aprobado (`ReplicatedStorage/Roguelite/{Shared,Config}`, `ServerScriptService/RogueliteServer`, `StarterPlayer/StarterPlayerScripts/RogueliteClient`). `rojo build` validado y sincronización real Rojo → Roblox Studio confirmada.
- M1-001 — Movimiento: **DONE**. Locomoción base con `Humanoid` estándar (`MovementConfig`, `MovementService`, `MovementBootstrap`). WalkSpeed = 16 (aprobado como valor actual, no definitivo), salto y AutoJump desactivados server-side, sin RemoteEvents de movimiento. QA completo PASS (spawn, cardinal, diagonal, stop, jump disabled, rotation, respawn, multiplayer, mobile, output). Deuda registrada: validaciones server-side contra movimiento anómalo antes de beta.
