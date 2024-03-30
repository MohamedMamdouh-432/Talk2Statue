import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk2statue/core/utils/app_constants.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppConstants.erroColor,
            size: 70,
          ),
          const SizedBox(height: 20),
          Text(
            'Oops ! $errorMessage',
            textScaler: const TextScaler.linear(1.8),
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppConstants.erroColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Try Again after while 😅',
            textScaler: const TextScaler.linear(1.8),
            style: GoogleFonts.lato(
              color: AppConstants.erroColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
