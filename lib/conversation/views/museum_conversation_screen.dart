import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/components/conversation_listener.dart';
import 'package:talk2statue/conversation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/views/statue_3dmodel_view.dart';
import 'package:talk2statue/conversation/widgets/statue_record_button.dart';
import 'package:talk2statue/shared/functions.dart';
import 'package:talk2statue/shared/widgets/curved_appbar.dart';

class MuseumConversationScreen extends StatefulWidget {
  const MuseumConversationScreen({super.key});

  @override
  State<MuseumConversationScreen> createState() =>
      _MuseumConversationScreenState();
}

class _MuseumConversationScreenState extends State<MuseumConversationScreen> {
  @override
  void initState() {
    Future.wait([
      Future.delayed(Duration.zero,
          () => context.read<ConversationBloc>().add(MuseumInitialEvent())),
      Future.delayed(Duration.zero,
          () => context.read<ConversationBloc>().add(MuseumPreparingEvent())),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return conversationListener(
      child: BlocConsumer<ConversationBloc, ConversationState>(
        buildWhen: (prev, cur) => prev != cur,
        listenWhen: (prev, cur) => prev != cur,
        listener: (context, state) {
          if (state.requestState == ConversationRequestState.MuseumFailure) {
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
              head: 'Akhenaten',
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ConditionalBuilder(
                condition: state.requestState ==
                        ConversationRequestState.OnProgress ||
                    state.requestState == ConversationRequestState.ModelLoading,
                builder: (_) => const ConversationLoadingIndicator(),
                fallback: (_) => ConditionalBuilder(
                  condition: state.requestState ==
                      ConversationRequestState.MuseumSuccess,
                  builder: (_) => const Column(
                    children: [
                      Statue3dModelView(),
                      StatueRecordingButton(),
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
