import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/utils/app_constants.dart';

class StatueRecordingButton extends StatelessWidget {
  const StatueRecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.requestState ==
                      ConversationRequestState.RecordingStopped ||
                  state.requestState == ConversationRequestState.Prepared
              ? () => context
                  .read<ConversationBloc>()
                  .add(VisitorStartRecordingEventRequested())
              : state.requestState == ConversationRequestState.RecordingStarted
                  ? () => context
                      .read<ConversationBloc>()
                      .add(VisitorStopRecordingEventRequested())
                  : null,
          child: Container(
            height: context.height * 0.25,
            alignment: Alignment.center,
            child: Center(
              child: AvatarGlow(
                repeat: true,
                glowColor: AppConstants.goldColor,
                startDelay: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                animate: state.requestState ==
                        ConversationRequestState.RecordingStarted ||
                    state.requestState ==
                        ConversationRequestState.StatueTalking,
                child: Material(
                  elevation: 20,
                  color: Colors.blueGrey,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      state.requestState ==
                                  ConversationRequestState.RecordingStopped ||
                              state.requestState ==
                                  ConversationRequestState.Prepared
                          ? Icons.mic_outlined
                          : state.requestState ==
                                  ConversationRequestState.RecordingStarted
                              ? Icons.stop_circle
                              : state.requestState ==
                                      ConversationRequestState.StatueTalking
                                  ? Icons.pause_circle
                                  : Icons.mic_off_outlined,
                      size: 50,
                      color: AppConstants.goldColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
