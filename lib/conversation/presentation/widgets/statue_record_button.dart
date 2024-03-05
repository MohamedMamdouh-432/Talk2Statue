import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';

class StatueRecordingButton extends StatelessWidget {
  const StatueRecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.requestState == RequestState.recordingOff ||
                  state.requestState == RequestState.prepared
              ? () => context
                  .read<ConversationBloc>()
                  .add(const VisitorStartRecordingEventRequested())
              : state.requestState == RequestState.recordingOn
                  ? () => context
                      .read<ConversationBloc>()
                      .add(const VisitorStopRecordingEventRequested())
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
                animate: state.requestState == RequestState.recordingOn ||
                    state.requestState == RequestState.statueTalking,
                child: Material(
                  elevation: 20,
                  color: Colors.blueGrey,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      state.requestState == RequestState.recordingOff ||
                              state.requestState == RequestState.prepared
                          ? Icons.mic_outlined
                          : state.requestState == RequestState.recordingOn
                              ? Icons.stop_circle
                              : state.requestState == RequestState.statueTalking
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
