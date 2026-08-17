# Arquitectura

## Capas

### Client
Input, cámara, HUD, VFX, animaciones visuales y feedback.

### Server
Autoridad de combate, enemigos, recompensas, progreso, validaciones y datos.

### Shared
Tipos, contratos, utilidades puras y definiciones compartidas que no otorguen autoridad al cliente.

### Config
Valores de balance y tuning.

## Regla

El cliente solicita; el servidor valida y decide.

## Remotes

No crear remotes genéricos que permitan ejecutar acciones arbitrarias.

Cada remote crítico debe tener:
- propósito definido
- payload limitado
- validación
- rate limiting cuando sea explotable
