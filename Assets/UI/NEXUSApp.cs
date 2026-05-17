using UnityEngine;

public class NEXUSApp : MonoBehaviour
{
    public enum Screen { Feed, Chat, Profile }

    [SerializeField] GameObject      feedPanel;
    [SerializeField] GameObject      chatPanel;
    [SerializeField] GameObject      profilePanel;

    [SerializeField] FeedScrollController feedScroll;
    [SerializeField] ChatEngine           chatEngine;
    [SerializeField] ChatMessagePool      chatPool;
    [SerializeField] BotDetection         botDetection;
    [SerializeField] FeedGenerator        feedGen;

    private Screen         current = Screen.Feed;
    private NetworkProfile activeProfile;

    void OnEnable() { ShowScreen(Screen.Feed); RefreshFeed(); }

    public void ShowScreen(Screen s)
    {
        feedPanel   .SetActive(s == Screen.Feed);
        chatPanel   .SetActive(s == Screen.Chat);
        profilePanel.SetActive(s == Screen.Profile);
        current = s;
    }

    public void OpenProfile(NetworkProfile p)
    {
        activeProfile = p;
        chatEngine.SetActiveProfile(p);
        botDetection.SetTarget(p);
        ShowScreen(Screen.Profile);
    }

    public void OpenChat()    { if (activeProfile != null) ShowScreen(Screen.Chat); }

    public void SendMessage(string text)
    {
        if (string.IsNullOrWhiteSpace(text)) return;
        chatEngine.SendMessage(text);
    }

    public void ClassifyProfile(int classificationIndex)
    {
        if (!botDetection.CanClassify()) return;
        botDetection.Classify((ProfileClassification)classificationIndex);
        ShowScreen(Screen.Feed);
    }

    void RefreshFeed()
    {
        var memory = ServiceLocator.Get();
        var posts  = feedGen.GenerateFeed(new(), memory);
        feedScroll.LoadFeed(posts);
    }
}
