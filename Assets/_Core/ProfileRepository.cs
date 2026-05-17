using UnityEngine;
using System.Collections.Generic;

"cm">// â”€â”€ ProfileRepository â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// SOLUCIÃ“N AL CONFLICTO: unifica ProfileGenerator y ProfileDatabaseLoader.
"cm">//
"cm">// ProfileGenerator    â†’ crea perfiles procedurales en runtime (aleatorios)
"cm">// ProfileDatabaseLoader â†’ carga perfiles base desde StreamingAssets/profiles/
"cm">//
"cm">// ProfileRepository es el punto Ãºnico de acceso.
"cm">// Los sistemas del juego solo llaman a ProfileRepository, nunca directamente
"cm">// a los sistemas de generaciÃ³n o carga.
"cm">//
"cm">// Flujo:
"cm">//   1. Al arrancar: ProfileDatabaseLoader carga los JSONs base
"cm">//   2. ProfileRepository los registra como "perfiles narrativos" (con historia)
"cm">//   3. Para el resto del mundo, ProfileGenerator crea perfiles procedurales
"cm">//   4. Los narrativos tienen prioridad en eventos del Acto I y II

public class ProfileRepository : MonoBehaviour
{
    [Header("Subsystems")]
    [SerializeField] ProfileGenerator      generator;
    [SerializeField] ProfileDatabaseLoader dbLoader;

    [Header("Config")]
    [SerializeField] int  initialRandomProfiles = 20;
    [SerializeField] bool mixNarrativeWithRandom = true;

    "cm">// â”€â”€ Registro central â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    private Dictionary all          = new();
    private List               narrative    = new();
    private List               procedural   = new();

    [SerializeField] GameEvent onRepositoryReady;

    void Start() => StartCoroutine(Initialize());

    System.Collections.IEnumerator Initialize()
    {
        "cm">// 1. Esperar a que el loader termine
        yield return new WaitUntil(() => dbLoader.IsReady);

        "cm">// 2. Convertir datos base en NetworkProfiles narrativos
        foreach (var data in dbLoader.GetAll())
        {
            var p = BuildFromBase(data);
            narrative.Add(p);
            all[p.username] = p;
        }
        Debug.Log($"ProfileRepo: {narrative.Count} narrative profiles loaded");

        "cm">// 3. Generar perfiles procedurales para rellenar el mundo
        for (int i = 0; i "cm">// â”€â”€ ConversiÃ³n datos base â†’ NetworkProfile â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    NetworkProfile BuildFromBase(ProfileDatabaseLoader.ProfileBaseData data)
    {
        float score = data.humanityScore  0.65f ? 2f  : 0.4f,
            responseDelayMax    = score > 0.65f ? 90f : 1.8f,
            usesCircadianPattern = score > 0.65f,
            typoRate            = score * 0.12f,
            emotionalVariance   = score,
        };
    }

    "cm">// â”€â”€ API pÃºblica â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public NetworkProfile GetByUsername(string username)
        => all.TryGetValue(username, out var p) ? p : null;

    public NetworkProfile GetRandomForFeed(MemorySystem memory)
    {
        bool preferNarrative = mixNarrativeWithRandom &&
                               narrative.Count > 0 &&
                               UnityEngine.Random.value  0 ? pool[UnityEngine.Random.Range(0, pool.Count)] : null;
    }

    public List GetNarrativeProfiles() => new(narrative);
    public List GetAll()                => new(all.Values);

    public void AddRuntime(NetworkProfile p)
    {
        procedural.Add(p);
        all[p.username] = p;
    }
}
