import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:talk2statue/authentication/views/sign_in.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/onboarding/components/page_component.dart';
import 'package:talk2statue/shared/services/popback_manager.dart';

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
        body: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state.getStarted) {
              Navigator.pushReplacementNamed(
                context,
                SignInPage.routeName,
              );
            }
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(height: context.height * 0.035),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context
                        .read<OnboardingBloc>()
                        .add(OnboardingPageNextedEvent(skip: true)),
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
                            child: PageComponent(
                              pdata: state.pdataList[state.pageIdx],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context
                      .read<OnboardingBloc>()
                      .add(OnboardingPageNextedEvent()),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      foregroundColor: Colors.white,
                      backgroundColor:
                          AppConstants.primaryColor.withOpacity(0.7)),
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
                    activeColor: AppConstants.primaryColor.withOpacity(0.65),
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
