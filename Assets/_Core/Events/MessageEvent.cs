using UnityEngine;
using System.Collections.Generic;

"cm">// â”€â”€ MessageEvent â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// ScriptableObject event que transporta un ChatMessage.
"cm">// Crear desde: Assets â†’ Create â†’ LHO â†’ Events â†’ MessageEvent
"cm">// Usar cuando: ChatEngine recibe o envÃ­a un mensaje, ChatMessagePool lo renderiza.

[CreateAssetMenu(fileName = "MessageEvent", menuName = "LHO/Events/MessageEvent")]
public class MessageEvent : ScriptableObject
{
    private readonly List> listeners = new();

    public void Raise(ChatMessage message)
    {
        for (int i = listeners.Count - 1; i >= 0; i--)
            listeners[i]?.Invoke(message);
    }

    public void RegisterListener(System.Action l)   => listeners.Add(l);
    public void UnregisterListener(System.Action l) => listeners.Remove(l);
}

"cm">// â”€â”€ MessageEventListener â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
"cm">// Componente que escucha un MessageEvent y llama un mÃ©todo del ChatMessagePool.
"cm">// Ejemplo en Inspector:
"cm">//   GameEvent â†’ onMessageReceived (asset)
"cm">//   Response  â†’ ChatMessagePool.Spawn(ChatMessage)

public class MessageEventListener : MonoBehaviour
{
    [SerializeField] MessageEvent gameEvent;
    [SerializeField] ChatMessagePool pool;

    void OnEnable()  => gameEvent?.RegisterListener(OnMessageReceived);
    void OnDisable() => gameEvent?.UnregisterListener(OnMessageReceived);

    void OnMessageReceived(ChatMessage msg)
    {
        if (pool != null) pool.Spawn(msg);
    }
}
