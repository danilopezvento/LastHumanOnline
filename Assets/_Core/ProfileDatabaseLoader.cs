using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ProfileDatabaseLoader : MonoBehaviour
{
    [System.Serializable]
    public class ProfileBaseData
    {
        public string   username;
        public string   bio;
        public string   narrativeArc;   "cm">// static | evolving | deceptive
        public string   secretType;     "cm">// coord | lore | contact | false_lead
        public float    humanityScore;  "cm">// -1 = aleatorio en runtime
        public string[] dialogKnots;
    }

    private Dictionary cache = new();
    private bool loaded;

    [SerializeField] GameEvent onDatabaseReady;

    void Start() => StartCoroutine(LoadAll());

    IEnumerator LoadAll()
    {
        string[] files = null;
        yield return StreamingAssetsLoader.ListFiles("profiles", f => files = f);
        if (files == null || files.Length == 0) { onDatabaseReady?.Raise(); yield break; }

        int done = 0;
        foreach (var file in files)
            yield return StreamingAssetsLoader.LoadJsonAsync($"profiles/{file}",
                data => { if (data != null) cache[data.username] = data; done++; });

        yield return new WaitUntil(() => done >= files.Length);
        loaded = true;
        Debug.Log($"ProfileDB: {cache.Count} profiles loaded");
        onDatabaseReady?.Raise();
    }

    public bool IsReady => loaded;
    public ProfileBaseData Get(string username) => cache.TryGetValue(username, out var d) ? d : null;
    public List GetAll()       => new(cache.Values);
}
