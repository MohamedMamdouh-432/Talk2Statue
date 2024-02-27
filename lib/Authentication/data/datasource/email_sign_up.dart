import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';

 signUp(
    {required context, required emailAddress, required password}) async {
  var formData = AppConstants.formState.currentState;
  if (formData!.validate()) {
    print('valod');
    showLoading(context);
    formData.save();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlert(
            context: context,
            title: 'Error',
            body: Text(
              'The password provided is too weak',
              style: TextStyle(fontSize: 16),
            ),
            dialogType: DialogType.error);
      } else if (e.code == 'email-already-in-use') {
        showAlert(
            context: context,
            title: 'Error',
            body: Text(
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
  }
  else{
    print('Not Valid.');
  }
}
