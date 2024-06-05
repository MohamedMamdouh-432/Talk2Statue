import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class StatueModelView extends StatefulWidget {
  @override
  _StatueModelViewState createState() => _StatueModelViewState();
}

class _StatueModelViewState extends State<StatueModelView> {
  late UnityWidgetController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PopScope(
          onPopInvoked: null,
          child: Container(
            color: Colors.yellow,
            child: UnityWidget(
              onUnityCreated: (controller) {
                _controller = controller;
                log("=============\nUnity Model is Created\n=============");
              },
              onUnityMessage: (msg) {
                log("=============\nUnity Message: ${msg.toString()}\n=============");
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _controller.postMessage(
            'UnityToFlutterCommunicator',
            'ReceiveMessage',
            'Hello from Flutter',
          );
        },
        child: Text(
          'Send To Unity',
          textScaler: TextScaler.linear(2),
        ),
      ),
    );
  }
}
