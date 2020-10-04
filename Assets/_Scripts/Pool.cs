using System.Collections.Generic;
using UnityEngine;

public abstract class Pool : MonoBehaviour {
    public GameObject prefab;
    public List<GameObject> pool;

    private void Start() {
        GrowPool();
    }

    public abstract void ScheduleSpawn();

    public virtual GameObject GetFromPool() {

        GameObject result = FindFirstDisabled();
        if (result == null) {
            GrowPool();
            result = FindFirstDisabled();
        }

        return result;
    }

    private GameObject FindFirstDisabled() {
        GameObject result = null;
        foreach (GameObject item in pool) {
            if (!item.activeSelf) {
                result = item;
                break;
            }
        }

        return result;
    }

    public int CountActive() {
        int active = 0;
        foreach (GameObject item in pool) {
            if (item.activeSelf) {
                active += 1;
            }
        }

        return active;
    }

    public void ReturtToPool(GameObject go) {
        go.SetActive(false);
    }

    public void GrowPool() {
        for (int i = 0; i < 10; i++) {
            GameObject newObject = Instantiate(prefab, transform);
            TargetDestroyer targetDestroyer = newObject.GetComponent<TargetDestroyer>();
            if (targetDestroyer != null) {
                targetDestroyer.pool = this;
                targetDestroyer.usePool = true;
            } else {
                Debug.Log("Problema al inicializar targets");
            }

            newObject.SetActive(false);
            pool.Add(newObject);

        }
    }
}
