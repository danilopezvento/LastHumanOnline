using UnityEngine;
using System.Collections;

public class WeatherSystem : MonoBehaviour
{
    public enum WeatherState { Clear, Drizzle, Rain, HeavyRain, Fog }

    [SerializeField] ParticleSystem              rainParticles;
    [SerializeField] AudioSource                 rainAudio;
    [SerializeField] UnityEngine.UI.Image        fogOverlay;
    [SerializeField] Color                       fogColor = new Color(0.1f, 0.13f, 0.12f, 0.4f);
    [SerializeField] float                       rainNoiseMask = -0.15f;
    [SerializeField] float                       minDuration   = 60f;
    [SerializeField] float                       maxDuration   = 300f;

    private ResourceManager res;

    void Start() { res = ServiceLocator.Get(); fogOverlay.color = Color.clear; StartCoroutine(Cycle()); }

    public void SetWeather(WeatherState s, float t = 3f) => StartCoroutine(Transition(s, t));

    IEnumerator Transition(WeatherState s, float dur)
    {
        var em = rainParticles.emission;
        float r0 = em.rateOverTime.constant, v0 = rainAudio.volume, f0 = fogOverlay.color.a;
        float r1 = Rate(s), v1 = Vol(s), f1 = Fog(s);
        for (float t = 0; t = WeatherState.Rain) res.AddNoise(rainNoiseMask);
    }

    IEnumerator Cycle()
    {
        while (true)
        {
            yield return new WaitForSeconds(Random.Range(minDuration, maxDuration));
            float r = Random.value;
            SetWeather(r  s switch { WeatherState.Drizzle => 50f,  WeatherState.Rain => 200f,  WeatherState.HeavyRain => 600f, _ => 0f };
    float Vol (WeatherState s) => s switch { WeatherState.Drizzle => 0.2f, WeatherState.Rain => 0.5f,  WeatherState.HeavyRain => 0.8f, _ => 0f };
    float Fog (WeatherState s) => s switch { WeatherState.Fog     => 0.55f,WeatherState.Rain => 0.15f, WeatherState.HeavyRain => 0.25f, _ => 0f };
}
