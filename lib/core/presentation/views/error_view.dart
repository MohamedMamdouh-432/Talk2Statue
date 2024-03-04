import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            color: Color.fromARGB(255, 130, 35, 28),
            size: 50,
          ),
          Text(
            errorMessage,
            textScaler: const TextScaler.linear(1.8),
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 130, 35, 28),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
