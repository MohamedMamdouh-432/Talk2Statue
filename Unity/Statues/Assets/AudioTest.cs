using UnityEngine;
// using UnityEngine.SceneManagement;
public class AudioTest : MonoBehaviour
{
    public BlendshapeController blendshapeController;

    void Start()
    {
        string audioFilePath = @"C:\Users\pc\Desktop\2016.mp3";
        blendshapeController.PlayAudioClip(audioFilePath);
        // Debug.log("Nefertiti Queen Scene Start Lanuching ...");
    }

    void PlayAud(string filePath){
        // Debug.log("Unity Played");
        string audioFilePath = @filePath;
        blendshapeController.PlayAudioClip(audioFilePath);
    }

    void Update() {
        if (Input.GetKeyUp(KeyCode.Space)) {
            // Debug.log("Unity Space");
        }
    }
}
