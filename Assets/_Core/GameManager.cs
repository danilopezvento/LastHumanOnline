using UnityEngine;
using System.Collections;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance { get; private set; }

    public GameState CurrentState { get; private set; }
    public bool IsNEXUSOpen { get; private set; }
    public bool IsPaused    { get; private set; }

    [Header("Events")]
    [SerializeField] GameEvent onGameStart;
    [SerializeField] GameEvent onGamePause;
    [SerializeField] GameEvent onGameResume;
    [SerializeField] GameEvent onNEXUSOpen;
    [SerializeField] GameEvent onNEXUSClose;

    [Header("Systems")]
    [SerializeField] ResourceManager resourceManager;
    [SerializeField] SaveSystem       saveSystem;
    [SerializeField] MemorySystem     memorySystem;

    void Awake()
    {
        if (Instance != null) { Destroy(gameObject); return; }
        Instance = this;
        DontDestroyOnLoad(gameObject);
        InitSystems();
    }

    void InitSystems()
    {
        ServiceLocator.Register(resourceManager);
        ServiceLocator.Register(saveSystem);
        ServiceLocator.Register(memorySystem);
        CurrentState = GameState.Exploring;
    }

    void Start() => StartCoroutine(GameStartSequence());

    IEnumerator GameStartSequence()
    {
        yield return saveSystem.LoadAsync().AsCoroutine();
        onGameStart?.Raise();
    }

    public void OpenNEXUS()
    {
        if (resourceManager.Battery < 1f) return;
        IsNEXUSOpen  = true;
        CurrentState = GameState.InNEXUS;
        onNEXUSOpen?.Raise();
    }

    public void CloseNEXUS()
    {
        IsNEXUSOpen  = false;
        CurrentState = GameState.Exploring;
        onNEXUSClose?.Raise();
        saveSystem.SaveAsync();
    }

    public void Pause()
    {
        IsPaused       = true;
        Time.timeScale = 0f;
        onGamePause?.Raise();
    }

    public void Resume()
    {
        IsPaused       = false;
        Time.timeScale = 1f;
        onGameResume?.Raise();
    }

    void OnApplicationPause(bool paused) { if (paused) saveSystem.SaveAsync(); }
}

public enum GameState { Exploring, InNEXUS, InDialog, Paused, GameOver }
