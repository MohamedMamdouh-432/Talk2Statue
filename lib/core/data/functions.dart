import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/conversation/views/conversation_view.dart';
import 'package:talk2statue/core/utils/app_enums.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';
import 'package:talk2statue/statue_recognition/widgets/statue_capture_window.dart';

void showMessage(BuildContext c, String s, DialogType dType) {
  showAlert(
    context: c,
    title: s,
    body: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        s,
        textScaler: const TextScaler.linear(1.35),
      ),
    ),
    dialogType: dType,
  );
  Future.delayed(const Duration(seconds: 5), () => Navigator.of(c).pop());
}

String extractFileName(String filePath) {
  final file = File(filePath);
  return file.path.split('/').last;
}

Future<String> saveFileLocally(String filePath) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String fileName = filePath.split('/').last;
  final String fPath = '${appDir.path}/$fileName';
  final File newImage = File(filePath);
  await newImage.copy(fPath);
  return fPath;
}

showImageCapturingWindow(BuildContext ctx) {
  return AwesomeDialog(
    context: ctx,
    body: const StatueCapturingWindow(),
    dialogType: DialogType.noHeader,
    btnOk: BlocBuilder<StatueRecognitionBloc, StatueRecognitionState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.requestState !=
                  RecongnitionRequestState.SuccessfulInCapturing
              ? null
              : () {
                  context
                      .read<StatueRecognitionBloc>()
                      .add(const StatueRecognitionEventRequested());
                  Navigator.pop(ctx);
                  Navigator.pushNamed(context, ConversationView.routeName);
                },
          child: const Text(
            'OK',
            textScaler: TextScaler.linear(1.3),
          ),
        );
      },
    ),
    btnCancel: ElevatedButton(
      onPressed: () {
        ctx
            .read<StatueRecognitionBloc>()
            .add(const StatueUndoCapturingEventRequested());
        Navigator.pop(ctx);
      },
      child: const Text(
        'Cancel',
        textScaler: TextScaler.linear(1.3),
      ),
    ),
  ).show();
}
