using UnityEngine;
using System.Collections.Generic;

public class MemorySystem : MonoBehaviour
{
    public int  DaysSinceStart       { get; private set; }
    public int  HumansConfirmed      { get; private set; }
    public int  BotsIdentified       { get; private set; }
    public int  WrongClassifications { get; private set; }
    public int  CurrentAct           { get; private set; } = 1;

    private Dictionary store   = new();
    private List history = new();

    [SerializeField] StringEvent onConsequenceFired;
    [SerializeField] GameEvent   onActChanged;

    void Start() => LoadFromSave();

    public void RecordClassification(string profileId, ProfileClassification choice, bool correct)
    {
        history.Add(new ClassificationRecord { profileId = profileId, choice = choice, correct = correct, day = DaysSinceStart });

        if (correct && choice == ProfileClassification.Human) HumansConfirmed++;
        if (correct && choice == ProfileClassification.Bot)   BotsIdentified++;
        if (!correct) WrongClassifications++;

        onConsequenceFired?.Raise(correct ? $"correct_{profileId}" : $"wrong_{profileId}");
        CheckActProgression();
        PersistToSave();
    }

    void CheckActProgression()
    {
        if (CurrentAct == 1 && HumansConfirmed >= 2 && DaysSinceStart >= 5)  AdvanceAct();
        if (CurrentAct == 2 && HumansConfirmed >= 4 && DaysSinceStart >= 12) AdvanceAct();
    }

    void AdvanceAct() { CurrentAct++; onActChanged?.Raise(); PersistToSave(); }

    public void AdvanceDay() { DaysSinceStart++; PersistToSave(); }

    public void Set(string key, string val) => store[key] = val;
    public string Get(string key) => store.TryGetValue(key, out var v) ? v : "";

    void PersistToSave()
    {
        var save = ServiceLocator.Get();
        save.Set("days",   DaysSinceStart);
        save.Set("humans", HumansConfirmed);
        save.Set("act",    CurrentAct);
        save.Set("store",  store);
        save.SaveAsync();
    }

    void LoadFromSave()
    {
        var save = ServiceLocator.Get();
        DaysSinceStart  = save.Get("days");
        HumansConfirmed = save.Get("humans");
        CurrentAct      = save.Get("act", 1);
    }
}
