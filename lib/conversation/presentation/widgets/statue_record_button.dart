import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/presentation/widgets/record_circle.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';

class StatueRecordingButton extends StatelessWidget {
  const StatueRecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (pre, cur) => pre != cur,
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
            width: 200,
            // color: Colors.teal,
            alignment: Alignment.center,
            child: Center(
              child: Stack(
                children: [
                  RecordCircle(
                    length: 100,
                    child: Icon(
                      state.requestState == RequestState.recordingOff ||
                              state.requestState == RequestState.prepared
                          ? Icons.mic_outlined
                          : state.requestState == RequestState.recordingOn
                              ? Icons.stop_circle
                              : state.requestState == RequestState.statueTalking
                                  ? Icons.pause_circle
                                  : Icons.mic_off_outlined,
                      size: 65,
                      color: Colors.amber,
                    ),
                  ),
                  if (state.requestState == RequestState.recordingOn ||
                      state.requestState == RequestState.statueTalking) ...[
                    for (int i = 1; i <= 5; i++)
                      Positioned(
                        top: i * 5 - 10,
                        left: i * 5 - 10,
                        right: i * 5 - 10,
                        bottom: i * 5 - 10,
                        child: RecordCircle(
                          length: i * 10 + 100,
                          child: SizedBox(
                            height: i * 10 + 100,
                            width: i * 10 + 100,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
