part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final String userAudioFilePath;
  final String statueAudioFilePath;
  final ConversationRequestState requestState;
  final String message;

  const ConversationState({
    this.userAudioFilePath = '',
    this.statueAudioFilePath = '',
    this.message = '',
    this.requestState = ConversationRequestState.Initialized,
  });

  ConversationState copyWith({
    String? userAudioFilePath,
    String? statueAudioFilePath,
    ConversationRequestState? requestState,
    String? message,
  }) {
    return ConversationState(
      userAudioFilePath: userAudioFilePath ?? this.userAudioFilePath,
      statueAudioFilePath: statueAudioFilePath ?? this.statueAudioFilePath,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        userAudioFilePath,
        statueAudioFilePath,
        requestState,
        message,
      ];
}