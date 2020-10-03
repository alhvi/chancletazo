using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public static GameManager instance;
    public Player player;
    public StrengthMeter strengthMeter;
    public TMP_Text pointsText;
    public TMP_Text timeText;
    public AudioClip musicNormal;
    public AudioClip musicFast;
    public GameObject gamePanel;
    public GameObject endGamePanel;
    public TMP_Text endGamePoints;
    public float levelTime = 170;
    public int score = 0;
    private AudioSource audioSource;
    private bool changedMusic = false;
    public bool playing = true;

    private void Awake() {
        instance = this;
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void Start() {
        audioSource = GetComponent<AudioSource>();
        audioSource.clip = musicNormal;
        audioSource.Play();
        audioSource.loop = true;

        gamePanel.SetActive(true);
        endGamePanel.SetActive(false);
    }

    private void Update() {
        if (levelTime > 0) {
            levelTime -= Time.deltaTime;
            pointsText.text = score.ToString();
            int levelTimeInt = (int)levelTime;
            timeText.text = (levelTimeInt / 60).ToString("00") + ":" + (levelTimeInt % 60).ToString("00");
        } else {
            playing = false;
            ShowEndGameUI();
        }

        if (levelTime <= 39f && !changedMusic) {
            changedMusic = true;
            audioSource.Stop();
            audioSource.clip = musicFast;
            audioSource.loop = false;
            audioSource.Play();
        }

    }

    public void ShowEndGameUI() {
        endGamePoints.text = score.ToString();
        gamePanel.SetActive(false);
        endGamePanel.SetActive(true);
        Cursor.lockState = CursorLockMode.None;
    }

    public void PlayAgain() {
        SceneManager.LoadScene(0);
    }

}
