part of 'onboarding_bloc.dart';

// ignore: must_be_immutable
class OnboardingState extends Equatable {
  int pageIdx;
  bool getStarted;

  List<PageData> pdataList = [
    const PageData(
      imgPath: 'assets/images/onboarding0.jpg',
      title: "Exploring the Secrets of Museum's Heritage",
      desc:
          "Inviting you on a captivating journey through time, where you will uncover the hidden gems of our museum's rich heritage. Immerse yourself in the fascinating stories, traditions, and cultural treasures that have shaped our past",
    ),
    const PageData(
      imgPath: 'assets/images/onboarding1.png',
      title: 'Dive into Statues History By the Lens of Our App',
      desc:
          "Welcome to an immersive journey through the captivating history of statues! With a simple click, you'll unlock a world of knowledge and stories hidden within each remarkable sculpture",
    ),
    const PageData(
      imgPath: 'assets/images/onboarding2.jpg',
      title: 'Bringing Ancient Statues to Life',
      desc:
          "Prepare for an extraordinary encounter as you step into a realm where statues come to life, ready to engage in conversation and share their captivating stories. With our innovative app, the world of art becomes an interactive stage, where history speaks directly to you",
    ),
  ];

  OnboardingState({
    this.pageIdx = 0,
    this.getStarted = false,
  });

  OnboardingState copyWith({int? pageIdx, bool? getStarted}) {
    return OnboardingState(
      pageIdx: pageIdx ?? this.pageIdx,
      getStarted: getStarted ?? this.getStarted,
    );
  }

  @override
  List<Object> get props => [pageIdx, getStarted];
  
  @override
  String toString() => 'OnboardingState(pageIdx: $pageIdx, getStarted: $getStarted)';
}
