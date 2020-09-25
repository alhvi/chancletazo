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
    private float maxForceTime = 1.5f;
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
        if (Input.GetMouseButtonDown(0) && transform.parent != null) {
            updatingStrength = true;
        }

        if (Input.GetMouseButtonUp(0) && transform.parent != null) {
            updatingStrength = false;
            Debug.Log("Throw");
            rb.isKinematic = false;
            transform.position = GameManager.instance.player.shootingPoint.transform.position;
            transform.parent = null;
            Vector3 direction = GameManager.instance.player.shootingPoint.transform.forward;
            Debug.Log("force " + force);
            rb.AddForce(direction * force);

            GameManager.instance.strengthMeter.ClearMeter();

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

    private void OnCollisionEnter(Collision collision) {

        StartCoroutine("DestroyChancleta");

    }

    private IEnumerator DestroyChancleta() {
        yield return new WaitForSeconds(1f);
        GameManager.instance.player.InstantiateNewChancleata();
        Destroy(gameObject);
    }

}
