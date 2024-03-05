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
  final String statuePronounce;
  const ConversationStatuePreperationEvent({
    required this.statueName,
    required this.statuePronounce,
  });
  @override
  List<Object> get props => [
        statueName,
        statuePronounce,
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

class ReinitializationRecordingEventRequested extends ConversationEvent {
  const ReinitializationRecordingEventRequested();
  @override
  List<Object> get props => [];
}

class StatueReplayEventRequested extends ConversationEvent {
  final SpeechVoice voiceModel;
  const StatueReplayEventRequested(this.voiceModel);
  @override
  List<Object> get props => [voiceModel];
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
