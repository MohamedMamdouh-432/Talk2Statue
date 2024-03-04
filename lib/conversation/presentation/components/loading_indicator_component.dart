import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';

class ConversationLoadingIndicator extends StatelessWidget {
  const ConversationLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: SpinKitPouringHourGlassRefined(
                    color: AppConstants.primaryColor,
                    size: 100,
                    duration: Duration(milliseconds: 1500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
