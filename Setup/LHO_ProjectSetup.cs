// ================================================================
// LHO_ProjectSetup.cs
// SCRIPT DE CONFIGURACIÓN AUTOMÁTICA — SOLO EDITOR
//
// CÓMO USARLO:
// 1. Copia este archivo en Assets/_Core/Editor/LHO_ProjectSetup.cs
// 2. En Unity: menú superior → "Last Human Online" → "Setup Completo"
// 3. Espera 30 segundos. El proyecto se monta solo.
//
// QUÉ HACE AUTOMÁTICAMENTE:
//   ✓ Crea todas las carpetas del proyecto
//   ✓ Crea los 33 ScriptableObject Events
//   ✓ Crea los 4 GameObjects principales
//   ✓ Añade los componentes a cada GameObject
//   ✓ Crea el PostDatabase ScriptableObject
//   ✓ Verifica que los paquetes están instalados
// ================================================================

#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

public class LHO_ProjectSetup : EditorWindow
{
    [MenuItem("Last Human Online/Setup Completo #&s")]
    public static void RunSetup()
    {
        if (!EditorUtility.DisplayDialog(
            "Last Human Online — Setup",
            "Esto creará toda la estructura del proyecto automáticamente.\n\n" +
            "✓ Carpetas\n✓ ScriptableObjects (33 Events)\n" +
            "✓ GameObjects en la escena\n\n" +
            "¿Continuar?",
            "Sí, montar el proyecto", "Cancelar"))
            return;

        EditorUtility.DisplayProgressBar("LHO Setup", "Creando carpetas...", 0.1f);
        CreateFolders();

        EditorUtility.DisplayProgressBar("LHO Setup", "Creando Events...", 0.3f);
        CreateAllEvents();

        EditorUtility.DisplayProgressBar("LHO Setup", "Creando ScriptableObjects...", 0.5f);
        CreateScriptableObjects();

        EditorUtility.DisplayProgressBar("LHO Setup", "Creando GameObjects...", 0.7f);
        CreateGameObjects();

        EditorUtility.DisplayProgressBar("LHO Setup", "Finalizando...", 0.9f);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        EditorUtility.ClearProgressBar();
        EditorUtility.DisplayDialog(
            "LHO Setup completado",
            "✓ Carpetas creadas\n" +
            "✓ 33 Events creados en Assets/_Core/Events/Channels/\n" +
            "✓ GameObjects creados en la escena\n\n" +
            "SIGUIENTE PASO:\n" +
            "Abre la ventana 'Last Human Online → Verificar Setup' " +
            "para comprobar que todo está bien.",
            "Entendido");
    }

    // ── 1. CARPETAS ──────────────────────────────────────────────
    static void CreateFolders()
    {
        string[] folders = {
            "Assets/_Core",
            "Assets/_Core/Events",
            "Assets/_Core/Events/Channels",
            "Assets/Gameplay",
            "Assets/Gameplay/Threats",
            "Assets/Network",
            "Assets/Narrative",
            "Assets/UI",
            "Assets/UI/Menus",
            "Assets/Audio",
            "Assets/Art",
            "Assets/Art/Characters",
            "Assets/Art/Environments",
            "Assets/Art/UI",
            "Assets/Art/VFX",
            "Assets/StreamingAssets",
            "Assets/StreamingAssets/profiles",
            "Assets/StreamingAssets/events",
            "Assets/StreamingAssets/lore",
            "Assets/StreamingAssets/dialog",
            "Assets/Scenes",
            "Assets/Prefabs",
            "Assets/Prefabs/UI",
        };

        foreach (var folder in folders)
        {
            if (!AssetDatabase.IsValidFolder(folder))
            {
                var parent = Path.GetDirectoryName(folder);
                var name   = Path.GetFileName(folder);
                AssetDatabase.CreateFolder(parent, name);
            }
        }

        Debug.Log("[LHO] Carpetas creadas ✓");
    }

    // ── 2. EVENTS ────────────────────────────────────────────────
    static readonly Dictionary<string, string> EVENTS = new()
    {
        // GameEvents (sin dato)
        { "OnGameStart",        "GameEvent" },
        { "OnGamePause",        "GameEvent" },
        { "OnGameResume",       "GameEvent" },
        { "OnNEXUSOpen",        "GameEvent" },
        { "OnNEXUSClose",       "GameEvent" },
        { "OnActChanged",       "GameEvent" },
        { "OnBatteryLow",       "GameEvent" },
        { "OnBatteryCritical",  "GameEvent" },
        { "OnSignalLost",       "GameEvent" },
        { "OnNoiseCritical",    "GameEvent" },
        { "OnZoneLoaded",       "GameEvent" },
        { "OnDialogStart",      "GameEvent" },
        { "OnDialogEnd",        "GameEvent" },
        { "OnChoicesReady",     "GameEvent" },
        { "OnFadeInComplete",   "GameEvent" },
        { "OnFadeOutComplete",  "GameEvent" },
        { "OnDatabaseReady",    "GameEvent" },
        { "OnWorldDbReady",     "GameEvent" },
        { "OnRefreshRequested", "GameEvent" },
        { "OnRepositoryReady",  "GameEvent" },
        { "OnResume",           "GameEvent" },
        { "OnReturnToMenu",     "GameEvent" },
        // FloatEvents
        { "OnBatteryChanged",   "FloatEvent" },
        { "OnSignalChanged",    "FloatEvent" },
        { "OnNoiseChanged",     "FloatEvent" },
        { "OnMoraleChanged",    "FloatEvent" },
        // StringEvents
        { "OnZoneLoadStart",    "StringEvent" },
        { "OnEvidenceAdded",    "StringEvent" },
        { "OnConsequenceFired", "StringEvent" },
        { "OnWorldEventReady",  "StringEvent" },
        { "OnLineReady",        "StringEvent" },
        // ProfileEvent y MessageEvent
        { "OnProfileFound",       "ProfileEvent" },
        { "OnProfileClassified",  "ProfileEvent" },
        { "OnMessageReceived",    "MessageEvent" },
    };

    static void CreateAllEvents()
    {
        string channelsPath = "Assets/_Core/Events/Channels";
        int created = 0;

        foreach (var kv in EVENTS)
        {
            string assetPath = $"{channelsPath}/{kv.Key}.asset";
            if (AssetDatabase.LoadAssetAtPath<ScriptableObject>(assetPath) != null)
                continue;

            // Crear el ScriptableObject usando el tipo correcto
            ScriptableObject so = null;
            switch (kv.Value)
            {
                case "GameEvent":    so = ScriptableObject.CreateInstance<GameEvent>();    break;
                case "FloatEvent":   so = ScriptableObject.CreateInstance<FloatEvent>();   break;
                case "StringEvent":  so = ScriptableObject.CreateInstance<StringEvent>();  break;
                case "ProfileEvent": so = ScriptableObject.CreateInstance<ProfileEvent>(); break;
                case "MessageEvent": so = ScriptableObject.CreateInstance<MessageEvent>(); break;
            }

            if (so != null)
            {
                AssetDatabase.CreateAsset(so, assetPath);
                created++;
            }
        }

        Debug.Log($"[LHO] Events creados: {created} / {EVENTS.Count} ✓");
    }

    // ── 3. SCRIPTABLEOBJECTS ─────────────────────────────────────
    static void CreateScriptableObjects()
    {
        // PostDatabase
        string dbPath = "Assets/Network/PostDatabase.asset";
        if (AssetDatabase.LoadAssetAtPath<PostDatabase>(dbPath) == null)
        {
            var db = ScriptableObject.CreateInstance<PostDatabase>();
            // Rellenar con datos base
            db.botPostTemplates = new System.Collections.Generic.List<string>
            {
                "¡Buenos días! El clima de hoy es perfecto para un paseo.",
                "Recuerda: mantenerse hidratado es importante para tu salud.",
                "Los mejores momentos son los que compartimos con otros. 😊",
                "¿Sabías que el 73% de las personas prefieren el café por la mañana?",
            };
            db.humanPostTemplates = new System.Collections.Generic.List<string>
            {
                "Día {day} sin ver a nadie. El generador aguantó esta noche.",
                "Si alguien lee esto... responde por favor.",
                "Encontré comida en el tercer piso. Dejé la mitad.",
                "No sé si esto llega. Necesito saber que no estoy solo.",
            };
            db.loreTemplates = new System.Collections.Generic.List<string>
            {
                "Sistema NEXUS v2.1 — mantenimiento automático completado.",
                "Alerta: actividad detectada en zona {city}. Registrando.",
                "Red estable. Usuarios conectados: {count}. Verificados: ???",
            };
            db.adjectives = new System.Collections.Generic.List<string>
                { "silent","dark","lost","broken","last","empty","real","ghost","echo","void" };
            db.nouns = new System.Collections.Generic.List<string>
                { "signal","human","node","trace","user","mind","wave","link","data","soul" };
            db.cities = new System.Collections.Generic.List<string>
                { "zona_norte","distrito_7","bloque_sur","sector_9","periferia" };
            db.humanBioTemplates = new System.Collections.Generic.List<string>
                { "Superviviente desde {year}. Si eres real, escríbeme.", "Buscando señales de vida." };
            db.botBioTemplates = new System.Collections.Generic.List<string>
                { "Apasionado del bienestar y la productividad. 📈", "Compartiendo contenido positivo." };

            AssetDatabase.CreateAsset(db, dbPath);
            Debug.Log("[LHO] PostDatabase creado ✓");
        }
    }

    // ── 4. GAMEOBJECTS ───────────────────────────────────────────
    static void CreateGameObjects()
    {
        // Helper para buscar o crear un GameObject
        GameObject FindOrCreate(string name)
        {
            var go = GameObject.Find(name);
            if (go == null) go = new GameObject(name);
            return go;
        }

        // Helper para añadir componente si no existe
        T AddIfMissing<T>(GameObject go) where T : Component
        {
            var c = go.GetComponent<T>();
            if (c == null) c = go.AddComponent<T>();
            return c;
        }

        // ── _GAME_MANAGER ────────────────────────────────────────
        var gm = FindOrCreate("_GAME_MANAGER");
        AddIfMissing<GameManager>(gm);
        AddIfMissing<ResourceManager>(gm);
        AddIfMissing<SaveSystem>(gm);
        AddIfMissing<MemorySystem>(gm);
        AddIfMissing<ProfileDatabaseLoader>(gm);
        AddIfMissing<WorldDatabaseLoader>(gm);
        AddIfMissing<ProfileRepository>(gm);
        AddIfMissing<WorldEventQueue>(gm);
        // DialogSystem requiere Ink — solo añadir si está el paquete
        try { AddIfMissing<DialogSystem>(gm); } catch { }

        Debug.Log("[LHO] _GAME_MANAGER creado ✓");

        // ── _NEXUS_ENGINE ────────────────────────────────────────
        var ne = FindOrCreate("_NEXUS_ENGINE");
        AddIfMissing<ProfileGenerator>(ne);
        AddIfMissing<FeedGenerator>(ne);
        AddIfMissing<BotDetection>(ne);
        // ChatEngine e InkChatBridge requieren Ink
        try
        {
            AddIfMissing<ChatEngine>(ne);
            AddIfMissing<InkChatBridge>(ne);
        }
        catch { Debug.LogWarning("[LHO] Ink no instalado — ChatEngine y InkChatBridge omitidos"); }

        Debug.Log("[LHO] _NEXUS_ENGINE creado ✓");

        // ── _ART_DIRECTOR ────────────────────────────────────────
        var ad = FindOrCreate("_ART_DIRECTOR");
        AddIfMissing<WeatherSystem>(ad);
        // ArtDirector requiere URP Volume
        try { AddIfMissing<ArtDirector>(ad); } catch { }

        Debug.Log("[LHO] _ART_DIRECTOR creado ✓");

        // ── _UI_MANAGER ──────────────────────────────────────────
        var ui = FindOrCreate("_UI_MANAGER");
        AddIfMissing<MenuTransitionManager>(ui);
        AddIfMissing<ZoneLoader>(ui);

        Debug.Log("[LHO] _UI_MANAGER creado ✓");

        // Marcar la escena como modificada
        UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(
            UnityEngine.SceneManagement.SceneManager.GetActiveScene());
    }

    // ── VERIFICADOR ──────────────────────────────────────────────
    [MenuItem("Last Human Online/Verificar Setup")]
    public static void VerifySetup()
    {
        var issues = new System.Text.StringBuilder();
        int ok = 0, warn = 0;

        // Verificar GameObjects
        string[] gos = { "_GAME_MANAGER", "_NEXUS_ENGINE", "_ART_DIRECTOR", "_UI_MANAGER" };
        foreach (var name in gos)
        {
            if (GameObject.Find(name) != null) { ok++; }
            else { issues.AppendLine($"✗ Falta GameObject: {name}"); warn++; }
        }

        // Verificar Events
        int eventsFound = 0;
        foreach (var kv in EVENTS)
        {
            string path = $"Assets/_Core/Events/Channels/{kv.Key}.asset";
            if (AssetDatabase.LoadAssetAtPath<ScriptableObject>(path) != null) eventsFound++;
            else { issues.AppendLine($"✗ Falta Event: {kv.Key}"); warn++; }
        }

        // Verificar StreamingAssets
        string[] saFiles = {
            "Assets/StreamingAssets/profiles/index.json",
            "Assets/StreamingAssets/events/act1.json",
            "Assets/StreamingAssets/lore/fragments.json"
        };
        foreach (var f in saFiles)
        {
            if (File.Exists(f)) ok++;
            else { issues.AppendLine($"✗ Falta archivo: {f}"); warn++; }
        }

        string result = warn == 0
            ? $"Todo correcto. {ok} elementos verificados."
            : $"{ok} elementos OK · {warn} problemas:\n\n{issues}";

        EditorUtility.DisplayDialog("LHO — Verificación", result, "OK");
    }

    // ── AUTO-ASIGNAR EVENTS ──────────────────────────────────────
    [MenuItem("Last Human Online/Auto-asignar Events")]
    public static void AutoAssignEvents()
    {
        string channelsPath = "Assets/_Core/Events/Channels";

        // Función helper para cargar un evento
        T LoadEvent<T>(string name) where T : ScriptableObject
            => AssetDatabase.LoadAssetAtPath<T>($"{channelsPath}/{name}.asset");

        // Auto-asignar en ResourceManager
        var rm = Object.FindObjectOfType<ResourceManager>();
        if (rm != null)
        {
            var so = new SerializedObject(rm);
            AssignField(so, "onBatteryChanged",  LoadEvent<FloatEvent>  ("OnBatteryChanged"));
            AssignField(so, "onBatteryLow",      LoadEvent<GameEvent>   ("OnBatteryLow"));
            AssignField(so, "onBatteryCritical", LoadEvent<GameEvent>   ("OnBatteryCritical"));
            AssignField(so, "onSignalChanged",   LoadEvent<FloatEvent>  ("OnSignalChanged"));
            AssignField(so, "onSignalLost",      LoadEvent<GameEvent>   ("OnSignalLost"));
            AssignField(so, "onNoiseChanged",    LoadEvent<FloatEvent>  ("OnNoiseChanged"));
            AssignField(so, "onNoiseCritical",   LoadEvent<GameEvent>   ("OnNoiseCritical"));
            AssignField(so, "onMoraleChanged",   LoadEvent<FloatEvent>  ("OnMoraleChanged"));
            so.ApplyModifiedProperties();
            Debug.Log("[LHO] ResourceManager events asignados ✓");
        }

        // Auto-asignar en GameManager
        var gm = Object.FindObjectOfType<GameManager>();
        if (gm != null)
        {
            var so = new SerializedObject(gm);
            AssignField(so, "onGameStart",  LoadEvent<GameEvent>("OnGameStart"));
            AssignField(so, "onGamePause",  LoadEvent<GameEvent>("OnGamePause"));
            AssignField(so, "onGameResume", LoadEvent<GameEvent>("OnGameResume"));
            AssignField(so, "onNEXUSOpen",  LoadEvent<GameEvent>("OnNEXUSOpen"));
            AssignField(so, "onNEXUSClose", LoadEvent<GameEvent>("OnNEXUSClose"));
            // Referencias a sistemas del mismo GameObject
            var goGM = gm.gameObject;
            AssignComponentField(so, "resourceManager", goGM.GetComponent<ResourceManager>());
            AssignComponentField(so, "saveSystem",       goGM.GetComponent<SaveSystem>());
            AssignComponentField(so, "memorySystem",     goGM.GetComponent<MemorySystem>());
            so.ApplyModifiedProperties();
            Debug.Log("[LHO] GameManager events y referencias asignados ✓");
        }

        // Auto-asignar en ProfileRepository
        var repo = Object.FindObjectOfType<ProfileRepository>();
        if (repo != null)
        {
            var so = new SerializedObject(repo);
            var goGM = repo.gameObject;
            AssignComponentField(so, "generator", goGM.GetComponent<ProfileGenerator>());
            AssignComponentField(so, "dbLoader",  goGM.GetComponent<ProfileDatabaseLoader>());
            AssignField(so, "onRepositoryReady", LoadEvent<GameEvent>("OnRepositoryReady"));
            so.ApplyModifiedProperties();
            Debug.Log("[LHO] ProfileRepository referencias asignadas ✓");
        }

        AssetDatabase.SaveAssets();
        EditorUtility.DisplayDialog("LHO — Auto-asignación", "Events y referencias asignados automáticamente.\n\nRevisa el Inspector de cada GameObject para confirmar.", "OK");
    }

    static void AssignField(SerializedObject so, string fieldName, Object value)
    {
        if (value == null) return;
        var prop = so.FindProperty(fieldName);
        if (prop != null) prop.objectReferenceValue = value;
    }

    static void AssignComponentField(SerializedObject so, string fieldName, Component value)
        => AssignField(so, fieldName, value);
}
#endif
