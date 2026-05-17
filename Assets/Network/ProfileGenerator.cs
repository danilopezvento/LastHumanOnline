using UnityEngine;
using System.Collections.Generic;

public class ProfileGenerator : MonoBehaviour
{
    [SerializeField] PostDatabase database;

    private System.Random rng;

    void Awake() => rng = new System.Random(
        ServiceLocator.Get().Get("world_seed", 42));

    public NetworkProfile Generate(float humanityScore = -1f)
    {
        if (humanityScore  0.65f)
        {
            p.responseDelayMin       = 2f;
            p.responseDelayMax       = Mathf.Lerp(15f, 120f, humanityScore);
            p.usesCircadianPattern   = rng.NextDouble() > 0.3f;
        }
        else
        {
            p.responseDelayMin       = 0.4f;
            p.responseDelayMax       = 1.8f;
            p.usesCircadianPattern   = false;
        }

        p.typoRate         = humanityScore * 0.15f * (float)rng.NextDouble();
        p.emotionalVariance = humanityScore;

        float r = (float)rng.NextDouble();
        p.narrativeArc = humanityScore > 0.7f ? "evolving"
                       : humanityScore  0.5f             ? "deceptive" : "static";

        string[] secrets = { "coord", "lore", "false_lead", "contact" };
        p.secretType = secrets[rng.Next(secrets.Length)];

        var templates = humanityScore > 0.6f ? database.humanBioTemplates : database.botBioTemplates;
        p.bio = Pick(templates)
            .Replace("{city}", Pick(database.cities))
            .Replace("{year}", rng.Next(2019, 2024).ToString());

        return p;
    }

    T Pick(List list) => list[rng.Next(list.Count)];
}
