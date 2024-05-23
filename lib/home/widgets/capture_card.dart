import 'package:flutter/material.dart';
import 'package:talk2statue/core/utils/app_constants.dart';

class CaptureCard extends StatelessWidget {
  final IconData iconData;
  final String labelData;
  final Function() captureAction;

  const CaptureCard({
    Key? key,
    required this.iconData,
    required this.labelData,
    required this.captureAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: captureAction,
      child: Column(
        children: [
          Icon(
            iconData,
            size: 40,
            color: AppConstants.kohlyColor,
          ),
          const SizedBox(height: 5),
          Text(
            labelData,
            textScaler: const TextScaler.linear(1.5),
            style: const TextStyle(color: AppConstants.kohlyColor),
          )
        ],
      ),
    );
  }
}
