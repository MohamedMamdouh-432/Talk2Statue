import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/presentation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/presentation/widgets/statue_record_button.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/presentation/widgets/curved_appbar.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';

class ConversationView extends StatefulWidget {
  static const String routeName = '/conversation';
  const ConversationView({super.key});
  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  void initState() {
    context.read<StatueRecognitionBloc>().add(
          StatueRecognitionEventRequested(
            StatueParams(context.read<HomeCubit>().imagePath!),
          ),
        );
    context.read<ConversationBloc>().add(const ConversationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imgFile = File(context.read<HomeCubit>().imagePath!);
    return BlocListener<ConversationBloc, ConversationState>(
      listenWhen: (prev, cur) => prev != cur,
      listener: (context, state) {
        if (state.requestState == RequestState.recordingCompleted) {
          context
              .read<ConversationBloc>()
              .add(const StatueReplayEventRequested(SpeechVoice.nova));
          showMessage(context, 'Recording is Completed', DialogType.success);
        } else if (state.requestState == RequestState.successful) {
          context
              .read<ConversationBloc>()
              .add(const StatueTalkingEventRequested());
        } else if (state.requestState == RequestState.failure) {
          showMessage(
            context,
            'Oops! Forgive Me , I don\'t Undersatnd your question😅',
            DialogType.error,
          );
          context
              .read<ConversationBloc>()
              .add(const ReinitializationRecordingEventRequested());
        } else if (state.requestState == RequestState.Failed) {
          showMessage(
            context,
            'Oops! Forgive Me , I don\'t Try Again😅',
            DialogType.error,
          );
          context
              .read<ConversationBloc>()
              .add(const ReinitializationRecordingEventRequested());
        } else if (state.requestState == RequestState.Done) {
          context
              .read<ConversationBloc>()
              .add(const ReinitializationRecordingEventRequested());
        }
      },
      child: BlocConsumer<StatueRecognitionBloc, StatueRecognitionState>(
        buildWhen: (prev, cur) => prev != cur,
        listenWhen: (prev, cur) => prev != cur,
        listener: (context, state) {
          if (state.requestState == RequestState.successful) {
            context.read<ConversationBloc>().add(
                  ConversationStatuePreperationEvent(
                    statueName: state.statue.name,
                    statuePronounce:
                        state.statue.gender == 'male' ? 'his' : 'her',
                  ),
                );
          } else if (state.requestState == RequestState.failure) {
            showMessage(
              context,
              'Oops ! ${state.message} \nTry Again after while 😅',
              DialogType.error,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.4),
            appBar: CurvedAppBar(
              preferredSize: Size.fromHeight(context.height * 0.14),
              head: state.requestState == RequestState.successful
                  ? state.statue.name
                  : null,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ConditionalBuilder(
                condition: state.requestState == RequestState.onProgress,
                builder: (_) => const ConversationLoadingIndicator(),
                fallback: (_) => ConditionalBuilder(
                  condition: state.requestState == RequestState.failure,
                  builder: (_) => const SizedBox(),
                  fallback: (_) => ConditionalBuilder(
                    condition: state.requestState == RequestState.successful,
                    builder: (_) => Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: Image.file(
                            imgFile,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            height: context.height * 0.6,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        const StatueRecordingButton(),
                      ],
                    ),
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

  @override
  void dispose() async {
    context.read<ConversationBloc>().add(const ConversationDisposeEvent());
    super.dispose();
  }
}
