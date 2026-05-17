using UnityEngine;
using System.Collections.Generic;

public class WorldEventQueue : MonoBehaviour
{
    [SerializeField] StringEvent   onWorldEventReady;
    [SerializeField] WorldDatabaseLoader worldDb;
    [SerializeField] float         eventIntervalMin = 120f;
    [SerializeField] float         eventIntervalMax = 480f;

    private Queue pending = new();
    private float             nextEventTime;
    private MemorySystem      memory;

    void Start()
    {
        memory = ServiceLocator.Get();
        ScheduleNext();
        PreloadActEvents();
    }

    void Update()
    {
        if (Time.time 
        (e.requireAct    = e.requireAct) &&
        (e.requireHumans = e.requireHumans) &&
        (e.requireDay    = e.requireDay);

    void ScheduleNext() =>
        nextEventTime = Time.time + Random.Range(eventIntervalMin, eventIntervalMax);
}
