using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FlutterUnityIntegration;

public class UnityToFlutterCommunicator : MonoBehaviour
{
    void Start()
    {
        // Example: Send a message to Flutter when the game starts
        SendMessageToFlutter("Game Started");
    }

    // Example: Send a message to Flutter when a specific event happens
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            SendMessageToFlutter("Space key pressed");
        }
    }

    // Method to send a message to Flutter
    public void SendMessageToFlutter(string message)
    {
        UnityMessageManager.Instance.SendMessageToFlutter(message);
    }

    // Method to receive messages from Flutter
    public void ReceiveMessage(string message)
    {
        Debug.Log("Message from Flutter: " + message);
        // Process the message and send a response back to Flutter
        string responseMessage = "Received your message: " + message;
        UnityMessageManager.Instance.SendMessageToFlutter(responseMessage);
    }
}