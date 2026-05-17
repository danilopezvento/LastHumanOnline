using UnityEngine;
using System.Collections.Generic;

public class FeedGenerator : MonoBehaviour
{
    [SerializeField] PostDatabase database;
    [SerializeField] int          postsPerFetch = 12;

    private System.Random rng = new(System.Environment.TickCount);

    public List GenerateFeed(List known, MemorySystem memory)
    {
        var feed = new List();
        for (int i = 0; i  0 && rng.NextDouble()  b.timestamp.CompareTo(a.timestamp));
        return feed;
    }

    FeedPost GenerateLorePost(MemorySystem mem) => new()
    {
        author  = $"user_{rng.Next(1000, 9999)}",
        content = FillTemplate(database.loreTemplates[rng.Next(database.loreTemplates.Count)], mem),
        isLore  = true
    };

    FeedPost GenerateKnownPost(NetworkProfile p) => new()
    {
        author           = p.username,
        content          = p.humanityScore > 0.6f
                           ? database.humanPostTemplates[rng.Next(database.humanPostTemplates.Count)]
                           : database.botPostTemplates  [rng.Next(database.botPostTemplates.Count)],
        fromKnownProfile = true,
        humanityHint     = p.humanityScore
    };

    FeedPost GenerateBotPost() => new()
    {
        author  = $"bot_{rng.Next(10000, 99999)}",
        content = database.botPostTemplates[rng.Next(database.botPostTemplates.Count)]
    };

    string FillTemplate(string t, MemorySystem m) =>
        t.Replace("{day}",   m.DaysSinceStart.ToString())
         .Replace("{city}",  database.cities[rng.Next(database.cities.Count)])
         .Replace("{count}", rng.Next(2, 18).ToString());
}
