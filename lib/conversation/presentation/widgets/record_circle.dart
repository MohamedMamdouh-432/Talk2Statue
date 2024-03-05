import 'package:flutter/material.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';

class RecordCircle extends StatelessWidget {
  final Widget child;
  final double length;
  const RecordCircle({
    Key? key,
    required this.child,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: length,
      height: length,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppConstants.goldColor,
        ),
      ),
      child: child,
    );
  }
}
