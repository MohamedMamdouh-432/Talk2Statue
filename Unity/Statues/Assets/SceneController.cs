using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneController : MonoBehaviour
{
    public void LoadSceneByStatue(string statueId)
    {
        if (statueId == "Nefertiti")
        {
            SceneManager.LoadScene("Nefertiti");
        }
        else if (statueId == "Akhenaten")
        {
            SceneManager.LoadScene("Akhenaten");
        }
        else
        {
            Debug.LogWarning("Statue ID not recognized.");
        }
    }
}
