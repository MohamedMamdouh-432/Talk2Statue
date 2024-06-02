import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class HomeViewx extends StatelessWidget {
  HomeViewx({super.key});
  late UnityWidgetController _controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          bottom: false,
          child: WillPopScope(
            onWillPop: null,
            child: Container(
              color: Colors.yellow,
              child: UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: (msg) =>
                    print("Received message from unity: ${msg.toString()}"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onUnityCreated(UnityWidgetController controller) {
    _controller = controller;
  }
}
