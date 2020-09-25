using UnityEngine;
using UnityEngine.UI;

public class StrengthMeter : MonoBehaviour {
    public Color startingColor;
    public Color endingColor;
    private Image img;

    private void Start() {
        img = GetComponent<Image>();
        ClearMeter();
    }

    public void UpdateMeter(float percentage) {
        img.color = Color.Lerp(startingColor, endingColor, percentage);
        img.fillAmount = percentage;
    }

    public void ClearMeter() {
        img.color = startingColor;
        img.fillAmount = 0;
    }
}
