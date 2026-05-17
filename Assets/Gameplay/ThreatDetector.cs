using UnityEngine;

public class ThreatDetector : MonoBehaviour
{
    [SerializeField] float  detectionRadius = 8f;
    [SerializeField] float  alertThreshold  = 60f;  "cm">// noise %
    [SerializeField] float  alertCooldown   = 4f;
    [SerializeField] LayerMask playerMask;

    [Header("Events")]
    [SerializeField] GameEvent onPlayerDetected;
    [SerializeField] GameEvent onAlertRaised;

    private ResourceManager res;
    private float cooldownTimer;

    void Start() => res = ServiceLocator.Get();

    void Update()
    {
        cooldownTimer -= Time.deltaTime;
        if (cooldownTimer > 0f || res.Noise < alertThreshold) return;

        var cols = Physics.OverlapSphere(transform.position, detectionRadius, playerMask);
        if (cols.Length == 0) return;

        cooldownTimer = alertCooldown;
        res.AffectMorale(-8f);
        onPlayerDetected?.Raise();
        onAlertRaised?.Raise();
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, detectionRadius);
    }
}
