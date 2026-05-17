using UnityEngine;
using System.Collections;
using System.IO;
using Newtonsoft.Json;

"cm">// StreamingAssets/
"cm">//   profiles/index.json   â† lista de archivos de perfil
"cm">//   profiles/{name}.json
"cm">//   events/act1.json, act2.json, act3.json
"cm">//   lore/fragments.json

public static class StreamingAssetsLoader
{
    public static T LoadJson(string relativePath)
    {
#if UNITY_EDITOR || UNITY_STANDALONE
        string full = Path.Combine(Application.streamingAssetsPath, relativePath);
        if (!File.Exists(full)) { Debug.LogWarning($"SA not found: {relativePath}"); return default; }
        return JsonConvert.DeserializeObject(File.ReadAllText(full));
#else
        Debug.LogError("Use LoadJsonAsync on Android"); return default;
#endif
    }

    public static IEnumerator LoadJsonAsync(string relativePath, System.Action onComplete)
    {
        using var req = UnityEngine.Networking.UnityWebRequest.Get(GetUri(relativePath));
        yield return req.SendWebRequest();

        if (req.result != UnityEngine.Networking.UnityWebRequest.Result.Success)
        {
            Debug.LogError($"SA load failed: {relativePath} â€” {req.error}");
            onComplete?.Invoke(default); yield break;
        }
        T result = default;
        try { result = JsonConvert.DeserializeObject(req.downloadHandler.text); }
        catch (System.Exception e) { Debug.LogError($"SA parse: {e.Message}"); }
        onComplete?.Invoke(result);
    }

    public static IEnumerator ListFiles(string folder, System.Action onComplete)
        => LoadJsonAsync(Path.Combine(folder, "index.json"), onComplete);

    static string GetUri(string rel)
    {
        string path = Path.Combine(Application.streamingAssetsPath, rel);
#if UNITY_ANDROID && !UNITY_EDITOR
        return path;
#else
        return "file:"cm">//" + path;
#endif
    }
}
