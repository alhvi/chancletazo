using UnityEngine;

public class BasicTarget : MonoBehaviour {

    public int score = 10;
    public bool enableFX;
    public ParticleSystem PS_Sparks;
    public ParticleSystem PS_Disk;
    public AudioClip impactSFX;
    public Vector2 pitchShift;
    private AudioSource audioSource;
    private TargetDestroyer destroyer;

    private void Start() {
        transform.LookAt(GameManager.instance.player.transform);
        audioSource = GetComponent<AudioSource>();
        audioSource.clip = impactSFX;
        destroyer = GetComponent<TargetDestroyer>();
        if (destroyer == null) {
            destroyer = GetComponentInParent<TargetDestroyer>();
            if (destroyer == null) {
                Debug.Log("No se encontro destroyer");
            }
        }
    }

    private void OnCollisionEnter(Collision collision) {

        if (collision.gameObject.CompareTag("Chancleta")) {
            ChancletaSound soundManager = collision.gameObject.GetComponent<ChancletaSound>();
            GameManager.instance.score += score;
            destroyer.ScheduleDestroy();
            if (enableFX) {
                //random pitch shift
                /*float randomPitch = Random.Range(pitchShift.x, pitchShift.y);

                audioSource.pitch = randomPitch;
                audioSource.Play();*/

                // Play Particle Systems
                PS_Sparks.Play();
                PS_Disk.Play();

                if (soundManager != null) {
                    soundManager.PlayHit();
                }
            }
        }
    }
}
