import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';

void showMessage(
  BuildContext c,
  String s,
  DialogType dType,
) {
  showAlert(
    context: c,
    title: s,
    body: Padding(
      padding: const EdgeInsets.all(40),
      child: Text(s),
    ),
    dialogType: dType,
  );
  // Delay the dismissal of the dialog
  Future.delayed(const Duration(seconds: 5), () {
    Navigator.of(c).pop();
  });
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
  print('File/Image saved at: $fPath');
  return fPath;
}

IconData properIcon(RequestState s) {
  if (s == RequestState.recordingOff)
    return Icons.mic_outlined;
  else if (s == RequestState.recordingOn) return Icons.stop_circle;
  return Icons.mic_off_outlined;
}

Function()? properTapAction(BuildContext c, RequestState s) {
  if (s == RequestState.recordingOff)
    return () => c
        .read<ConversationBloc>()
        .add(const VisitorStartRecordingEventRequested());
  else if (s == RequestState.recordingOn)
    return () => c
        .read<ConversationBloc>()
        .add(const VisitorStopRecordingEventRequested());
  return null;
}
