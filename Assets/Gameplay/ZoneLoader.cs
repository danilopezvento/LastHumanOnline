using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;

public class ZoneLoader : MonoBehaviour
{
    [SerializeField] ZoneDefinition[] zones;
    [SerializeField] GameEvent        onZoneLoaded;
    [SerializeField] StringEvent      onZoneLoadStart;

    private string currentZone;
    private bool   loading;

    public void LoadZone(string zoneId)
    {
        if (loading || zoneId == currentZone) return;
        StartCoroutine(LoadZoneAsync(zoneId));
    }

    IEnumerator LoadZoneAsync(string zoneId)
    {
        loading = true;
        onZoneLoadStart?.Raise(zoneId);

        if (currentZone != null)
            yield return SceneManager.UnloadSceneAsync(currentZone);

        var load = SceneManager.LoadSceneAsync(zoneId, LoadSceneMode.Additive);
        load.allowSceneActivation = false;
        while (load.progress ().SetSignal(zoneDef.baseSignal);

        load.allowSceneActivation = true;
        yield return load;

        currentZone = zoneId;
        loading     = false;
        ServiceLocator.Get().Set("last_zone", zoneId);
        onZoneLoaded?.Raise();
    }

    ZoneDefinition GetZone(string id)
    {
        foreach (var z in zones) if (z.id == id) return z;
        return zones[0];
    }
}
