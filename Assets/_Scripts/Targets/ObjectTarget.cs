using System.Collections;
using UnityEngine;

public class ObjectTarget : BasicTarget {
    public GameObject prefab;
    public float secondsToRespawn;
    private Vector3 pos;
    private Quaternion rot;

    private void Start() {
        pos = transform.position;
        rot = transform.rotation;
    }

    private void OnCollisionEnter(Collision collision) {
        if (!collision.gameObject.CompareTag("Base")) {
            StartCoroutine("DestroyObject");
        }

    }

    private IEnumerator DestroyObject() {
        yield return new WaitForSeconds(secondsToRespawn);
        GameObject newObject = Instantiate(prefab);
        newObject.transform.position = pos;
        newObject.transform.rotation = rot;
        Destroy(gameObject);
    }
}
