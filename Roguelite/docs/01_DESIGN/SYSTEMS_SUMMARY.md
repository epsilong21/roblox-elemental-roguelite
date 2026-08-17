# Systems Summary

Este documento resume contratos de diseño ya establecidos. Los detalles específicos deben separarse por sistema antes de implementación avanzada.

## Targeting
El ataque básico selecciona automáticamente al enemigo válido más cercano dentro de un cono frontal y mantiene el objetivo mientras siga siendo válido.

## Descarga
Habilidad activa de alto impacto dirigida al objetivo automático. Consume estados elementales y su cooldown puede acelerarse mediante impactos básicos confirmados.

## Estados elementales
Modelo de preparación/detonación:
- básico aplica/prepara
- Descarga consume/detona

Límite inicial de referencia: 3 acumulaciones, configurable.

## Fuego
Núcleo: Ascuas.

- impactos aplican Ascuas
- daño periódico
- Descarga consume todas las Ascuas
- detonación escala con acumulaciones

Modificadores:
- Propagación al morir
- Explosión al morir

Transformación completa:
- explosión escala con Ascuas
- propagación añade daño inmediato
- básico obtiene pequeño AoE sin aplicar Ascuas extra
- Descarga lanza 2 brasas secundarias de daño ligero

Orden cuando Descarga mata:
1. detonación
2. explosión al morir
3. propagación al morir
