using UnityEngine;

public class AudioTest : MonoBehaviour
{
    public BlendshapeController blendshapeController;

    void Start()
    {
        string audioFilePath = @"C:\Users\pc\Desktop\2016.mp3";
        blendshapeController.PlayAudioClip(audioFilePath);
    }

    void loadModelScene(string scene){
        UnityEngine.SceneManagement.SceneManager.LoadScene(scene);
    }

    void PlayAud(string filePath){
        string audioFilePath = @filePath;
        blendshapeController.PlayAudioClip(audioFilePath);
    }
}
