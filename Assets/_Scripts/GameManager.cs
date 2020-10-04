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
    public GameObject creditsPanel;
    public GameObject instructionsPanel;
    public TMP_Text endGamePoints;
    public float levelTime = 170;
    public int score = 0;
    private AudioSource audioSource;
    public bool fastMode = false;
    public bool playing = false;
    public int sideToSideItems = 0;
    public SideToSideSpawner sideToSideSpawner;

    private void Awake() {
        instance = this;
        Cursor.lockState = CursorLockMode.None;
        playing = false;
    }

    private void Start() {
        audioSource = GetComponent<AudioSource>();
        audioSource.clip = musicNormal;
        audioSource.loop = true;

        instructionsPanel.SetActive(true);
        gamePanel.SetActive(false);
        endGamePanel.SetActive(false);
        creditsPanel.SetActive(false);
    }

    private void Update() {

        if (playing) {
            if (levelTime > 0) {
                levelTime -= Time.deltaTime;
                pointsText.text = score.ToString();
                int levelTimeInt = (int)levelTime;
                timeText.text = (levelTimeInt / 60).ToString("00") + ":" + (levelTimeInt % 60).ToString("00");
            } else {
                playing = false;
                ShowEndGameUI();
            }

            if (levelTime <= 39f && !fastMode) {
                fastMode = true;
                audioSource.Stop();
                audioSource.clip = musicFast;
                audioSource.loop = false;
                audioSource.Play();
            }

            if (score >= 30 && !sideToSideSpawner.spawning) {
                sideToSideItems = 2;
                sideToSideSpawner.SetSpawning(true);
            }
        }

    }

    public void ShowEndGameUI() {
        endGamePoints.text = score.ToString();
        gamePanel.SetActive(false);
        endGamePanel.SetActive(true);
        Cursor.lockState = CursorLockMode.None;
    }

    public void ShowCreditsPanel() {
        endGamePanel.SetActive(false);
        creditsPanel.SetActive(true);
    }

    public void PlayAgain() {
        SceneManager.LoadScene(0);
    }

    public void StartGame() {
        Cursor.lockState = CursorLockMode.Locked;
        audioSource.Play();
        playing = true;
        instructionsPanel.SetActive(false);
        gamePanel.SetActive(true);
    }

    public void Quit() {
        Application.Quit();
    }

}
