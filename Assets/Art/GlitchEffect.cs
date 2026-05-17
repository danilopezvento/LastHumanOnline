using UnityEngine;
using UnityEngine.UI;
using System.Collections;

[RequireComponent(typeof(RawImage))]
public class GlitchEffect : MonoBehaviour
{
    [SerializeField] float  defaultIntensity = 0.15f;
    [SerializeField] float  defaultDuration  = 0.2f;
    [SerializeField] bool   playOnEnable;
    [SerializeField] string propIntensity    = "_GlitchIntensity";
    [SerializeField] string propScanline     = "_ScanlineOffset";
    [SerializeField] string propRGB          = "_RGBOffset";

    private RawImage  img;
    private Material  mat;
    private bool      reduced;
    private Coroutine active;

    void Awake() { img = GetComponent(); mat = new Material(img.material); img.material = mat; }
    void OnEnable() { if (playOnEnable) TriggerGlitch(); }

    public void TriggerGlitch(float intensity = -1f, float duration = -1f)
    {
        if (reduced) return;
        if (active != null) StopCoroutine(active);
        active = StartCoroutine(Run(
            intensity < 0 ? defaultIntensity : intensity,
            duration  < 0 ? defaultDuration  : duration));
    }

    public void SetReduced(bool r) { reduced = r; if (r) Reset(); }

    IEnumerator Run(float intensity, float duration)
    {
        for (float e = 0; e < duration; )
        {
            float s = intensity * Mathf.Sin(e / duration * Mathf.PI);
            mat.SetFloat (propIntensity, s);
            mat.SetFloat (propScanline,  Random.Range(-s, s) * 0.05f);
            mat.SetVector(propRGB, new Vector4(
                Random.Range(-s, s) * 0.008f,
                Random.Range(-s, s) * 0.004f, 0, 0));
            float w = Random.Range(0.016f, 0.05f);
            yield return new WaitForSeconds(w);
            e += w;
        }
        Reset();
        active = null;
    }

    void Reset()
    {
        mat.SetFloat (propIntensity, 0f);
        mat.SetFloat (propScanline,  0f);
        mat.SetVector(propRGB, Vector4.zero);
    }

    void OnDestroy() { if (mat) Destroy(mat); }
}
