using System.Collections;
using UnityEngine;

public class TargetDestroyer : MonoBehaviour {

    public bool usePool = false;
    public Pool pool;
    public bool sterile = false;

    public void ScheduleDestroy() {

        StartCoroutine(DestroyTarget());
        if (!sterile && usePool) {
            pool.ScheduleSpawn();
        }

    }

    private IEnumerator DestroyTarget() {
        yield return new WaitForSeconds(0.35f);

        if (!usePool) {
            Destroy(gameObject);
        } else {
            if (pool != null) {
                pool.ReturtToPool(gameObject);
            }

        }

    }
}
