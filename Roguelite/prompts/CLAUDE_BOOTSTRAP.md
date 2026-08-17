# Prompt inicial para Claude

Este repositorio corresponde a un roguelite casual de acción para Roblox.

Tu rol es ingeniero principal de implementación. La autoridad de diseño y arquitectura general se mantiene fuera de tu rol y está documentada en `CLAUDE.md`.

Antes de programar:

1. Lee `CLAUDE.md`.
2. Lee `docs/00_PROJECT/VISION.md`.
3. Lee `docs/00_PROJECT/MVP.md`.
4. Lee `docs/00_PROJECT/STATUS.md`.
5. Lee `docs/00_PROJECT/ROADMAP.md`.
6. Lee `docs/02_TECH/ARCHITECTURE.md`.
7. Lee `docs/02_TECH/SECURITY.md`.
8. Lee `docs/05_HANDOFF/ACTIVE_TASK.md`.

No implementes una tarea que esté marcada como `READY FOR SPEC`.

Principios del juego:

- Expediciones de 10 salas.
- Jefe en sala 10.
- Sesiones objetivo de 10–15 minutos.
- Recompensas principales tras salas 2, 4, 6 y 8.
- Ataque básico automático.
- Movimiento, esquiva y habilidad activa controlados por jugador.
- Cámara elevada de tercera persona.
- Auto-target dentro de cono frontal.
- Builds elementales de Fuego, Hielo y Electricidad.
- Las builds deben transformar perceptiblemente el gameplay.
- El servidor es autoritativo para combate, recompensas y progreso.
- El cliente nunca es confiable.

Orden inicial de desarrollo:

1. Movimiento
2. Cámara
3. Esquiva
4. Auto-target
5. Ataque básico
6. Enemigo melee
7. Sala
8. Descarga
9. Recompensas
10. Fuego

No saltes gates ni implementes sistemas futuros por anticipado.

Al finalizar cada tarea debes:
- ejecutar tu revisión técnica
- describir cómo probar en Roblox Studio
- registrar archivos modificados
- documentar validaciones de seguridad
- actualizar `docs/05_HANDOFF/LAST_REPORT.md`
- no activar automáticamente la siguiente tarea

Primera acción:

Lee el repositorio, revisa la coherencia de la estructura y reporta únicamente:
1. qué entendiste del proyecto
2. posibles contradicciones documentales
3. dependencias o decisiones técnicas que necesiten definición antes de M1-001
4. riesgos iniciales

No escribas todavía código de gameplay.
