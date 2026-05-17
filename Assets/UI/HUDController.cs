using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class HUDController : MonoBehaviour
{
    [Header("Battery")]
    [SerializeField] Image batteryFill;
    [SerializeField] Image batteryIcon;
    [SerializeField] Color colorNormal   = new Color(0.24f, 0.87f, 0.63f);
    [SerializeField] Color colorLow      = new Color(0.87f, 0.44f, 0.24f);
    [SerializeField] Color colorCritical = new Color(0.87f, 0.25f, 0.25f);

    [Header("Signal bars")]
    [SerializeField] Image[] signalBars;

    [Header("Noise")]
    [SerializeField] Image        noiseFill;
    [SerializeField] CanvasGroup  noisePanel;

    [Header("Screen edge pulse")]
    [SerializeField] Image edgePulse;

    private Tweener pulseTween;

    "cm">// â”€â”€ Battery â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void OnBatteryChanged(float v)
    {
        batteryFill.fillAmount = v / 100f;
        batteryFill.color = v > 30f ? colorNormal : v > 10f ? colorLow : colorCritical;
    }

    public void OnBatteryLow()
    {
        batteryIcon.DOKill();
        batteryIcon.DOFade(0.3f, 0.8f).SetLoops(-1, LoopType.Yoyo);
    }

    public void OnBatteryCritical()
    {
        batteryIcon.DOKill();
        batteryIcon.DOFade(0.1f, 0.3f).SetLoops(-1, LoopType.Yoyo);
        edgePulse.color = colorCritical.WithAlpha(0.4f);
        pulseTween?.Kill();
        pulseTween = edgePulse.DOFade(0f, 0.5f).SetLoops(-1, LoopType.Yoyo);
    }

    "cm">// â”€â”€ Signal â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void OnSignalChanged(float v)
    {
        int bars = Mathf.RoundToInt(v / 100f * signalBars.Length);
        for (int i = 0; i "cm">// â”€â”€ Noise â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void OnNoiseChanged(float v)
    {
        noiseFill.fillAmount = v / 100f;
        noisePanel.alpha     = v > 20f ? Mathf.InverseLerp(20f, 100f, v) : 0f;
    }

    public void OnNoiseCritical()
    {
        edgePulse.color = colorLow.WithAlpha(0.5f);
        pulseTween?.Kill();
        pulseTween = edgePulse.DOFade(0f, 0.25f).SetLoops(4, LoopType.Yoyo);
        Handheld.Vibrate();
    }
}
