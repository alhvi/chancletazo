using UnityEngine;

public class Player : MonoBehaviour {
    public GameObject anchor;
    public GameObject chancletaPrefab;
    public GameObject shootingPoint;

    public void InstantiateNewChancleata() {
        Chancleta c = anchor.GetComponentInChildren<Chancleta>();
        if (c == null) {
            Instantiate(chancletaPrefab, anchor.transform);
        }
    }
}
