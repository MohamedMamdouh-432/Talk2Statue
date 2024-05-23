import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talk2statue/authentication/widgets/login_widgets.dart';

signUp(
    {required context,
    required emailAddress,
    required password,
    required formState}) async {
  var formData = formState.currentState;
  if (formData!.validate()) {
    showLoading(context);
    formData.save();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.trim().toString(),
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        showAlert(
            context: context,
            title: 'Error',
            body: Text(
              'The password provided is too weak',
              style: TextStyle(fontSize: 16.sp),
            ),
            dialogType: DialogType.error);
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        showAlert(
            context: context,
            title: 'Error',
            body: const Text(
              'The account already exists for that email.',
              style: TextStyle(fontSize: 16),
            ),
            dialogType: DialogType.error);
      }
    } catch (e) {
      showAlert(
          context: context,
          title: 'Error',
          body: Text('$e'),
          dialogType: DialogType.error);
    }
  } else {
    print('Not Valid.');
  }
}
