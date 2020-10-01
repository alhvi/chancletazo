using System.Collections;
using UnityEngine;

public class Player : MonoBehaviour {
    public GameObject anchor;
    public GameObject chancletaPrefab;
    public GameObject shootingPoint;

    public void InstantiateNewChancleta() {
        Chancleta c = anchor.GetComponentInChildren<Chancleta>();
        if (c == null) {
            Instantiate(chancletaPrefab, anchor.transform);
        }
    }

    public void ScheduleInstantiateNewChancleta(float time) {
        StartCoroutine(InstantiateCoroutine(time));
    }

    private IEnumerator InstantiateCoroutine(float time) {
        yield return new WaitForSeconds(time);
        InstantiateNewChancleta();
    }
}
