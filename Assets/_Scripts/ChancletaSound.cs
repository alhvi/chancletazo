using System.Collections.Generic;
using UnityEngine;

public class ChancletaSound : MonoBehaviour {
    public List<SFXElement> hitTarget;
    public List<SFXElement> launch;
    public SFXElement charging;
    public SFXElement hitGlass;
    public SFXElement hitNone;
    private AudioSource audioSource;
    private Chancleta chancla;
    private bool hitSound;

    private void Start() {
        audioSource = GetComponent<AudioSource>();
        chancla = GetComponent<Chancleta>();
        hitSound = false;
    }

    public void PlayLaunch() {
        int strength = GetStrength();
        audioSource.Stop();
        audioSource.clip = launch[strength].clip;
        audioSource.volume = launch[strength].volume;
        audioSource.Play();
    }

    public void PlayHit() {
        int strength = GetStrength();
        audioSource.Stop();
        audioSource.clip = hitTarget[strength].clip;
        audioSource.volume = hitTarget[strength].volume;
        audioSource.Play();
        hitSound = true;
    }

    public void PlayCharging() {
        audioSource.Stop();
        audioSource.clip = charging.clip;
        audioSource.volume = charging.volume;
        audioSource.Play();
    }

    public void PlayGlass() {
        audioSource.Stop();
        audioSource.clip = hitGlass.clip;
        audioSource.volume = hitGlass.volume;
        audioSource.Play();
    }

    public void PlayHitDefault() {
        if (!hitSound) {
            audioSource.Stop();
            audioSource.clip = hitNone.clip;
            audioSource.volume = hitNone.volume;
            audioSource.Play();
            hitSound = false;
        }
    }

    private int GetStrength() {
        int result = 0;
        float forcePercentage = chancla.force / chancla.maxForce;
        if (forcePercentage < 0.6) {
            result = 0;
        } else if (forcePercentage < 0.8) {
            result = 1;
        } else if (forcePercentage <= 1) {
            result = 2;
        }

        return result;
    }
}

[System.Serializable]
public class SFXElement {
    public AudioClip clip;
    public float volume;
}
