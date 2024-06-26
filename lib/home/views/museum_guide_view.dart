import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/core/utils/route_manager.dart';

class MuseumGuideView extends StatelessWidget {
  const MuseumGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/museum2.jpg',
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
                    margin: const EdgeInsets.only(bottom: 10),
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
                        Center(
                          child: Text(
                            'Learn about Museum History',
                            softWrap: true,
                            style: GoogleFonts.lato(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text:
                            "When you come to a museum and want to learn about the history and civilization of the museum. ",
                        style: AppConstants.normalStyle,
                        children: [
                          TextSpan(
                            text:
                                "Hence, the Ancient Egyptian Statues will be the guide and spokesperson for that museum and its ancient history .\n",
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
                          text: '1. Choose',
                          style: AppConstants.boldStyle,
                        ),
                        TextSpan(
                          text:
                              ": Simply you can just pick the museum from listed museums",
                          style: AppConstants.normalStyle,
                        ),
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
                          text: ' and ',
                          style: AppConstants.normalStyle,
                        ),
                        TextSpan(
                          text: 'Concentrate',
                          style: AppConstants.boldStyle,
                        ),
                        TextSpan(
                          text:
                              ": Once Museum Detected, There will be a Statue will talks to you and tells you ",
                          style: AppConstants.normalStyle,
                        ),
                        TextSpan(
                          text:
                              "Museum History, Heritage, Rare artifacts and Statues it contains.",
                          style: AppConstants.boldStyle,
                        ),
                        TextSpan(
                          text: "You can also speak to statue about anything.",
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
      bottomNavigationBar: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: state.museumName,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    onChanged: (value) => context
                        .read<ConversationBloc>()
                        .add(MuseumNameChangedEvent(value!)),
                    borderRadius: BorderRadius.circular(20),
                    items: List.generate(
                      museumList.length,
                      (index) => DropdownMenuItem<String>(
                        value: museumList[index],
                        child: Text(museumList[index]),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    
                    Get.toNamed(RouteManager.conversationRoute);
                  },
                  icon: const Icon(Icons.start_rounded),
                  label: const Text('Tell me'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
