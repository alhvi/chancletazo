using UnityEngine;

public class BasicTarget : MonoBehaviour {

    public int score = 10;

    private void Start() {
        transform.LookAt(GameManager.instance.player.transform);
    }

    private void OnCollisionEnter(Collision collision) {
        Debug.Log("collision");
        if (collision.gameObject.CompareTag("Chancleta")) {
            Debug.Log("hit");
            GameManager.instance.score += score;
        }
    }
}
