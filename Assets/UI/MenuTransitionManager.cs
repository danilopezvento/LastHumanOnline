using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;

public class MenuTransitionManager : MonoBehaviour
{
    [SerializeField] Image     fadeOverlay;
    [SerializeField] float     fadeInDuration  = 0.5f;
    [SerializeField] float     fadeOutDuration = 0.35f;
    [SerializeField] GameEvent onFadeInComplete;
    [SerializeField] GameEvent onFadeOutComplete;

    [Header("Act label (opcional)")]
    [SerializeField] Text  actLabel;
    [SerializeField] float actLabelDuration = 2f;

    void Awake() { fadeOverlay.color = Color.black; fadeOverlay.raycastTarget = true; }

    public void TriggerFadeIn()  => StartCoroutine(FadeIn());
    public void TriggerFadeOut() => StartCoroutine(FadeOut());
    public void FadeInThen (System.Action cb) => StartCoroutine(FadeIn(cb));
    public void FadeOutThen(System.Action cb) => StartCoroutine(FadeOut(cb));

    IEnumerator FadeIn(System.Action cb = null)
    {
        fadeOverlay.raycastTarget = true;
        yield return fadeOverlay.DOFade(0f, fadeInDuration).WaitForCompletion();
        fadeOverlay.raycastTarget = false;
        cb?.Invoke();
        onFadeInComplete?.Raise();
    }

    IEnumerator FadeOut(System.Action cb = null)
    {
        fadeOverlay.raycastTarget = true;
        yield return fadeOverlay.DOFade(1f, fadeOutDuration).WaitForCompletion();
        cb?.Invoke();
        onFadeOutComplete?.Raise();
    }

    public void ShowActLabel(string text)
    {
        if (!actLabel) return;
        actLabel.text  = text;
        actLabel.color = new Color(1, 1, 1, 0);
        actLabel.gameObject.SetActive(true);
        DOTween.Sequence()
            .Append(actLabel.DOFade(1f, 0.5f))
            .AppendInterval(actLabelDuration)
            .Append(actLabel.DOFade(0f, 0.5f))
            .OnComplete(() => actLabel.gameObject.SetActive(false));
    }
}
