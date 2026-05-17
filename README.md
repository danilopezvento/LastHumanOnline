# Last Human Online

Un survival psicológico mobile donde internet sigue activo pero casi nadie real queda conectado.

## Estado del proyecto

- ✅ 35 scripts C# — arquitectura completa
- ✅ 25 archivos JSON — perfiles, eventos, lore
- ✅ 15 archivos .ink — diálogos de los 3 actos
- ✅ Scripts de setup automático de Unity
- ⬜ Arte (pendiente — prompts en GDD)
- ⬜ Escenas Unity (pendiente)
- ⬜ Build Android (pendiente)

## Instalación rápida

1. Instalar Unity 2022.3 LTS con módulo Android
2. Crear proyecto 2D URP llamado `LastHumanOnline`
3. Instalar paquetes: DOTween, Ink Integration, Newtonsoft JSON
4. Copiar `Setup/LHO_ProjectSetup.cs` en `Assets/_Core/Editor/`
5. En Unity: menú **Last Human Online → Setup Completo**
6. Copiar los scripts de `Scripts/` siguiendo el orden del HTML
7. Copiar `StreamingAssets/` a `Assets/StreamingAssets/`
8. Menú **Last Human Online → Auto-asignar Events**
9. Pulsar Play — verificar consola

Ver `Setup/INSTRUCCIONES_INSTALACION.txt` para pasos detallados.

## Estructura

```
Assets/
├── _Core/           # ServiceLocator, Events, SaveSystem, GameManager
├── Gameplay/        # Player, Resources, Zones, Threats
├── Network/         # NEXUS: Profiles, Chat, Feed, BotDetection
├── Narrative/       # Memory, Dialog (Ink), WorldEvents
├── UI/              # HUD, NEXUS App, Menus
├── Audio/           # FMOD AudioManager
├── Art/             # Sprites, Backgrounds, VFX
└── StreamingAssets/ # JSON data + compiled Ink
```

## Tecnología

- **Motor**: Unity 2022 LTS · URP
- **Backend**: IL2CPP · Android ARM64 + ARMv7
- **Audio**: FMOD Studio
- **Diálogo**: Ink (inkle)
- **Arte**: Leonardo AI / Midjourney
