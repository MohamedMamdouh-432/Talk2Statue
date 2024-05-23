import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:models_repository/models_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/authentication/widgets/login_widgets.dart';
import 'package:talk2statue/core/utils/route_manager.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/home/widgets/statue_capture_window.dart';

void showMessage(
  BuildContext c,
  String s,
  DialogType dType,
  int durationValue,
) {
  showAlert(
    context: c,
    title: s,
    body: Container(
      height: 120.h,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        s,
        textScaler: const TextScaler.linear(1.4),
      ),
    ),
    dialogType: dType,
  );
  Future.delayed(Duration(seconds: durationValue), () => Navigator.of(c).pop());
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
    btnOk: BlocBuilder<RecognitionBloc, RecognitionState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.requestState !=
                  RecongnitionRequestState.SuccessfulInCapturing
              ? null
              : () {
                  context
                      .read<RecognitionBloc>()
                      .add(UndoCapturingEventRequested());
                  context
                      .read<RecognitionBloc>()
                      .add(RecognitionEventRequested());
                  Get.back();
                  Get.toNamed(RouteManager.conversationRoute);
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
        ctx.read<RecognitionBloc>().add(UndoCapturingEventRequested());
        Get.back();
      },
      child: const Text(
        'Cancel',
        textScaler: TextScaler.linear(1.3),
      ),
    ),
  ).show();
}
