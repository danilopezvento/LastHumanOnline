using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class ChatMessagePool : MonoBehaviour
{
    [SerializeField] GameObject msgPrefab;
    [SerializeField] Transform  container;
    [SerializeField] ScrollRect scrollRect;
    [SerializeField] int        initialPoolSize = 20;
    [SerializeField] int        maxVisibleMsgs  = 50;

    private Queue pool   = new();
    private List  active = new();

    void Awake()
    {
        for (int i = 0; i = maxVisibleMsgs) Recycle(active[0]);
        var go = pool.Count > 0 ? pool.Dequeue() : Instantiate(msgPrefab, container);
        go.SetActive(true);
        go.transform.SetAsLastSibling();
        go.GetComponent()?.Setup(msg);
        active.Add(go);
        Canvas.ForceUpdateCanvases();
        scrollRect.verticalNormalizedPosition = 0f;
        return go;
    }

    public void Recycle(GameObject go) { active.Remove(go); go.SetActive(false); pool.Enqueue(go); }
    public void ClearAll()             { foreach (var g in active) { g.SetActive(false); pool.Enqueue(g); } active.Clear(); }
}

public class ChatMessageView : MonoBehaviour
{
    [SerializeField] Text  textContent;
    [SerializeField] Text  textSender;
    [SerializeField] Text  textTime;
    [SerializeField] Image bubble;
    [SerializeField] Color colorPlayer  = new Color(0.15f, 0.35f, 0.25f);
    [SerializeField] Color colorProfile = new Color(0.10f, 0.18f, 0.22f);

    public void Setup(ChatMessage msg)
    {
        textContent.text = msg.text;
        textSender .text = msg.sender;
        textTime   .text = msg.time.ToString("HH:mm");
        bubble.color     = msg.sender == "player" ? colorPlayer : colorProfile;
    }
}
