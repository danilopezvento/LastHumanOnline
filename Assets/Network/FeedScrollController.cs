using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.Collections.Generic;

public class FeedScrollController : MonoBehaviour
{
    [SerializeField] ScrollRect scrollRect;
    [SerializeField] Transform  content;
    [SerializeField] GameObject postPrefab;
    [SerializeField] int        poolSize        = 15;
    [SerializeField] float      refreshThreshold = 80f;
    [SerializeField] GameEvent  onRefreshRequested;
    [SerializeField] GameObject newPostBanner;
    [SerializeField] Text       newPostCount;

    private List    allPosts = new();
    private Queue pool     = new();
    private List  visible  = new();
    private int               pending;
    private bool              refreshing;

    void Start()
    {
        for (int i = 0; i  posts) { ClearFeed(); allPosts = posts; RenderAll(); }

    public void PrependPost(FeedPost post)
    {
        allPosts.Insert(0, post);
        if (scrollRect.verticalNormalizedPosition > 0.95f) Spawn(post, asFirst: true);
        else { pending++; newPostBanner.SetActive(true); newPostCount.text = $"+{pending}"; }
    }

    void OnScroll(Vector2 pos)
    {
        if (pos.y > 1f && !refreshing)
        {
            float over = (pos.y - 1f) * content.GetComponent().rect.height;
            if (over > refreshThreshold) StartCoroutine(Refresh());
        }
        if (pos.y > 0.95f && pending > 0)
        {
            pending = 0; newPostBanner.SetActive(false); RenderAll();
        }
    }

    IEnumerator Refresh()
    {
        refreshing = true;
        onRefreshRequested?.Raise();
        yield return new WaitForSeconds(1.5f);
        refreshing = false;
    }

    void RenderAll() { foreach (var p in allPosts) Spawn(p); }

    void Spawn(FeedPost post, bool asFirst = false)
    {
        var go = pool.Count > 0 ? pool.Dequeue() : Instantiate(postPrefab, content);
        go.SetActive(true);
        go.transform.SetSiblingIndex(asFirst ? 0 : go.transform.parent.childCount);
        go.GetComponent()?.Setup(post);
        visible.Add(go);
    }

    void ClearFeed()
    {
        foreach (var go in visible) { go.SetActive(false); pool.Enqueue(go); }
        visible.Clear();
    }
}

public class FeedPostView : MonoBehaviour
{
    [SerializeField] Text  textAuthor, textContent, textTime, textLikes;
    [SerializeField] Image background;
    [SerializeField] Color loreColor = new Color(0.13f, 0.20f, 0.16f);
    [SerializeField] Color botColor  = new Color(0.10f, 0.14f, 0.18f);

    public void Setup(FeedPost p)
    {
        textAuthor .text = p.author;
        textContent.text = p.content;
        textTime   .text = FormatTime(p.timestamp);
        textLikes  .text = Random.Range(0, p.isLore ? 3 : 847).ToString();
        if (background) background.color = p.isLore ? loreColor : botColor;
    }

    string FormatTime(System.DateTime dt)
    {
        var d = System.DateTime.Now - dt;
        if (d.TotalMinutes < 1) return "ahora";
        if (d.TotalHours   < 1) return $"{(int)d.TotalMinutes}m";
        if (d.TotalDays    < 1) return $"{(int)d.TotalHours}h";
        return $"{(int)d.TotalDays}d";
    }
}
