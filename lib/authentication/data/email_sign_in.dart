import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk2statue/authentication/widgets/login_widgets.dart';

signIn({
  required context,
  required emailAddress,
  required password,
  required formState,
}) async {
  var formData = formState.currentState;
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  if (formData!.validate()) {
    showLoading(context);
    formData.save();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.trim().toString(),
        password: password,
      );
      await sharedPrefs.setBool('newToApp?', false);
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
          Get.back();
          showAlert(
              context: context,
              title: 'Error',
              body: Text(
                'invalid-email',
                style: TextStyle(fontSize: 16.sp),
              ),
              dialogType: DialogType.error);
          break;
        case 'wrong-password':
          Get.back();
          showAlert(
              context: context,
              title: 'Error',
              body: Text(
                'Wrong password provided for that user',
                style: TextStyle(fontSize: 16.sp),
              ),
              dialogType: DialogType.error);
          break;
        case 'invalid-credential':
          Get.back();
          showAlert(
              context: context,
              title: 'Error',
              body: Text(
                'No user found for that email.',
                style: TextStyle(fontSize: 16.sp),
              ),
              dialogType: DialogType.error);
          break;
        case 'user-disabled':
          Get.back();
          showAlert(
              context: context,
              title: 'Error',
              body: Text(
                'user-disabled',
                style: TextStyle(fontSize: 16.sp),
              ),
              dialogType: DialogType.error);
          break;
      }
    }
  }
}
