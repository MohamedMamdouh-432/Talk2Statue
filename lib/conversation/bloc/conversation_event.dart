part of 'conversation_bloc.dart';

sealed class ConversationEvent extends Equatable {
  const ConversationEvent();
  @override
  List<Object> get props => [];
}

class ConversationInitialEvent extends ConversationEvent {}

class ConversationStatuePreperationEvent extends ConversationEvent {
  final String statueName;
  const ConversationStatuePreperationEvent({
    required this.statueName,
  });
  @override
  List<Object> get props => [statueName];
}

class VisitorStartRecordingEventRequested extends ConversationEvent {}

class VisitorStopRecordingEventRequested extends ConversationEvent {}

class ResetRecordingEventRequested extends ConversationEvent {}

class StatueReplayEventRequested extends ConversationEvent {
  final String speechVoice;
  const StatueReplayEventRequested(this.speechVoice);
  @override
  List<Object> get props => [speechVoice];
}

class StatueTalkingEventRequested extends ConversationEvent {
  final String statueName;
  const StatueTalkingEventRequested(this.statueName);
  @override
  List<Object> get props => [statueName];
}

class ConversationDisposeEvent extends ConversationEvent {}
