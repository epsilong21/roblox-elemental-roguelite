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

## Desarrollo local con Rojo

Flujo de trabajo:

```text
VS Code / archivos locales
        ↓
       Rojo
        ↓
 Roblox Studio
```

1. Instala las herramientas del proyecto (ya gestionadas por Rokit vía `rokit.toml`).
2. Levanta el servidor de Rojo desde la raíz del repositorio:

   ```powershell
   rojo serve
   ```

3. Abre Roblox Studio, instala/activa el plugin de Rojo y usa **Connect** para sincronizar con el servidor local.

El mapeo de carpetas está definido en `default.project.json`.
