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

class StatueReplayEventRequested extends ConversationEvent {
  final SpeechVoice voiceModel;
  const StatueReplayEventRequested(this.voiceModel);
  @override
  List<Object> get props => [voiceModel];
}

class ConversationDisposeEvent extends ConversationEvent {
  const ConversationDisposeEvent();
  @override
  List<Object> get props => [];
}
