using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;

"cm">// Dependencia: Ink Unity Integration
"cm">// Window â†’ Package Manager â†’ Add from git URL:
"cm">// https://github.com/inkle/ink-unity-integration.git

public class DialogSystem : MonoBehaviour
{
    [SerializeField] TextAsset[] inkFiles;
    [SerializeField] GameEvent   onDialogStart;
    [SerializeField] GameEvent   onDialogEnd;
    [SerializeField] StringEvent onLineReady;
    [SerializeField] GameEvent   onChoicesReady;

    private Story         currentStory;
    private MemorySystem  memory;
    private ResourceManager res;

    void Start()
    {
        memory = ServiceLocator.Get();
        res    = ServiceLocator.Get();
    }

    public void StartDialog(string inkFileName, string knot = null)
    {
        var file = System.Array.Find(inkFiles, f => f.name == inkFileName);
        if (file == null) return;

        currentStory = new Story(file.text);
        BindExternalFunctions();
        SyncMemoryToInk();
        if (knot != null) currentStory.ChoosePathString(knot);

        onDialogStart?.Raise();
        Continue();
    }

    public void Continue()
    {
        if (currentStory == null) return;
        if (currentStory.canContinue)
        {
            string line = currentStory.Continue().Trim();
            if (!string.IsNullOrEmpty(line)) onLineReady?.Raise(line);
        }
        else if (currentStory.currentChoices.Count > 0) onChoicesReady?.Raise();
        else EndDialog();
    }

    public List GetChoices() => currentStory?.currentChoices;

    public void ChooseOption(int index) { currentStory?.ChooseChoiceIndex(index); Continue(); }

    void SyncMemoryToInk()
    {
        currentStory.variablesState["morale"]       = res.Morale;
        currentStory.variablesState["day"]          = memory.DaysSinceStart;
        currentStory.variablesState["humans_found"] = memory.HumansConfirmed;
        currentStory.variablesState["act"]          = memory.CurrentAct;
    }

    void BindExternalFunctions()
    {
        currentStory.BindExternalFunction("affect_morale", (float v) => res.AffectMorale(v));
        currentStory.BindExternalFunction("record_choice", (string k, string v) => memory.Set(k, v));
        currentStory.BindExternalFunction("get_memory",    (string k) => memory.Get(k));
    }

    void EndDialog() { currentStory = null; onDialogEnd?.Raise(); }
}
