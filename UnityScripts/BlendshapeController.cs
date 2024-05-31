using System.Collections;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;

// Add this using directive
using System;

public class BlendshapeController : MonoBehaviour
{
    public SkinnedMeshRenderer skinnedMeshRenderer;
    public AudioSource audioSource;

    private void Update()
    {
        if (audioSource.isPlaying)
        {
            float[] spectrum = new float[256];
            audioSource.GetSpectrumData(spectrum, 0, FFTWindow.Rectangular);
            float sum = 0f;

            for (int i = 0; i < spectrum.Length; i++)
            {
                sum += spectrum[i];
            }

            float averageVolume = sum / spectrum.Length;

            // Ensure blendshape weights are capped at 100
            skinnedMeshRenderer.SetBlendShapeWeight(0, Mathf.Clamp(averageVolume * 100, 0, 100)); // `ah`
            skinnedMeshRenderer.SetBlendShapeWeight(1, Mathf.Clamp(averageVolume * 50, 0, 100));  // `ch`
            skinnedMeshRenderer.SetBlendShapeWeight(2, Mathf.Clamp(Mathf.Sin(Time.time * 2f) * 50f + 50f, 0, 100)); // `blink`
            skinnedMeshRenderer.SetBlendShapeWeight(3, Mathf.Clamp(averageVolume * 75, 0, 100));  // `kiss`
        }
    }

    public void PlayAudioClip(string path)
    {
        Debug.Log("PlayAudioClip called with path: " + path);
        StartCoroutine(LoadAudio(path));
    }

    private IEnumerator LoadAudio(string path)
    {
        if (!File.Exists(path))
        {
            Debug.LogError("File not found at path: " + path);
            yield break;
        }

        string uri = "file://" + Uri.EscapeUriString(path);
        Debug.Log("Loading audio from URI: " + uri);

        using (UnityWebRequest www = UnityWebRequestMultimedia.GetAudioClip(uri, AudioType.MPEG))
        {
            yield return www.SendWebRequest();

            if (www.result != UnityWebRequest.Result.Success)
            {
                Debug.LogError("Error loading audio: " + www.error);
            }
            else
            {
                audioSource.clip = DownloadHandlerAudioClip.GetContent(www);
                Debug.Log("Audio clip loaded and ready to play.");
                audioSource.Play();
            }
        }
    }
}
