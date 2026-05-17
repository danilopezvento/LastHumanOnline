using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;

public class InkChatBridge : MonoBehaviour
{
    [SerializeField] TextAsset   genericBotStory;
    [SerializeField] TextAsset   genericHumanStory;
    [SerializeField] TextAsset[] profileOverrides;

    private Dictionary cache = new();
    private Story          activeStory;
    private NetworkProfile activeProfile;
    private MemorySystem   memory;

    void Start() => memory = ServiceLocator.Get();

    public void LoadProfile(NetworkProfile profile)
    {
        activeProfile = profile;
        if (!cache.TryGetValue(profile.username, out activeStory))
        {
            var asset  = FindOverride(profile.username) ??
                         (profile.humanityScore > 0.5f ? genericHumanStory : genericBotStory);
            activeStory = new Story(asset.text);
            cache[profile.username] = activeStory;
        }
        SyncVariables();
    }

    public string GetNextLine()
    {
        if (activeStory == null || !activeStory.canContinue) return null;
        return activeStory.Continue().Trim();
    }

    public List GetChoices() => activeStory?.currentChoices;

    public void Choose(int index)
    {
        activeStory?.ChooseChoiceIndex(index);
        memory.Set($"chat_{activeProfile.username}_choice_{index}", "true");
    }

    public bool HasMore() =>
        activeStory != null && (activeStory.canContinue || activeStory.currentChoices.Count > 0);

    void SyncVariables()
    {
        if (activeStory == null) return;
        activeStory.variablesState["humanity"]    = activeProfile.humanityScore;
        activeStory.variablesState["username"]    = activeProfile.username;
        activeStory.variablesState["arc"]         = activeProfile.narrativeArc;
        activeStory.variablesState["secret_type"] = activeProfile.secretType;
        activeStory.variablesState["player_day"]  = memory.DaysSinceStart;
        activeStory.variablesState["act"]         = memory.CurrentAct;
        foreach (var ev in activeProfile.evidences)
            activeStory.variablesState[$"ev_{ev}"] = true;
    }

    TextAsset FindOverride(string username)
    {
        foreach (var a in profileOverrides) if (a != null && a.name == username) return a;
        return null;
    }

    public void ClearCache() => cache.Clear();
}
