using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class PlayerController : MonoBehaviour
{
    [Header("Movement")]
    [SerializeField] float walkSpeed   = 2.5f;
    [SerializeField] float crouchSpeed = 1.2f;
    [SerializeField] LayerMask walkableMask;

    [Header("Noise generation")]
    [SerializeField] float walkNoiseMult   = 0.30f;
    [SerializeField] float crouchNoiseMult = 0.05f;

    [Header("Events")]
    [SerializeField] FloatEvent onNoiseMade;
    [SerializeField] GameEvent  onInteractionTry;
    [SerializeField] GameEvent  onPlayerMoved;

    private NavMeshAgent    agent;
    private ResourceManager resources;
    private bool            isCrouching;
    private bool            isMoving;

    void Start()
    {
        agent     = GetComponent();
        resources = ServiceLocator.Get();
        agent.speed = walkSpeed;
    }

    void Update()
    {
        HandleTouchInput();
        HandleCrouch();
        EmitNoise();
    }

    void HandleTouchInput()
    {
        if (Input.touchCount == 0) return;
        var touch = Input.GetTouch(0);
        if (touch.phase != TouchPhase.Began) return;

        var ray = Camera.main.ScreenPointToRay(touch.position);
        if (Physics.Raycast(ray, out var hit, 100f, walkableMask))
        {
            agent.SetDestination(hit.point);
            isMoving = true;
            onPlayerMoved?.Raise();
        }
    }

    void HandleCrouch()
    {
        isCrouching = Input.touchCount >= 2;
        agent.speed = isCrouching ? crouchSpeed : walkSpeed;
    }

    void EmitNoise()
    {
        if (!isMoving || agent.remainingDistance  onInteractionTry?.Raise();
}
