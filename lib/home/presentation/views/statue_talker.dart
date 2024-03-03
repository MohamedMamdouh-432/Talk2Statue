import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/conversation/presentation/views/conversation_page.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/bloc/home_states.dart';
import 'package:talk2statue/home/presentation/widgets/curved_appbar.dart';

class StatueTalker extends StatelessWidget {
  static const String routeName = '/statuetaker';
  const StatueTalker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        preferredSize: Size.fromHeight(context.height * 0.14),
      ),
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (BuildContext context, HomeStates state) {
          var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/onboarding3.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Speak to The Statue',
                        style: GoogleFonts.lato(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "When you found statue you wish to see and talk. Imagine being able to converse with the Most Powerful Ancient Egyptian Statues who shaped the past .\n\nHere's the magic:\n\n"
                    "1. Scan and Discover: Simply use your phone's CAMERA to scan any statue or pick one from GALLERY .\n\n"
                    "2. Hear their Story: Once identified, the statue comes to life! Listen as the figure speaks in their own voice, sharing their fascinating story, wisdom, and experiences .",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async => await cubit
                            .selectImageFromCamera(ImageSource.camera),
                        icon: const Icon(Icons.camera_outlined),
                        label: const Text('Scan Statue'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async => await cubit
                            .selectImageFromCamera(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('From Gallery'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: cubit.imageName == null
                          ? null
                          : () => Navigator.pushNamed(
                                context,
                                ConversationPage.routeName,
                              ),
                      style: ElevatedButton.styleFrom(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Let's Begin",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
