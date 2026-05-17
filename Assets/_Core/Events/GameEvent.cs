using UnityEngine;
using System.Collections.Generic;

[CreateAssetMenu(fileName = "GameEvent", menuName = "LHO/Events/GameEvent")]
public class GameEvent : ScriptableObject
{
    private readonly List listeners = new();

    public void Raise()
    {
        for (int i = listeners.Count - 1; i >= 0; i--)
            listeners[i].OnEventRaised();
    }

    public void RegisterListener(GameEventListener l)   => listeners.Add(l);
    public void UnregisterListener(GameEventListener l) => listeners.Remove(l);
}

"cm">// â”€â”€ Eventos con dato â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[CreateAssetMenu(fileName = "FloatEvent", menuName = "LHO/Events/FloatEvent")]
public class FloatEvent : ScriptableObject
{
    private readonly List> listeners = new();
    public void Raise(float v) { for (int i = listeners.Count-1; i >= 0; i--) listeners[i]?.Invoke(v); }
    public void RegisterListener(System.Action l)   => listeners.Add(l);
    public void UnregisterListener(System.Action l) => listeners.Remove(l);
}

[CreateAssetMenu(fileName = "StringEvent", menuName = "LHO/Events/StringEvent")]
public class StringEvent : ScriptableObject
{
    private readonly List> listeners = new();
    public void Raise(string v) { for (int i = listeners.Count-1; i >= 0; i--) listeners[i]?.Invoke(v); }
    public void RegisterListener(System.Action l)   => listeners.Add(l);
    public void UnregisterListener(System.Action l) => listeners.Remove(l);
}
