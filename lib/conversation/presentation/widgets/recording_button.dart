import 'package:flutter/material.dart';

class RecordingButton extends StatelessWidget {
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 40),
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.black,
        ),
        child: const Icon(
          Icons.mic_outlined,
          size: 40,
          color: Colors.amber,
        ),
      ),
    );
  }
}
