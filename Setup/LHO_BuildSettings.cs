// ================================================================
// LHO_BuildSettings.cs
// Configura automáticamente todos los Player Settings de Android
// COPIAR EN: Assets/_Core/Editor/LHO_BuildSettings.cs
// ================================================================

#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System.IO;

public class LHO_BuildSettings : EditorWindow
{
    [MenuItem("Last Human Online/Configurar Android Build")]
    public static void ConfigureAndroid()
    {
        // Player Settings
        PlayerSettings.companyName          = "IndieStudio";
        PlayerSettings.productName          = "Last Human Online";
        PlayerSettings.applicationIdentifier = "com.indiestudio.lasthumanonline";

        // Android específico
        PlayerSettings.Android.minSdkVersion    = AndroidSdkVersions.AndroidApiLevel28;
        PlayerSettings.Android.targetSdkVersion = AndroidSdkVersions.AndroidApiLevelAuto;

        // IL2CPP para mejor rendimiento en Android
        PlayerSettings.SetScriptingBackend(BuildTargetGroup.Android, ScriptingImplementation.IL2CPP);
        PlayerSettings.Android.targetArchitectures = AndroidArchitecture.ARM64 | AndroidArchitecture.ARMv7;

        // Graphics
        var graphicsApis = new UnityEngine.Rendering.GraphicsDeviceType[]
        {
            UnityEngine.Rendering.GraphicsDeviceType.Vulkan,
            UnityEngine.Rendering.GraphicsDeviceType.OpenGLES3,
        };
        PlayerSettings.SetGraphicsAPIs(BuildTarget.Android, graphicsApis);
        PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.Android, false);

        // Orientación
        PlayerSettings.defaultInterfaceOrientation = UIOrientation.Portrait;

        // Calidad para móviles medios
        QualitySettings.SetQualityLevel(2); // Medium
        QualitySettings.shadowDistance = 15f;
        QualitySettings.particleRaycastBudget = 64;
        QualitySettings.vSyncCount = 1;

        // Target FPS
        Application.targetFrameRate = 60;

        AssetDatabase.SaveAssets();

        EditorUtility.DisplayDialog("Android configurado",
            "✓ Company Name: IndieStudio\n" +
            "✓ Product Name: Last Human Online\n" +
            "✓ Bundle ID: com.indiestudio.lasthumanonline\n" +
            "✓ Min SDK: Android 9 (API 28)\n" +
            "✓ Backend: IL2CPP\n" +
            "✓ Arquitecturas: ARM64 + ARMv7\n" +
            "✓ Graphics: Vulkan + OpenGL ES 3.0\n\n" +
            "Listo para hacer Build.",
            "OK");

        Debug.Log("[LHO] Android Build configurado ✓");
    }

    [MenuItem("Last Human Online/Build APK rápido")]
    public static void BuildAPK()
    {
        string buildPath = EditorUtility.SaveFilePanel(
            "Guardar APK", "", "LastHumanOnline", "apk");

        if (string.IsNullOrEmpty(buildPath)) return;

        var scenes = new string[] { "Assets/Scenes/MainMenu.unity", "Assets/Scenes/Game.unity" };

        // Filtrar solo escenas que existen
        var existingScenes = new System.Collections.Generic.List<string>();
        foreach (var s in scenes)
            if (File.Exists(s)) existingScenes.Add(s);

        if (existingScenes.Count == 0)
        {
            // Usar escena activa
            existingScenes.Add(UnityEngine.SceneManagement.SceneManager.GetActiveScene().path);
        }

        BuildPipeline.BuildPlayer(
            existingScenes.ToArray(),
            buildPath,
            BuildTarget.Android,
            BuildOptions.None
        );

        Debug.Log($"[LHO] Build completado: {buildPath}");
    }
}
#endif
