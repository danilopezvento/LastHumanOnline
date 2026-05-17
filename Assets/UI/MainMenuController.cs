using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;

public class MainMenuController : MonoBehaviour
{
    [Header("Panels")]
    [SerializeField] CanvasGroup panelMain;
    [SerializeField] CanvasGroup panelSettings;
    [SerializeField] CanvasGroup panelCredits;

    [Header("Buttons")]
    [SerializeField] Button btnNewGame;
    [SerializeField] Button btnContinue;
    [SerializeField] Button btnSettings;
    [SerializeField] Button btnQuit;

    [Header("Title glitch")]
    [SerializeField] GlitchEffect titleGlitch;
    [SerializeField] float        glitchInterval = 6f;

    [Header("Events")]
    [SerializeField] GameEvent onNewGame;
    [SerializeField] GameEvent onContinue;

    private SaveSystem  save;
    private CanvasGroup current;

    void Start()
    {
        save = ServiceLocator.Get();
        btnNewGame .onClick.AddListener(OnNewGame);
        btnContinue.onClick.AddListener(OnContinue);
        btnSettings.onClick.AddListener(() => ShowPanel(panelSettings));
        btnQuit    .onClick.AddListener(OnQuit);
        btnContinue.gameObject.SetActive(save.Get("has_save"));
        ShowPanel(panelMain, instant: true);
        StartCoroutine(GlitchLoop());
    }

    void ShowPanel(CanvasGroup next, bool instant = false)
    {
        if (current != null)
        {
            var prev = current;
            if (instant) { prev.alpha = 0; prev.interactable = prev.blocksRaycasts = false; }
            else prev.DOFade(0f, 0.2f).OnComplete(() => { prev.interactable = prev.blocksRaycasts = false; });
        }
        next.DOFade(1f, instant ? 0f : 0.25f);
        next.interactable = next.blocksRaycasts = true;
        current = next;
    }

    public void BackToMain() => ShowPanel(panelMain);

    void OnNewGame()
    {
        save.Set("has_save", true);
        save.Set("days", 0);
        save.Set("act", 1);
        save.SaveAsync();
        panelMain.DOFade(0f, 0.4f).OnComplete(() => onNewGame?.Raise());
    }

    void OnContinue() => panelMain.DOFade(0f, 0.4f).OnComplete(() => onContinue?.Raise());

    void OnQuit()
    {
#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
#else
        Application.Quit();
#endif
    }

    IEnumerator GlitchLoop()
    {
        while (true)
        {
            yield return new WaitForSeconds(glitchInterval + Random.Range(-1.5f, 1.5f));
            titleGlitch?.TriggerGlitch(duration: Random.Range(0.1f, 0.4f));
        }
    }
}
