using UnityEngine;
using System.Collections.Generic;

"cm">// â”€â”€ ProfileEvent â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// ScriptableObject event que transporta un NetworkProfile.
"cm">// Crear desde: Assets â†’ Create â†’ LHO â†’ Events â†’ ProfileEvent
"cm">// Usar cuando: BotDetection clasifica un perfil, NEXUSApp abre un perfil.

[CreateAssetMenu(fileName = "ProfileEvent", menuName = "LHO/Events/ProfileEvent")]
public class ProfileEvent : ScriptableObject
{
    private readonly List> listeners = new();

    public void Raise(NetworkProfile profile)
    {
        for (int i = listeners.Count - 1; i >= 0; i--)
            listeners[i]?.Invoke(profile);
    }

    public void RegisterListener(System.Action l)   => listeners.Add(l);
    public void UnregisterListener(System.Action l) => listeners.Remove(l);
}

"cm">// â”€â”€ ProfileEventListener â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// Componente que escucha un ProfileEvent y llama un UnityEvent.
"cm">// AÃ±adir a cualquier GameObject que necesite reaccionar a la clasificaciÃ³n.

public class ProfileEventListener : MonoBehaviour
{
    [SerializeField] ProfileEvent             gameEvent;
    [SerializeField] UnityEngine.Events.UnityEvent response;

    void OnEnable()  => gameEvent?.RegisterListener(OnEventRaised);
    void OnDisable() => gameEvent?.UnregisterListener(OnEventRaised);

    void OnEventRaised(NetworkProfile profile) => response?.Invoke(profile);
}
