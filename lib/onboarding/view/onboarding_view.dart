import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/Authentication/presentation/views/login.dart';
import 'package:talk2statue/core/services/popback_manager.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/onboarding/widgets/page_card.dart';

class OnBoardingView extends StatefulWidget {
  static const String routeName = "/onboardingpage";
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(OnboardingInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopBackManager(
      Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) => Container(
            padding: EdgeInsets.all(AppConstants.screenPadding),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: context.height * 0.04),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context
                        .read<OnboardingBloc>()
                        .add(OnboardingDisposeEvent()),
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder<double>(
                    valueListenable: context.read<OnboardingBloc>().pNotifier,
                    builder: (_, idxValue, __) => PageView.builder(
                      controller: context.read<OnboardingBloc>().pController,
                      itemCount: state.pdataList.length,
                      onPageChanged: (value) => context
                          .read<OnboardingBloc>()
                          .add(OnboardingChangePageEvent(newIdx: value)),
                      itemBuilder: (context, index) => TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween<double>(
                          begin: ((((index - idxValue) * 100.0) *
                                  ((index - idxValue).abs() / 40)) /
                              100.0),
                          end: ((((index - idxValue) * 100.0) *
                                  ((index - idxValue).abs() / 40)) /
                              100.0),
                        ),
                        builder: (_, double rotateVal, child) {
                          return Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, .1)
                              ..rotateY(rotateVal),
                            child: PageCard(
                              pdata: state.pdataList[state.pageIdx],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (state.pageIdx + 1 == state.pdataList.length) {
                      context
                          .read<OnboardingBloc>()
                          .add(OnboardingDisposeEvent());
                      // Navigator.pushReplacementNamed(
                      //     context, AuthenticationScreen.routeName);
                    } else {
                      context
                          .read<OnboardingBloc>()
                          .add(OnboardingPageNextedEvent());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: state.pageIdx + 1 == state.pdataList.length
                      ? const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18),
                        )
                      : const Icon(Icons.arrow_forward_ios_outlined),
                ),
                DotsIndicator(
                  dotsCount:
                      context.read<OnboardingBloc>().state.pdataList.length,
                  position: state.pageIdx,
                  onTap: (value) => context
                      .read<OnboardingBloc>()
                      .add(OnboardingChangePageEvent(newIdx: value)),
                  decorator: DotsDecorator(
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    activeSize: const Size(30, 10),
                    spacing: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
