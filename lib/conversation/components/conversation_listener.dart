import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/shared/functions.dart';

BlocListener<ConversationBloc, ConversationState> conversationListener({
  required Widget child,
}) {
  return BlocListener<ConversationBloc, ConversationState>(
    listenWhen: (prev, cur) => prev != cur,
    listener: (context, state) {
      if (state.requestState == ConversationRequestState.RecordingCompleted) {
        context.read<ConversationBloc>().add(StatueReplayEventRequested());
        showMessage(context, 'Recording is Completed', DialogType.success, 2);
      } else if (state.requestState == ConversationRequestState.Successful) {
        context.read<ConversationBloc>().add(StatueTalkingEventRequested(
            context.read<RecognitionBloc>().state.statueName));
      } else if (state.requestState == ConversationRequestState.Failure) {
        showMessage(
          context,
          'Oops! Forgive Me , I don\'t Undersatnd your question😅',
          DialogType.error,
          2,
        );
        context.read<ConversationBloc>().add(ResetRecordingEventRequested());
      } else if (state.requestState == ConversationRequestState.Failed) {
        showMessage(
          context,
          'Oops! Forgive Me , I don\'t Try Again😅',
          DialogType.error,
          2,
        );
        context.read<ConversationBloc>().add(ResetRecordingEventRequested());
      } else if (state.requestState == ConversationRequestState.Done) {
        context.read<ConversationBloc>().add(ResetRecordingEventRequested());
      }
    },
    child: child,
  );
}
