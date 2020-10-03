using UnityEngine;

public class BasicTarget : MonoBehaviour {

    public int score = 10;
    public bool enableFX;
    public ParticleSystem PS_Sparks;
    public ParticleSystem PS_Disk;
    public AudioClip impactSFX;
    public Vector2 pitchShift;
    private AudioSource audioSource;

    private void Start() {
        transform.LookAt(GameManager.instance.player.transform);
        audioSource = GetComponent<AudioSource>();
        audioSource.clip = impactSFX;
    }

    private void OnCollisionEnter(Collision collision) {
        Debug.Log("collision");
        if (collision.gameObject.CompareTag("Chancleta")) {
            Debug.Log("hit");
            GameManager.instance.score += score;
            if (enableFX)
            {
                //random pitch shift
                float randomPitch = Random.Range(pitchShift.x, pitchShift.y);

                audioSource.pitch = randomPitch;
                audioSource.Play();
                
                // Play Particle Systems
                PS_Sparks.Play();
                PS_Disk.Play();
            }
        }
    }
}
