// Class cha: quan ly cac page con, di chuyen giua cac page con

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/onboarding/onboarding_child_page.dart';
import 'package:todo_app/ui/welcome/welcome_page.dart';
import 'package:todo_app/utils/enums/onboarding_page_position.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page1,
            nextOnPressed: () {
              _pageController.jumpToPage(1);
            },
            backOnPressed: () {},
            skipOnPressed: () {
              _markOnboardingCompleted();
              _goToWelcomePage();
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page2,
            nextOnPressed: () {
              _pageController.jumpToPage(2);
            },
            backOnPressed: () {
              _pageController.jumpToPage(0);
            },
            skipOnPressed: () {
              _markOnboardingCompleted();
              _goToWelcomePage();
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page3,
            nextOnPressed: () {
              _markOnboardingCompleted();
              _goToWelcomePage();
            },
            backOnPressed: () {
              _pageController.jumpToPage(1);
            },
            skipOnPressed: () {
              _markOnboardingCompleted();
              _goToWelcomePage();
            },
          ),
        ],
      ),
    );
  }

  void _goToWelcomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(isFirstTimeInstall: true),
      ),
    );
  }

  Future<void> _markOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("kOnboardingCompleted", true);
    } catch (e) {
      //print(e);
      return;
    }
  }
}
