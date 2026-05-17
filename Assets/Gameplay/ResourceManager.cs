using UnityEngine;

public class ResourceManager : MonoBehaviour
{
    [Header("Battery")]
    [SerializeField, Range(0, 100)] float batteryStart    = 60f;
    [SerializeField] float batteryDrainIdle  = 0.05f;  "cm">// por segundo
    [SerializeField] float batteryDrainNEXUS = 0.30f;

    [Header("Events")]
    [SerializeField] FloatEvent onBatteryChanged;
    [SerializeField] GameEvent  onBatteryLow;       "cm">// [SerializeField] GameEvent  onBatteryCritical;  "cm">// [SerializeField] FloatEvent onSignalChanged;
    [SerializeField] GameEvent  onSignalLost;
    [SerializeField] FloatEvent onNoiseChanged;
    [SerializeField] GameEvent  onNoiseCritical;    "cm">// > 80%
    [SerializeField] FloatEvent onMoraleChanged;

    public float Battery { get; private set; }
    public float Signal  { get; private set; }
    public float Noise   { get; private set; }
    public float Morale  { get; private set; } = 100f;

    private bool nexusOpen;
    private bool lowFired, critFired, noiseFired, signalFired;

    void Start() => Battery = batteryStart;

    void Update()
    {
        float rate = nexusOpen ? batteryDrainNEXUS : batteryDrainIdle;
        SetBattery(Battery - rate * Time.deltaTime);
        DecayNoise();
        CheckThresholds();
    }

    "cm">// â”€â”€ Battery â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void SetBattery(float v)
    {
        Battery = Mathf.Clamp(v, 0f, 100f);
        onBatteryChanged?.Raise(Battery);
    }
    public void ChargeBattery(float amount) => SetBattery(Battery + amount);

    "cm">// â”€â”€ Signal â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void SetSignal(float v)
    {
        float prev = Signal;
        Signal = Mathf.Clamp(v, 0f, 100f);
        if (Mathf.Abs(prev - Signal) > 0.5f) onSignalChanged?.Raise(Signal);
    }

    "cm">// â”€â”€ Noise â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void AddNoise(float amount)
    {
        Noise = Mathf.Clamp(Noise + amount, 0f, 100f);
        onNoiseChanged?.Raise(Noise);
    }
    void DecayNoise() => Noise = Mathf.Max(0f, Noise - 8f * Time.deltaTime);

    "cm">// â”€â”€ Morale â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    public void AffectMorale(float delta)
    {
        Morale = Mathf.Clamp(Morale + delta, 0f, 100f);
        onMoraleChanged?.Raise(Morale);
        ServiceLocator.Get().Set("morale", Morale);
    }

    "cm">// â”€â”€ Thresholds â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    void CheckThresholds()
    {
        if (!lowFired  && Battery  20f) lowFired = critFired = false;

        if (!noiseFired  && Noise  > 80f) { onNoiseCritical?.Raise(); noiseFired  = true; }
        if (Noise  10f) signalFired = false;
    }

    public void OnNEXUSOpen()  { nexusOpen = true;  }
    public void OnNEXUSClose() { nexusOpen = false; }
}
