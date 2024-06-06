import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityDemoScreen extends StatefulWidget {
  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen> {
  UnityWidgetController? _unityWidgetController;
  var _filePath;
  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Unity Demo'),
        ),
        body: UnityWidget(
          onUnityCreated: onUnityCreated,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _pickAudioFile();
            _playAudioInUnity();
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
  }

  void _playAudioInUnity() {
    String audioFilePathx =
        "/Internal storage/Subtitles/2016.mp3"; // Replace with your actual path
    // Logic to send audio file path or stream to Unity
    _unityWidgetController!.postMessage(
      'nefertitiQueen', // Replace with your Unity GameObject's name
      'PlayAudioClip', // Replace with your Unity method name
      _filePath, // Replace with the actual audio file path
    );
  }
}
