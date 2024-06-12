import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/components/conversation_listener.dart';
import 'package:talk2statue/conversation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/widgets/statue_record_button.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/shared/functions.dart';
import 'package:talk2statue/shared/widgets/curved_appbar.dart';
import 'package:talk2statue/conversation/views/statue_image_view.dart';
import 'package:talk2statue/conversation/views/statue_3dmodel_view.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  void initState() {
    context.read<ConversationBloc>().add(ConversationInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return conversationListener(
      child: BlocConsumer<RecognitionBloc, RecognitionState>(
        buildWhen: (prev, cur) => prev != cur,
        listenWhen: (prev, cur) => prev != cur,
        listener: (context, state) {
          if (state.requestState ==
              RecongnitionRequestState.SuccessfulInRecognizing) {
            context.read<ConversationBloc>().add(
                ConversationStatuePreperationEvent(
                    statueName: state.statueName));
          } else if (state.requestState ==
              RecongnitionRequestState.FailedInRecognizing) {
            showMessage(
              // TODO: use another dialog which display error and 'ok' button then getBack
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
                      RecongnitionRequestState.SuccessfulInRecognizing,
                  builder: (_) => Column(
                    children: [
                      ConditionalBuilder(
                        condition:
                            context.read<ConversationBloc>().isModelReady,
                        builder: (_) => const Statue3dModelView(),
                        fallback: (_) => StatueImageView(
                          statueFileImage: state.statueImagePath,
                        ),
                      ),
                      const StatueRecordingButton(),
                    ],
                  ),
                  fallback: (_) => const SizedBox(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
