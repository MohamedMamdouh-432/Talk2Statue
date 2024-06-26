part of 'conversation_bloc.dart';

sealed class ConversationEvent extends Equatable {
  const ConversationEvent();
  @override
  List<Object> get props => [];
}

class ConversationInitialEvent extends ConversationEvent {}

class MuseumInitialEvent extends ConversationEvent {}

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

class StatueReplayEventRequested extends ConversationEvent {}

class StatueTalkingEventRequested extends ConversationEvent {
  final String statueName;
  const StatueTalkingEventRequested(this.statueName);
  @override
  List<Object> get props => [statueName];
}

class ConversationDisposeEvent extends ConversationEvent {}

class ConverstaionUnityControllerIntialized extends ConversationEvent {
  final UnityWidgetController controller;
  const ConverstaionUnityControllerIntialized(this.controller);
  @override
  List<Object> get props => [controller];
}

class MuseumNameChangedEvent extends ConversationEvent {
  final String name;
  const MuseumNameChangedEvent(this.name);
  @override
  List<Object> get props => [name];
}

class MuseumPreparingEvent extends ConversationEvent {}
