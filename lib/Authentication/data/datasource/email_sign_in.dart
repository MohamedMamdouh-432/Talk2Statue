import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';

signIn(
    {required context,
    required emailAddress,
    required password,
    required formState}) async {
  var formData = formState.currentState;
  if (formData!.validate()) {
    showLoading(context);
    formData.save();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.trim().toString(), password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
          Navigator.pop(context);
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
          Navigator.pop(context);
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
          Navigator.pop(context);
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
          Navigator.pop(context);
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
