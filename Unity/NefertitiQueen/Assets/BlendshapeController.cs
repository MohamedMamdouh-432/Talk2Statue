using System.Collections;
using System.IO;
using UnityEngine;

public class BlendshapeController : MonoBehaviour
{
    public SkinnedMeshRenderer skinnedMeshRenderer;
    public AudioSource audioSource;

    private bool isBlinking = false;

    private void Start()
    {
        StartCoroutine(BlinkCoroutine());
    }

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
            float ahWeight = Mathf.Clamp(averageVolume * 10000, 0, 100);
            float chWeight = Mathf.Clamp(averageVolume * 10000, 0, 100);
            float kissWeight = Mathf.Clamp(averageVolume * 10000, 0, 100);

            skinnedMeshRenderer.SetBlendShapeWeight(1, ahWeight); // `ah`
            skinnedMeshRenderer.SetBlendShapeWeight(3, chWeight); // `ch`
            skinnedMeshRenderer.SetBlendShapeWeight(2, kissWeight); // `kiss`

            Debug.Log($"Blendshape Weights - ah: {ahWeight}, ch: {chWeight}, kiss: {kissWeight}");
        }
    }

    private IEnumerator BlinkCoroutine()
    {
        while (true)
        {
            // Blink for 1 second
            float blinkTime = 0.5f;
            float timer = 0f;
            while (timer < blinkTime)
            {
                float blinkWeight = Mathf.Clamp(Mathf.Sin(timer * Mathf.PI / blinkTime) * 100f, 0, 100);
                skinnedMeshRenderer.SetBlendShapeWeight(0, blinkWeight); // `blink`
                timer += Time.deltaTime;
                yield return null;
            }
            skinnedMeshRenderer.SetBlendShapeWeight(0, 0f); // Ensure blink is reset to 0

            // Wait for 3 seconds
            yield return new WaitForSeconds(3f);
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

        Debug.Log("Loading audio from path: " + path);
        
        // Load the audio file from disk
        var audioType = GetAudioTypeFromPath(path);
        if (audioType == AudioType.UNKNOWN)
        {
            Debug.LogError("Unsupported audio type for path: " + path);
            yield break;
        }
        
        using (var www = new WWW("file://" + path))
        {
            yield return www;

            if (!string.IsNullOrEmpty(www.error))
            {
                Debug.LogError("Error loading audio: " + www.error);
            }
            else
            {
                audioSource.clip = www.GetAudioClip(false, true, audioType);
                Debug.Log("Audio clip loaded and ready to play.");
                audioSource.Play();
            }
        }
    }

    private AudioType GetAudioTypeFromPath(string path)
    {
        string extension = Path.GetExtension(path).ToLower();
        switch (extension)
        {
            case ".mp3":
                return AudioType.MPEG;
            case ".wav":
                return AudioType.WAV;
            case ".ogg":
                return AudioType.OGGVORBIS;
            default:
                return AudioType.UNKNOWN;
        }
    }
}


