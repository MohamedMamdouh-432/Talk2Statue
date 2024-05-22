import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/shared/data/functions.dart';

class TalkToStatueView extends StatelessWidget {
  static const String routeName = '/talk2statueview';
  const TalkToStatueView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecognitionBloc, StatueRecognitionState>(
      listener: (context, state) {
        if (state.requestState == RecongnitionRequestState.FailedInCapturing)
          showMessage(context, state.message, DialogType.error, 2);
        else if (state.requestState ==
            RecongnitionRequestState.SuccessfulInCapturing)
          showMessage(
              context, 'Statue Image Picked Well', DialogType.success, 2);
      },
      child: Scaffold(
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/onboarding3.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  // height: 270.h,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 70),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Card(
                            elevation: 5,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.record_voice_over_outlined,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Speak to The Statue',
                            style: GoogleFonts.lato(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                          text:
                              "When you found statue you wish to see and talk. Imagine being able to converse with the Most ",
                          style: AppConstants.normalStyle,
                          children: [
                            TextSpan(
                              text:
                                  "Powerful Ancient Egyptian Statues who shaped the past .\n",
                              style: AppConstants.boldStyle,
                            ),
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "🤩 Here's the magic :\n",
                        style: AppConstants.normalStyle,
                        children: [
                          TextSpan(
                            text: '1. Scan',
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text: ' and ',
                            style: AppConstants.normalStyle,
                          ),
                          TextSpan(
                            text: 'Discover',
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text: ": Simply use your phone's ",
                            style: AppConstants.normalStyle,
                          ),
                          TextSpan(
                            text: "Camera",
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text: " to scan any statue or pick one from ",
                            style: AppConstants.normalStyle,
                          ),
                          TextSpan(
                            text: "Gallery .\n",
                            style: AppConstants.boldStyle,
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '2. Hear',
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text: ' Their ',
                            style: AppConstants.normalStyle,
                          ),
                          TextSpan(
                            text: 'Story',
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text: ": Once identified, Statue ",
                            style: AppConstants.normalStyle,
                          ),
                          TextSpan(
                            text: "comes to life!",
                            style: AppConstants.boldStyle,
                          ),
                          TextSpan(
                            text:
                                "Listen as the figure speaks in their own voice, sharing their fascinating story, wisdom, and experiences .",
                            style: AppConstants.normalStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.camera_outlined,
              size: 25.sp,
            ),
            label: Text(
              "Let's Begin",
              style: AppConstants.boldStyle.copyWith(fontSize: 15.sp),
            ),
            onPressed: () => showImageCapturingWindow(context),
            style: ElevatedButton.styleFrom(
              elevation: 30,
              foregroundColor: AppConstants.kohlyColor,
              backgroundColor: AppConstants.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
