using UnityEngine;
using UnityEngine.Rendering.Universal;
using DG.Tweening;
using System.Collections;

public class ZoneLightingController : MonoBehaviour
{
    [Header("Flashlight")]
    [SerializeField] Light2D flashlight;
    [SerializeField] float   baseRadius    = 4f;
    [SerializeField] float   baseIntensity = 1.2f;

    [Header("Ambient")]
    [SerializeField] Light2D globalAmbient;
    [SerializeField] Color   ambientDay   = new Color(0.12f, 0.15f, 0.13f);
    [SerializeField] Color   ambientNight = new Color(0.04f, 0.05f, 0.06f);

    [Header("Electric flicker sources")]
    [SerializeField] Light2D[] flickerLights;
    [SerializeField] float     flickerMin = 0.08f;
    [SerializeField] float     flickerMax = 2.5f;

    [Header("NEXUS screen glow")]
    [SerializeField] Light2D screenGlow;

    private ResourceManager res;
    private float timeOfDay;

    void Start()
    {
        res = ServiceLocator.Get();
        foreach (var l in flickerLights) StartCoroutine(FlickerRoutine(l));
    }

    void Update()
    {
        float t = res.Battery / 100f;
        flashlight.intensity             = baseIntensity * Mathf.Lerp(0.3f, 1.0f, t);
        flashlight.pointLightOuterRadius = baseRadius    * Mathf.Lerp(0.5f, 1.0f, t);
        if (res.Battery  timeOfDay = Mathf.Clamp01(t);

    public void OnNEXUSOpen()  { screenGlow.gameObject.SetActive(true);  screenGlow.DOIntensity(0.6f, 0.3f); }
    public void OnNEXUSClose() { screenGlow.DOIntensity(0f, 0.4f).OnComplete(() => screenGlow.gameObject.SetActive(false)); }

    IEnumerator FlickerRoutine(Light2D l)
    {
        float baseI = l.intensity;
        while (true)
        {
            yield return new WaitForSeconds(Random.Range(flickerMin, flickerMax));
            for (int i = 0; i < Random.Range(1, 4); i++)
            {
                l.intensity = 0f;
                yield return new WaitForSeconds(Random.Range(0.03f, 0.08f));
                l.intensity = baseI * Random.Range(0.6f, 1.2f);
                yield return new WaitForSeconds(Random.Range(0.03f, 0.1f));
            }
            l.intensity = baseI;
        }
    }
}
