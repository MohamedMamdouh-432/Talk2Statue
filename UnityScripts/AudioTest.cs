using UnityEngine;

public class AudioTest : MonoBehaviour
{
    void Start()
    {
        BlendshapeController controller = GetComponent<BlendshapeController>();
        controller.PlayAudioClip(@"E:\Collage\My GP\Tasks\Task 7\Search for Code (C#)\2016.mp3");
    }
}
