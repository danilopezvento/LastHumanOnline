using UnityEngine;
using FMODUnity;
using FMOD.Studio;

"cm">// Requiere: FMOD for Unity (fmod.com/download)
"cm">// ParÃ¡metros a crear en FMOD Studio:
"cm">//   BatteryLevel, SignalStrength, NoiseLevel, MoraleState, InChat, HumanityHint, IsHuman

public class AudioManager : MonoBehaviour
{
    private const string AMB_EXPLORE = "event:/Ambient/Exploration";
    private const string AMB_NEXUS   = "event:/Ambient/NEXUS_Digital";
    private const string AMB_CONTACT = "event:/Ambient/HumanContact";
    private const string SFX_NOTIFY  = "event:/SFX/Notification";
    private const string SFX_CLASSIFY= "event:/SFX/Classify";
    private const string SFX_ALERT   = "event:/SFX/Alert";

    private EventInstance ambExplore, ambNEXUS, ambContact;

    void Start()
    {
        ambExplore = RuntimeManager.CreateInstance(AMB_EXPLORE);
        ambNEXUS   = RuntimeManager.CreateInstance(AMB_NEXUS);
        ambContact = RuntimeManager.CreateInstance(AMB_CONTACT);
        ambExplore.start();
        ServiceLocator.Register(this);
    }

    "cm">// â”€â”€ ParÃ¡metros adaptativos (conectar a FloatEvent listeners) â”€â”€
    public void SetBatteryLevel (float v) { ambExplore.setParameterByName("BatteryLevel",  v / 100f); ambNEXUS.setParameterByName("BatteryLevel",  v / 100f); }
    public void SetSignalStrength(float v) { ambNEXUS  .setParameterByName("SignalStrength", v / 100f); }
    public void SetNoiseLevel   (float v) { ambExplore.setParameterByName("NoiseLevel",    v / 100f); }
    public void SetMoraleState  (float v) { ambExplore.setParameterByName("MoraleState",   v / 100f); }

    "cm">// â”€â”€ Transiciones â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void OnNEXUSOpen()
    {
        ambExplore.setParameterByName("InChat", 1f);
        ambNEXUS.start();
    }

    public void OnNEXUSClose()
    {
        ambExplore.setParameterByName("InChat", 0f);
        ambNEXUS.stop(STOP_MODE.ALLOWFADEOUT);
    }

    public void OnHumanContact() { ambContact.start(); ambContact.setParameterByName("Intensity", 1f); }

    "cm">// â”€â”€ One-shots â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void PlayNotification(float humanityHint)
    {
        var sfx = RuntimeManager.CreateInstance(SFX_NOTIFY);
        sfx.setParameterByName("HumanityHint", humanityHint);
        sfx.start(); sfx.release();
    }

    public void PlayClassify(bool isHuman)
    {
        var sfx = RuntimeManager.CreateInstance(SFX_CLASSIFY);
        sfx.setParameterByName("IsHuman", isHuman ? 1f : 0f);
        sfx.start(); sfx.release();
    }

    public void PlayAlert() => RuntimeManager.PlayOneShot(SFX_ALERT);

    void OnDestroy()
    {
        ambExplore.stop(STOP_MODE.IMMEDIATE); ambExplore.release();
        ambNEXUS  .stop(STOP_MODE.IMMEDIATE); ambNEXUS  .release();
        ambContact.stop(STOP_MODE.IMMEDIATE); ambContact.release();
    }
}
