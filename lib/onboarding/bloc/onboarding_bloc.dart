import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/onboarding/models/pagedata.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  late PageController pController = PageController();
  late ValueNotifier<double> pNotifier = ValueNotifier(0.0);

  OnboardingBloc() : super(OnboardingState()) {
    on<OnboardingInitialEvent>(_onBoradingInitialAction);
    on<OnboardingChangePageEvent>(_onPageChanged);
    on<OnboardingPageNextedEvent>(_onPageNexted);
  }

  void pageListener() => pNotifier.value = pController.page!;

  void _onBoradingInitialAction(event, emit) {
    pController.addListener(pageListener);
    emit(state.copyWith(
      pageIdx: 0,
      getStarted: false,
    ));
  }

  void _onPageChanged(OnboardingChangePageEvent event, emit) {
    pController.animateToPage(
      event.newIdx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    emit(state.copyWith(pageIdx: event.newIdx));
  }

  void _onPageNexted(OnboardingPageNextedEvent event, emit) {
    if (state.pageIdx + 1 == state.pdataList.length || event.skip) {
      _onDispose();
      emit(state.copyWith(
        getStarted: true,
      ));
    } else {
      pController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
      );
      emit(state.copyWith(pageIdx: state.pageIdx + 1));
    }
  }

  void _onDispose() {
    pController.removeListener(pageListener);
    pController.dispose();
    pNotifier.dispose();
  }
}
