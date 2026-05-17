using UnityEngine;
using UnityEngine.Events;

public class GameEventListener : MonoBehaviour
{
    [SerializeField] GameEvent  gameEvent;
    [SerializeField] UnityEvent response;

    void OnEnable()  => gameEvent?.RegisterListener(this);
    void OnDisable() => gameEvent?.UnregisterListener(this);

    public void OnEventRaised() => response?.Invoke();
}

"cm">// Crear en Inspector:
"cm">//   GameEvent â†’ OnBatteryLow (asset)
"cm">//   Response  â†’ HUDController.ShowBatteryWarning()
