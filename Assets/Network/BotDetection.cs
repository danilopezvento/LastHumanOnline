using UnityEngine;
using System.Collections.Generic;

public class BotDetection : MonoBehaviour
{
    public static readonly Dictionary EvidenceWeights = new()
    {
        { "fast_response",     -0.25f },
        { "slow_response",      0.20f },
        { "typo_detected",      0.15f },
        { "perfect_syntax",    -0.20f },
        { "emotional_change",   0.25f },
        { "topic_mismatch",    -0.15f },
        { "circadian_pattern",  0.30f },
        { "personal_memory",    0.20f },
        { "generic_phrase",    -0.20f },
        { "fear_expressed",     0.35f },
        { "refuses_location",   0.20f },
    };

    [SerializeField] StringEvent  onEvidenceAdded;
    [SerializeField] ProfileEvent onProfileClassified;

    private NetworkProfile target;
    private const int MIN_EVIDENCES = 3;

    public void SetTarget(NetworkProfile p) { target = p; }

    public void AddEvidence(string key)
    {
        if (target == null || !EvidenceWeights.ContainsKey(key)) return;
        target.evidences.Add(key);
        onEvidenceAdded?.Raise(key);
    }

    public void AutoDetectFromMessage(ChatMessage msg)
    {
        if (msg.time.Second  target?.evidences.Count >= MIN_EVIDENCES;

    public void Classify(ProfileClassification playerChoice)
    {
        if (!CanClassify()) return;
        target.classification = playerChoice;

        bool isCorrect = playerChoice switch
        {
            ProfileClassification.Bot          => target.humanityScore  target.humanityScore is >= 0.35f and  target.humanityScore >= 0.65f,
            _ => false
        };

        ServiceLocator.Get().RecordClassification(target.username, playerChoice, isCorrect);
        ServiceLocator.Get().AffectMorale(isCorrect ? 5f : -12f);
        onProfileClassified?.Raise(target);
    }

    bool HasGenericPhrases(string t) => t.Contains("entiendo") || t.Contains("Â¿cÃ³mo puedo");
    bool HasEmotionalWords(string t) => t.Contains("miedo")    || t.Contains("solo") || t.Contains("no sÃ©");
}
