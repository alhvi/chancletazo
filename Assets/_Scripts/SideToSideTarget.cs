using UnityEngine;

public class SideToSideTarget : MonoBehaviour {

    public BasicTarget target;
    public float speedNormalMin = 5f;
    public float speedNormalMax = 6f;
    public float speedFastMin = 9f;
    public float speedFastMax = 10.5f;
    private float rotation;
    private int rotationDirection;
    private float currentSpeed;
    private bool updatedSpeed = false;
    private static float pasty = 0f;
    private static float pastz = -8.2f;

    private void Start() {
        ResetPosition();
    }

    private void Update() {
        rotation += rotationDirection * currentSpeed * Time.deltaTime;
        if (rotation > 25) {
            rotationDirection = -1;
        }
        if (rotation < -25) {
            rotationDirection = 1;
        }
        transform.rotation = Quaternion.Euler(0, rotation, 0);

        if (GameManager.instance.fastMode && !updatedSpeed) {
            updatedSpeed = true;
            currentSpeed = Random.Range(speedFastMin, speedFastMax);
        }
    }

    public void ResetPosition() {
        Vector3 targetPosition = target.transform.position;
        do {
            targetPosition.y = Random.Range(2f, 5.5f);
        } while (Mathf.Abs(targetPosition.y - pasty) < 1f);
        pasty = targetPosition.y;
        target.transform.position = targetPosition;
        target.transform.LookAt(GameManager.instance.player.transform);

        if (GameManager.instance.fastMode) {
            currentSpeed = Random.Range(speedFastMin, speedFastMax);
        } else {
            currentSpeed = Random.Range(speedNormalMin, speedNormalMax);
        }

        float coin = Random.Range(0f, 1f);
        if (coin > 0.5) {
            rotationDirection = 1;
            rotation = -24.9f;
        } else {
            rotationDirection = -1;
            rotation = 24.9f;
        }

        transform.Rotate(Vector3.up, rotation);

    }
}
