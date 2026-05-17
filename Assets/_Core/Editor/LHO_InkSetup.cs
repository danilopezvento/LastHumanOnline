// ================================================================
// LHO_InkSetup.cs
// Configura los archivos .ink para que Unity los compile
// COPIAR EN: Assets/_Core/Editor/LHO_InkSetup.cs
// ================================================================

#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System.IO;

public class LHO_InkSetup : EditorWindow
{
    [MenuItem("Last Human Online/Configurar archivos Ink")]
    public static void SetupInk()
    {
        // Los archivos .ink en StreamingAssets/dialog/ se compilan
        // automáticamente por el paquete Ink Unity Integration
        // al detectarlos en el proyecto.

        string dialogPath = "Assets/StreamingAssets/dialog";

        if (!Directory.Exists(dialogPath))
        {
            EditorUtility.DisplayDialog("Error",
                $"La carpeta {dialogPath} no existe.\n" +
                "Asegúrate de haber copiado los archivos .ink del ZIP.",
                "OK");
            return;
        }

        var inkFiles = Directory.GetFiles(dialogPath, "*.ink");

        if (inkFiles.Length == 0)
        {
            EditorUtility.DisplayDialog("Error",
                "No se encontraron archivos .ink en Assets/StreamingAssets/dialog/\n\n" +
                "Copia los archivos del ZIP (carpeta InkCompiled) a esa carpeta.",
                "OK");
            return;
        }

        // Forzar reimport para que Ink los compile
        foreach (var f in inkFiles)
        {
            AssetDatabase.ImportAsset(f, ImportAssetOptions.ForceUpdate);
        }

        AssetDatabase.Refresh();

        EditorUtility.DisplayDialog("Ink configurado",
            $"✓ {inkFiles.Length} archivos .ink encontrados y configurados.\n\n" +
            "El paquete Ink Unity Integration los compilará automáticamente.\n\n" +
            "Los archivos .json compilados aparecerán en la misma carpeta.",
            "OK");

        Debug.Log($"[LHO] {inkFiles.Length} archivos .ink configurados para compilación ✓");
    }
}
#endif
