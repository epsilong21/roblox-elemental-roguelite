# Roblox Roguelite — Workspace

Este repositorio usa una división clara de responsabilidades:

- **Usuario / Product Owner:** prueba el juego en Roblox Studio, decide preferencias y reporta sensaciones/bugs.
- **ChatGPT:** Game Director, Systems Designer, Technical Director, QA Lead y productor.
- **Claude:** ingeniero principal de implementación.

## Regla principal

El repositorio es la fuente única de verdad. No se deben tomar decisiones de diseño importantes a partir de conversaciones aisladas.

## Flujo

1. ChatGPT define una tarea y sus criterios de aceptación.
2. La tarea se registra en `docs/05_HANDOFF/ACTIVE_TASK.md` y/o GitHub Issue.
3. Claude implementa únicamente esa tarea.
4. Claude registra cambios en `docs/05_HANDOFF/LAST_REPORT.md`.
5. El usuario prueba en Roblox Studio.
6. Los resultados se registran en QA.
7. ChatGPT revisa implementación y resultados.
8. Solo después se cierra la tarea y se activa la siguiente.
