using Cinemachine;
using UnityEngine;

public class CameraMovement : MonoBehaviour {
    private float mouseSensitivity = 150f;
    private float speed = 25f;
    private CinemachineVirtualCamera vcam;
    private float mousex = 0;
    private float mousey = 0;

    private void Start() {
        vcam = GetComponent<CinemachineVirtualCamera>();
    }

    private void Update() {
        mousex = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        mousey = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        Debug.Log(mousex + " " + mousey);

        if (mousex < 20 && mousex > -20 && mousey < 20 && mousey > -20) {

            vcam.transform.parent.transform.Rotate(Vector3.up * mousex);
            float anglex = vcam.transform.rotation.eulerAngles.x;
            anglex = StandarizeAngle(anglex);
            if (anglex > 20) {
                ClampRotationX(vcam.gameObject, 20f);
            } else if (anglex < -20f) {
                ClampRotationX(vcam.gameObject, -20f);
            }

            vcam.transform.Rotate(Vector3.left * mousey);
            float angley = vcam.transform.parent.transform.rotation.eulerAngles.y;
            angley = StandarizeAngle(angley);
            if (angley > 40f) {
                ClampRotationY(vcam.gameObject.transform.parent.gameObject, 40f);
            } else if (angley < -40f) {
                ClampRotationY(vcam.gameObject.transform.parent.gameObject, -40f);
            }
        }
    }

    private void ClampRotationX(GameObject o, float value) {
        Vector3 eulerRotation = o.transform.eulerAngles;
        eulerRotation.x = value;
        o.transform.eulerAngles = eulerRotation;
    }

    private void ClampRotationY(GameObject o, float value) {
        Vector3 eulerRotation = o.transform.eulerAngles;
        eulerRotation.y = value;
        o.transform.eulerAngles = eulerRotation;
    }

    public float StandarizeAngle(float angle) {
        float sign;

        if (angle >= 0) {
            sign = 1;
        } else {
            sign = -1;
        }

        angle = Mathf.Abs(angle);
        angle = angle % 360f;

        if (angle > 181f) {
            angle = (360f - angle) * -1f;
        }

        angle *= sign;

        return angle;

    }
}
