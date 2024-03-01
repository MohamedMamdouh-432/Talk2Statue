part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class OnboardingInitialEvent extends OnboardingEvent {}

class OnboardingChangePageEvent extends OnboardingEvent {
  final int newIdx;

  OnboardingChangePageEvent({
    required this.newIdx,
  });
}

class OnboardingPageNextedEvent extends OnboardingEvent {
  final bool skip;

  OnboardingPageNextedEvent({this.skip = false});
}
