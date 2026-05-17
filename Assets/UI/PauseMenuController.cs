using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class PauseMenuController : MonoBehaviour
{
    [SerializeField] CanvasGroup  overlay;
    [SerializeField] CanvasGroup  panel;
    [SerializeField] Button       btnResume;
    [SerializeField] Button       btnSettings;
    [SerializeField] Button       btnMainMenu;
    [SerializeField] SettingsMenu settingsMenu;
    [SerializeField] GameEvent    onResume;
    [SerializeField] GameEvent    onReturnToMenu;

    private bool isOpen;

    void Start()
    {
        btnResume  .onClick.AddListener(Close);
        btnSettings.onClick.AddListener(OpenSettings);
        btnMainMenu.onClick.AddListener(ReturnToMenu);
        overlay.alpha = 0;
        overlay.interactable = overlay.blocksRaycasts = false;
    }

    void Update() { if (Input.GetKeyDown(KeyCode.Escape)) { if (isOpen) Close(); else Open(); } }

    public void Open()
    {
        isOpen = true; Time.timeScale = 0f;
        overlay.interactable = overlay.blocksRaycasts = true;
        overlay.DOFade(0.75f, 0.2f).SetUpdate(true);
        panel  .DOFade(1f,    0.2f).SetUpdate(true);
        panel.transform.DOScale(1f, 0.2f).From(0.92f).SetUpdate(true);
    }

    public void Close()
    {
        isOpen = false; Time.timeScale = 1f;
        overlay.DOFade(0f, 0.2f).SetUpdate(true)
            .OnComplete(() => { overlay.interactable = overlay.blocksRaycasts = false; });
        panel.DOFade(0f, 0.15f).SetUpdate(true);
        onResume?.Raise();
    }

    void OpenSettings()
    {
        panel.gameObject.SetActive(false);
        settingsMenu.Open(onBack: () => panel.gameObject.SetActive(true));
    }

    void ReturnToMenu() { Time.timeScale = 1f; onReturnToMenu?.Raise(); }
}
