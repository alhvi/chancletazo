using UnityEngine;

public class GameManager : MonoBehaviour {
    public static GameManager instance;
    public Player player;
    public StrengthMeter strengthMeter;
    public int score = 0;

    private void Awake() {
        instance = this;
    }

}
