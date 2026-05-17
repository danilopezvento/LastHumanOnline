using UnityEngine;
using System.Collections;

public class ChatEngine : MonoBehaviour
{
    [SerializeField] MessageEvent onMessageReceived;
    [SerializeField] GameEvent    onTypingStart;
    [SerializeField] GameEvent    onTypingStop;
    [SerializeField] InkChatBridge inkBridge;

    private NetworkProfile activeProfile;

    public void SetActiveProfile(NetworkProfile profile)
    {
        activeProfile = profile;
        inkBridge.LoadProfile(profile);
    }

    public void SendMessage(string text)
    {
        if (activeProfile == null) return;

        onMessageReceived?.Raise(new ChatMessage
            { sender = "player", text = text, time = System.DateTime.Now });

        StartCoroutine(ProfileResponse(text));
    }

    IEnumerator ProfileResponse(string playerMsg)
    {
        float delay = GetResponseDelay();

        yield return new WaitForSeconds(delay * Random.Range(0.4f, 0.8f));
        onTypingStart?.Raise();

        yield return new WaitForSeconds(delay * Random.Range(0.2f, 0.6f));
        onTypingStop?.Raise();

        string response = inkBridge.HasMore()
            ? inkBridge.GetNextLine()
            : FallbackResponse();

        response = ApplyTypos(response, activeProfile.typoRate);

        onMessageReceived?.Raise(new ChatMessage
        {
            sender       = activeProfile.username,
            text         = response,
            time         = System.DateTime.Now,
            humanityHint = activeProfile.humanityScore
        });
    }

    float GetResponseDelay()
    {
        float d = Random.Range(activeProfile.responseDelayMin, activeProfile.responseDelayMax);
        if (activeProfile.usesCircadianPattern)
        {
            int h = System.DateTime.Now.Hour;
            if (h  22) d *= Random.Range(2f, 8f);
        }
        return d;
    }

    string ApplyTypos(string text, float rate)
    {
        if (rate  rate) return text;
        var chars = text.ToCharArray();
        int idx = Random.Range(1, chars.Length - 1);
        chars[idx] = (char)(chars[idx] + (Random.value > 0.5f ? 1 : -1));
        return new string(chars);
    }

    string FallbackResponse() =>
        activeProfile.humanityScore > 0.6f
            ? "..."
            : "Gracias por tu mensaje. Â¿CÃ³mo puedo ayudarte?";
}
