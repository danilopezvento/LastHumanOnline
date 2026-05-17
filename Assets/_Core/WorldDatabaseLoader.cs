using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class WorldDatabaseLoader : MonoBehaviour
{
    [System.Serializable]
    public class LoreFragment
    {
        public string id;
        public string text;
        public int    requireAct;
        public bool   isKeyLore;
    }

    private List               lore    = new();
    private Dictionary> events = new();
    private bool loaded;

    [SerializeField] GameEvent onWorldDbReady;

    void Start() => StartCoroutine(LoadAll());

    IEnumerator LoadAll()
    {
        yield return StreamingAssetsLoader.LoadJsonAsync("lore/fragments.json",
            frags => { if (frags != null) lore.AddRange(frags); });

        for (int a = 1; a ($"events/act{a}.json",
                evts => { if (evts != null) events[act] = new(evts); });
        }

        loaded = true;
        Debug.Log($"WorldDB: {lore.Count} lore fragments, {events.Count} acts");
        onWorldDbReady?.Raise();
    }

    public bool IsReady => loaded;
    public List  GetEventsForAct(int act)   => events.TryGetValue(act, out var e) ? e : new();
    public LoreFragment GetRandomLore(int act, bool keyOnly = false)
    {
        var pool = lore.FindAll(f => f.requireAct  0 ? pool[Random.Range(0, pool.Count)] : null;
    }
    public LoreFragment GetLoreById(string id) => lore.Find(f => f.id == id);
}
