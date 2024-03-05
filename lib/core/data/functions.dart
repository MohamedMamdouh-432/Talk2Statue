import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';

void showMessage(BuildContext c, String s, DialogType dType) {
  showAlert(
    context: c,
    title: s,
    body: Padding(
      padding: const EdgeInsets.all(40),
      child: Text(s),
    ),
    dialogType: dType,
  );
  Future.delayed(const Duration(seconds: 4), () => Navigator.of(c).pop());
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
