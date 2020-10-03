using Cinemachine;
using System.Collections;
using UnityEngine;

public class Chancleta : MonoBehaviour {
    private CinemachineVirtualCamera vCamera;
    private Rigidbody rb;
    public float minForce = 350;
    public float maxForce = 600;
    public float force;
    private float maxRotation = -20f;
    private float maxForceTime = 0.75f;
    private float forceTime = 0;
    private float percentage = 0;
    private bool updatingStrength = false;
    private bool scheduledForDestruction = false;

    private void Start() {
        vCamera = GetComponentInParent<CinemachineVirtualCamera>();
        rb = GetComponent<Rigidbody>();
        force = minForce;
    }

    private void Update() {

        if (GameManager.instance.playing) {
            if (Input.GetMouseButtonDown(0) && transform.parent != null) {
                updatingStrength = true;
            }

            if (Input.GetMouseButtonUp(0) && transform.parent != null) {
                updatingStrength = false;
                rb.isKinematic = false;
                transform.position = GameManager.instance.player.shootingPoint.transform.position;
                transform.parent = null;
                Vector3 direction = GameManager.instance.player.shootingPoint.transform.forward;
                rb.AddForce(direction * force);
                rb.AddTorque(direction * 5f);
                GameManager.instance.strengthMeter.ClearMeter();
                GameManager.instance.player.ScheduleInstantiateNewChancleta(0.7f);

            }

            if (updatingStrength) {
                float angle = Mathf.Lerp(0, -20, forceTime / maxForceTime);
                Vector3 rotation = new Vector3(angle, 0, 0);
                transform.localEulerAngles = rotation;
                forceTime += Time.deltaTime;

                force = Mathf.Lerp(minForce, maxForce, forceTime / maxForceTime);
                percentage = Mathf.Lerp(0, 1, forceTime / maxForceTime);
                GameManager.instance.strengthMeter.UpdateMeter(percentage);
            }

            if (transform.position.y < -5 && !scheduledForDestruction) {
                scheduledForDestruction = true;
                StartCoroutine("DestroyChancleta");
            }
        }
    }

    private void OnCollisionEnter(Collision collision) {
        StartCoroutine("DestroyChancleta");
    }

    private IEnumerator DestroyChancleta() {
        yield return new WaitForSeconds(1f);
        Destroy(gameObject);
    }

}
