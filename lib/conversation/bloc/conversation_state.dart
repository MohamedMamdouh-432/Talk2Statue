part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final String userAudioFilePath;
  final String statueAudioFilePath;
  final ConversationRequestState requestState;
  final String message;
  final String museumName;

  const ConversationState({
    required this.userAudioFilePath,
    required this.statueAudioFilePath,
    required this.message,
    required this.requestState,
    required this.museumName,
  });

  static ConversationState initial = const ConversationState(
    message: 'No Error',
    userAudioFilePath: 'none',
    statueAudioFilePath: 'none',
    museumName: 'Egyptian Museum',
    requestState: ConversationRequestState.Initialized,
  );

  ConversationState copyWith({
    String? userAudioFilePath,
    String? statueAudioFilePath,
    ConversationRequestState? requestState,
    String? message,
    String? museumName,
  }) {
    return ConversationState(
      userAudioFilePath: userAudioFilePath ?? this.userAudioFilePath,
      statueAudioFilePath: statueAudioFilePath ?? this.statueAudioFilePath,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      museumName: museumName ?? this.museumName,
    );
  }

  @override
  List<Object> get props => [
        userAudioFilePath,
        statueAudioFilePath,
        requestState,
        message,
        museumName,
      ];

  @override
  String toString() {
    return 'Statue Conversation State(\n'
        'requestState: $requestState\n'
        'User Question Audio File Path: $userAudioFilePath\n'
        'Statue Response Audio File Path: $statueAudioFilePath\n'
        'Museum Name: $museumName\n'
        'Error Message: $message\n'
        ')';
  }
}
