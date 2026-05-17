using UnityEngine;
using System;
using System.Collections.Generic;

"cm">// â”€â”€ NetworkProfile â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class NetworkProfile
{
    "cm">// Visible al jugador
    public string username;
    public string avatarId;
    public string bio;
    public string lastSeen;
    public int    postCount;

    "cm">// Oculto al jugador (NonSerialized = no se guarda en JSON de save)
    [NonSerialized] public float  humanityScore;      "cm">// 0=bot, 1=human
    [NonSerialized] public float  responseDelayMin;
    [NonSerialized] public float  responseDelayMax;
    [NonSerialized] public float  typoRate;
    [NonSerialized] public float  emotionalVariance;
    [NonSerialized] public bool   usesCircadianPattern;
    [NonSerialized] public string narrativeArc;        "cm">// static|evolving|deceptive
    [NonSerialized] public string secretType;          "cm">// coord|lore|false_lead|contact
    [NonSerialized] public List evidences = new();
    [NonSerialized] public ProfileClassification classification = ProfileClassification.Unknown;
}

public enum ProfileClassification { Unknown, Bot, PossiblyHuman, Human, AdvancedAI }

"cm">// â”€â”€ ChatMessage â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class ChatMessage
{
    public string   sender;
    public string   text;
    public DateTime time;
    public float    humanityHint; "cm">// NO se muestra al jugador
}

"cm">// â”€â”€ FeedPost â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class FeedPost
{
    public string   author;
    public string   content;
    public DateTime timestamp;
    public bool     isLore;
    public bool     fromKnownProfile;
    public float    humanityHint;
}

"cm">// â”€â”€ WorldEvent â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class WorldEvent
{
    public string id;
    public string type;        "cm">// profile_appears|radio_signal|rumor|loot_hint
    public int    requireAct;
    public int    requireHumans;
    public int    requireDay;
}

"cm">// â”€â”€ ZoneDefinition â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class ZoneDefinition
{
    public string id;
    public string displayName;
    [Range(0, 100)] public float baseSignal;
    public float   threatLevel;
    public string  sceneName;
}

"cm">// â”€â”€ ClassificationRecord â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
[Serializable]
public class ClassificationRecord
{
    public string               profileId;
    public ProfileClassification choice;
    public bool                 correct;
    public int                  day;
}
