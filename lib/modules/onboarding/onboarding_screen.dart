import 'package:flutter/material.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/modules/onboarding/widgets/page_indicator_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  static const List<OnboardingSlide> _slides = [
    OnboardingSlide(
      titleKey: 'Title 1',
      textKey: 'Here will be some text',
      image: '',
    ),
    OnboardingSlide(
      titleKey: 'Title 2',
      textKey: 'Here will be some text',
      image: '',
    ),
    OnboardingSlide(
      titleKey: 'Title 3',
      textKey: 'Here will be some text',
      image: '',
    ),
  ];
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            _buildSkipButtonWidget(),
            const SizedBox(height: 15.0),
            _buildPageView(),
            const SizedBox(height: 15.0),
            _buildPageIndicatorWidget(),
            const SizedBox(height: 20.0),
            _buildNextButtonWidget(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: _slides.map((s) => _buildOnboardingSlideWidget(s)).toList(),
        onPageChanged: (index) {
          setState(() => _selectedPageIndex = index);
        },
      ),
    );
  }

  Widget _buildOnboardingSlideWidget(OnboardingSlide slide) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Container(
                height: 50,
                width: 50,
                color: Colors.red,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43.0),
          child: Text(
            slide.titleKey,
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43.0),
          child:  Text(
            slide.textKey,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildSkipButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: _onSkipTap,
            child: Text(
              getLocalized(context, 'skip'),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSkipTap() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.logInScreen, (route) => false);
  }

  Widget _buildPageIndicatorWidget() {
    return PagesIndicatorWidget(
      count: _slides.length,
      selectedIndex: _selectedPageIndex,
    );
  }

  Widget _buildNextButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: DesignButton(
              title: getLocalized(context, 'next'),
              onTap: _onNextTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onNextTap() {
    if (_slides.length > _selectedPageIndex + 1) {
      _pageController.animateToPage(_selectedPageIndex + 1,
          duration: Duration(milliseconds: 600), curve: Curves.easeIn);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.logInScreen, (route) => false);
    }
  }
}

class OnboardingSlide {
  final String titleKey;
  final String textKey;
  final String image;

  const OnboardingSlide({this.titleKey, this.textKey, this.image});
}
