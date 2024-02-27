import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/data/datasource/validate_input.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

PreferredSizeWidget? loginAppBar(title) {
  return AppBar(
    title: Text(title),
  );
}

Widget customFormField(
    { controller, required hint, required icon, obscureText = false}) {
  return Form(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        validator: validateInput,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: AppConstants.goldColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: AppConstants.goldColor),
          ),
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 19),
          hintText: hint,
          hoverColor: Colors.black,
          suffixIcon: icon,
        ),
      ),
    ),
  );
}

Widget customButton({required buttonFunction, required title}) {
  return Container(
    width: 200, // Adjust width as needed
    height: 50, // Adjust height as needed
    decoration: BoxDecoration(
      borderRadius:
          BorderRadius.circular(30.0), // Adjust the border radius as needed
      gradient: LinearGradient(
        colors: [
          AppConstants.goldColor,
          Colors.white,
          AppConstants.goldColor
        ], // White in the center, gradually transitioning to gold
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: buttonFunction,
        borderRadius:
            BorderRadius.circular(30.0), // Match container's border radius
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black, // Text color
              fontSize: 16, // Text size
              fontWeight: FontWeight.bold, // Text weight
            ),
          ),
        ),
      ),
    ),
  );
}

Widget customTextButton({required title, required buttonFunction}) {
  return TextButton(
    onPressed: buttonFunction,
    child: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
  );
}

 showLoading(context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: SpinKitCubeGrid(
                        color: Color(0xffFFD700),
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

 showAlert({required BuildContext context,required String title ,required Widget body,required dialogType}){
   return AwesomeDialog(context:context,
    title: title,
     body:  body,
     dialogType: dialogType
      ).show();
}
