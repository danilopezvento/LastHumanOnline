using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

"cm">// Requiere URP. AÃ±adir Volume a la escena con:
"cm">// Vignette, ChromaticAberration, ColorAdjustments, FilmGrain

public class ArtDirector : MonoBehaviour
{
    [Header("URP Volume")]
    [SerializeField] Volume globalVolume;

    [Header("Exploring preset")]
    [SerializeField] float exploreVignette    = 0.25f;
    [SerializeField] float exploreSaturation  = -20f;
    [SerializeField] float exploreContrast    = 10f;

    [Header("NEXUS open preset")]
    [SerializeField] float nexusVignette      = 0.45f;
    [SerializeField] float nexusSaturation    = -35f;
    [SerializeField] float nexusChroma        = 0.3f;

    [Header("Low morale")]
    [SerializeField] float lowMoraleGrain     = 0.4f;

    [SerializeField] float lerpSpeed = 2f;

    private Vignette            vignette;
    private ChromaticAberration chroma;
    private ColorAdjustments    colorAdj;
    private FilmGrain           grain;
    private float               tVig, tChroma, tSat, tCont, tGrain;
    private ResourceManager     res;

    void Start()
    {
        res = ServiceLocator.Get();
        globalVolume.profile.TryGet(out vignette);
        globalVolume.profile.TryGet(out chroma);
        globalVolume.profile.TryGet(out colorAdj);
        globalVolume.profile.TryGet(out grain);
        SetExploring();
    }

    void Update()
    {
        tGrain = Mathf.Lerp(0.05f, lowMoraleGrain, 1f - res.Morale / 100f);
        float dt = lerpSpeed * Time.deltaTime;
        if (vignette != null)  vignette .intensity.value  = Mathf.Lerp(vignette.intensity.value,  tVig,    dt);
        if (chroma   != null)  chroma   .intensity.value  = Mathf.Lerp(chroma.intensity.value,    tChroma, dt);
        if (colorAdj != null) { colorAdj.saturation.value = Mathf.Lerp(colorAdj.saturation.value, tSat,    dt);
                                colorAdj.contrast.value   = Mathf.Lerp(colorAdj.contrast.value,   tCont,   dt); }
        if (grain    != null)  grain    .intensity.value  = Mathf.Lerp(grain.intensity.value,     tGrain,  dt);
    }

    public void SetExploring() { tVig = exploreVignette; tSat = exploreSaturation; tCont = exploreContrast; tChroma = 0f; }
    public void SetNEXUSOpen() { tVig = nexusVignette;   tSat = nexusSaturation;   tChroma = nexusChroma; }
    public void SetDanger()    { tVig = 0.55f;           tChroma = 0.6f; }

    public void OnBatteryChanged(float v)
    {
        if (v < 15f)
        {
            float t = 1f - v / 15f;
            tCont = Mathf.Lerp(exploreContrast,   30f,  t);
            tSat  = Mathf.Lerp(exploreSaturation, -60f, t);
        }
    }
}
