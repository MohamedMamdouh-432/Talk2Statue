part of 'conversation_bloc.dart';

sealed class ConversationEvent extends Equatable {
  const ConversationEvent();
  @override
  List<Object> get props => [];
}

class ConversationInitialEvent extends ConversationEvent {
  const ConversationInitialEvent();
  @override
  List<Object> get props => [];
}

class ConversationStatuePreperationEvent extends ConversationEvent {
  final String statueName;
  const ConversationStatuePreperationEvent({
    required this.statueName,
  });
  @override
  List<Object> get props => [
        statueName,
      ];
}

class VisitorStartRecordingEventRequested extends ConversationEvent {
  const VisitorStartRecordingEventRequested();
  @override
  List<Object> get props => [];
}

class VisitorStopRecordingEventRequested extends ConversationEvent {
  const VisitorStopRecordingEventRequested();
  @override
  List<Object> get props => [];
}

class ResetRecordingEventRequested extends ConversationEvent {
  const ResetRecordingEventRequested();
  @override
  List<Object> get props => [];
}

class StatueReplayEventRequested extends ConversationEvent {
  final String speechVoice;
  const StatueReplayEventRequested(this.speechVoice);
  @override
  List<Object> get props => [speechVoice];
}

class StatueTalkingEventRequested extends ConversationEvent {
  const StatueTalkingEventRequested();
  @override
  List<Object> get props => [];
}

class ConversationDisposeEvent extends ConversationEvent {
  const ConversationDisposeEvent();
  @override
  List<Object> get props => [];
}
