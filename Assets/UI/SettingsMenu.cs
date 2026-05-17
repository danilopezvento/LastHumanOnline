using UnityEngine;
using UnityEngine.UI;
using System;

public class SettingsMenu : MonoBehaviour
{
    [Header("Audio")]
    [SerializeField] Slider sliderMaster, sliderMusic, sliderSFX;

    [Header("Visual")]
    [SerializeField] Toggle toggleShake, toggleHaptic;
    [SerializeField] Slider sliderBrightness;

    [Header("Accesibilidad")]
    [SerializeField] Toggle toggleLargeText, toggleReduceGlitch;

    [SerializeField] Button btnBack, btnApply;

    private Action onBackCallback;

    void Start()
    {
        toggleReduceGlitch.onValueChanged.AddListener(v =>
        {
            foreach (var g in FindObjectsOfType()) g.SetReduced(v);
        });
        btnBack .onClick.AddListener(OnBack);
        btnApply.onClick.AddListener(Apply);
        Load();
    }

    public void Open(Action onBack = null) { onBackCallback = onBack; gameObject.SetActive(true); Load(); }

    void Apply()
    {
        PlayerPrefs.SetFloat("opt_master",  sliderMaster.value);
        PlayerPrefs.SetFloat("opt_music",   sliderMusic.value);
        PlayerPrefs.SetFloat("opt_sfx",     sliderSFX.value);
        PlayerPrefs.SetInt  ("opt_shake",   toggleShake.isOn       ? 1 : 0);
        PlayerPrefs.SetInt  ("opt_haptic",  toggleHaptic.isOn      ? 1 : 0);
        PlayerPrefs.SetFloat("opt_bright",  sliderBrightness.value);
        PlayerPrefs.SetInt  ("opt_large",   toggleLargeText.isOn   ? 1 : 0);
        PlayerPrefs.SetInt  ("opt_glitch",  toggleReduceGlitch.isOn? 1 : 0);
        PlayerPrefs.Save();
    }

    void Load()
    {
        sliderMaster     .value = PlayerPrefs.GetFloat("opt_master",  0.8f);
        sliderMusic      .value = PlayerPrefs.GetFloat("opt_music",   0.7f);
        sliderSFX        .value = PlayerPrefs.GetFloat("opt_sfx",     0.9f);
        toggleShake      .isOn  = PlayerPrefs.GetInt  ("opt_shake",   1) == 1;
        toggleHaptic     .isOn  = PlayerPrefs.GetInt  ("opt_haptic",  1) == 1;
        sliderBrightness .value = PlayerPrefs.GetFloat("opt_bright",  0.5f);
        toggleLargeText  .isOn  = PlayerPrefs.GetInt  ("opt_large",   0) == 1;
        toggleReduceGlitch.isOn = PlayerPrefs.GetInt  ("opt_glitch",  0) == 1;
    }

    void OnBack() { gameObject.SetActive(false); onBackCallback?.Invoke(); }
}
