import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key});
  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  int isRecording = 0;
  String recorededAudioPath = '';
  FlutterSoundRecorder? statueRecorder;

  Future<void> startRecording() async {
    if (statueRecorder == null) return;
    try {
      await statueRecorder!.startRecorder(
        toFile: 'recored_audio.mp3',
        codec: Codec.mp3,
      );
      setState(() => isRecording = 1);
    } catch (e) {
      print('Error starting recording: $e');
    }
  }
  Future<void> stopRecording() async {
    if (statueRecorder == null) return;
    try {
      final filePath = await statueRecorder!.stopRecorder();
      setState(() {
        isRecording = 2;
        recorededAudioPath = filePath!;
      });
      // todo: call stt service from conversation bloc
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isRecording == 1 ? null : startRecording,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.black,
        ),
        child: Icon(
          isRecording == 0 ? Icons.mic_outlined : Icons.stop_circle,
          size: 40,
          color: Colors.amber,
        ),
      ),
    );
  }
}
