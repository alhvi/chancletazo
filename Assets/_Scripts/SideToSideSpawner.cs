using System.Collections;
using UnityEngine;

public class SideToSideSpawner : Pool {

    public bool spawning = false;
    public override GameObject GetFromPool() {
        GameObject result = base.GetFromPool();
        SideToSideTarget targetComponent = result.GetComponent<SideToSideTarget>();
        if (targetComponent != null) {
            targetComponent.ResetPosition();
        }

        result.SetActive(true);

        return result;
    }

    public void SetSpawning(bool s) {
        spawning = s;
        GetFromPool();
        GetFromPool();
    }

    public override void ScheduleSpawn() {
        StartCoroutine(SpawnNew());
        StartCoroutine(CheckEnoughTargets());
    }

    private IEnumerator SpawnNew() {
        yield return new WaitForSeconds(0.5f);
        GetFromPool();
        float prob = Random.Range(0f, 1f);
        if (prob < 0.1) {
            GameObject newObject = GetFromPool();
            TargetDestroyer dest = newObject.GetComponent<TargetDestroyer>();
            dest.sterile = true;
        }

    }

    private IEnumerator CheckEnoughTargets() {
        while (GameManager.instance.playing) {
            yield return new WaitForSeconds(2);
            if (CountActive() < GameManager.instance.sideToSideItems) {
                GetFromPool();
            }
        }

    }

}
