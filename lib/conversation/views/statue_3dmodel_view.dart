import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';

class Statue3dModelView extends StatelessWidget {
  const Statue3dModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: UnityWidget(
        onUnityCreated: (controller) {
          context.read<ConversationBloc>().unityController = controller;
        },
      ),
    );
  }
}
