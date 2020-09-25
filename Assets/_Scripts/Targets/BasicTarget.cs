using UnityEngine;

public class BasicTarget : MonoBehaviour {

    public int score = 10;

    private void Start() {
        transform.LookAt(GameManager.instance.player.transform);
    }

    private void OnCollisionEnter(Collision collision) {
        if (collision.gameObject.CompareTag("Chancleta")) {
            GameManager.instance.score += score;
        }
    }
}
