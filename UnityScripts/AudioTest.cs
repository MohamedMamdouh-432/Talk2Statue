using UnityEngine;

public class AudioTest : MonoBehaviour
{
    public BlendshapeController blendshapeController;

    void Start()
    {
        string audioFilePath = @"C:\Users\pc\Desktop\2016.mp3";
        blendshapeController.PlayAudioClip(audioFilePath);
    }
}
