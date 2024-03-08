import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/statue_recognition/presentation/bloc/statue_recognition_bloc.dart';
import 'package:talk2statue/statue_recognition/presentation/widgets/capture_card.dart';

class StatueCapturingWindow extends StatelessWidget {
  const StatueCapturingWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Choose Statue',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppConstants.kohlyColor,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CaptureCard(
              labelData: 'Camera',
              iconData: Icons.camera_alt_outlined,
              captureAction: () => context
                  .read<StatueRecognitionBloc>()
                  .add(const StatueCapturingEventRequested(ImageSource.camera)),
            ),
            CaptureCard(
              labelData: 'Gallery',
              iconData: Icons.photo_outlined,
              captureAction: () => context.read<StatueRecognitionBloc>().add(
                  const StatueCapturingEventRequested(ImageSource.gallery)),
            ),
          ],
        ),
      ],
    );
  }
}
