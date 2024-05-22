import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/widgets/statue_record_button.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/shared/data/functions.dart';
import 'package:talk2statue/shared/widgets/curved_appbar.dart';

class ConversationView extends StatefulWidget {
  static const String routeName = '/conversation';
  const ConversationView({super.key});
  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  void initState() {
    context.read<ConversationBloc>().add(const ConversationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationBloc, ConversationState>(
      listenWhen: (prev, cur) => prev != cur,
      listener: (context, state) {
        if (state.requestState == ConversationRequestState.RecordingCompleted) {
          String voiceSound;
          if (context.read<RecognitionBloc>().state.statueGender == 'male')
            voiceSound = ApiConstants.maleVoices[Random().nextInt(4)];
          else
            voiceSound = ApiConstants.femaleVoices[Random().nextInt(2)];
          context
              .read<ConversationBloc>()
              .add(StatueReplayEventRequested(voiceSound));
          showMessage(context, 'Recording is Completed', DialogType.success, 2);
        } else if (state.requestState == ConversationRequestState.Successful) {
          context
              .read<ConversationBloc>()
              .add(const StatueTalkingEventRequested());
        } else if (state.requestState == ConversationRequestState.Failure) {
          showMessage(
            context,
            'Oops! Forgive Me , I don\'t Undersatnd your question😅',
            DialogType.error,
            2,
          );
          context
              .read<ConversationBloc>()
              .add(const ResetRecordingEventRequested());
        } else if (state.requestState == ConversationRequestState.Failed) {
          showMessage(
            context,
            'Oops! Forgive Me , I don\'t Try Again😅',
            DialogType.error,
            2,
          );
          context
              .read<ConversationBloc>()
              .add(const ResetRecordingEventRequested());
        } else if (state.requestState == ConversationRequestState.Done) {
          context
              .read<ConversationBloc>()
              .add(const ResetRecordingEventRequested());
        }
      },
      child: BlocConsumer<RecognitionBloc, StatueRecognitionState>(
        buildWhen: (prev, cur) => prev != cur,
        listenWhen: (prev, cur) => prev != cur,
        listener: (context, state) {
          if (state.requestState ==
              RecongnitionRequestState.SuccessfulInRecognizing) {
            context.read<ConversationBloc>().add(
                  ConversationStatuePreperationEvent(
                    statueName: state.statueName,
                  ),
                );
          } else if (state.requestState ==
              RecongnitionRequestState.FailedInRecognizing) {
            showMessage(
              context,
              'Oops ! ${state.message} \nTry Again after while 😅',
              DialogType.error,
              2,
            );
            Get.back();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.4),
            appBar: CurvedAppBar(
              preferredSize: Size.fromHeight(context.height * 0.14),
              head: state.requestState ==
                      RecongnitionRequestState.SuccessfulInRecognizing
                  ? state.statueName
                  : null,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ConditionalBuilder(
                condition:
                    state.requestState == RecongnitionRequestState.OnProgress,
                builder: (_) => const ConversationLoadingIndicator(),
                fallback: (_) => ConditionalBuilder(
                  condition: state.requestState ==
                      RecongnitionRequestState.FailedInRecognizing,
                  builder: (_) => const SizedBox(),
                  fallback: (_) => ConditionalBuilder(
                    condition: state.requestState ==
                        RecongnitionRequestState.SuccessfulInRecognizing,
                    builder: (_) {
                      final File statueImageFile = File(state.statueImagePath);
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: Image.file(
                              statueImageFile,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                              height: context.height * 0.6,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          const StatueRecordingButton(),
                        ],
                      );
                    },
                    fallback: (_) => const SizedBox(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
