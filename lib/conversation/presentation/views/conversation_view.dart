import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/presentation/components/loading_indicator_component.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/core/presentation/views/error_view.dart';
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
  void dispose() {
    context.read<ConversationBloc>().add(const ConversationDisposeEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imgFile = File(context.read<HomeCubit>().imagePath!);
    return BlocConsumer<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state.requestState == RequestState.recordingCompleted) {
          showMessage(context, 'Recording is Completed', DialogType.success);
          context
              .read<ConversationBloc>()
              .add(const StatueReplayEventRequested(SpeechVoice.nova));
        } else if (state.requestState == RequestState.onProgress) {
          showMessage(context, 'Operation in Progress', DialogType.info);
        } else if (state.requestState == RequestState.successful) {
          showMessage(context, 'Operation is Successful', DialogType.success);
          context
              .read<ConversationBloc>()
              .add(const StatueTalkingEventRequested());
        } else if (state.requestState == RequestState.failure) {
          showMessage(context, 'Failure: ${state.message}', DialogType.error);
        }
      },
      builder: (context, conversationState) {
        return BlocBuilder<StatueRecognitionBloc, StatueRecognitionState>(
          builder: (context, statueState) {
            return Scaffold(
              backgroundColor:
                  statueState.requestState == RequestState.successful
                      ? Colors.white
                      : Colors.grey,
              appBar: CurvedAppBar(
                preferredSize: Size.fromHeight(context.height * 0.14),
                head: statueState.requestState == RequestState.successful
                    ? statueState.statue.name
                    : null,
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: ConditionalBuilder(
                  condition:
                      statueState.requestState == RequestState.onProgress,
                  builder: (_) => const ConversationLoadingIndicator(),
                  fallback: (_) => ConditionalBuilder(
                    condition: statueState.requestState == RequestState.failure,
                    builder: (_) =>
                        ErrorView(errorMessage: statueState.message),
                    fallback: (_) => ConditionalBuilder(
                      condition:
                          statueState.requestState == RequestState.successful,
                      builder: (_) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: Image.file(
                              imgFile,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                              height: context.height * 0.65,
                            ),
                          ),
                          InkWell(
                            onTap: properTapAction(
                              context,
                              conversationState.requestState,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(20),
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.black,
                              ),
                              child: Icon(
                                properIcon(conversationState.requestState),
                                size: 40,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                      fallback: (_) => const SizedBox(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
