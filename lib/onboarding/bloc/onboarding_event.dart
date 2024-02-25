part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {}

class OnboardingInitialEvent extends OnboardingEvent {}

class OnboardingChangePageEvent extends OnboardingEvent {
  final int newIdx;

  OnboardingChangePageEvent({
    required this.newIdx,
  });
}

class OnboardingPageNextedEvent extends OnboardingEvent {}
// make dispose event

class OnboardingDisposeEvent extends OnboardingEvent {}
