import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialpreneur/data/static/onboarding_state_holder.dart';
import 'package:socialpreneur/presentation/page/home_page.dart';
import 'package:socialpreneur/presentation/page/login_page.dart';
import 'package:socialpreneur/presentation/widgets/onboarding_page_item_builder.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
  });

  void onOnboardingComplete(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leadingWidth: 96,
        leading: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            BackTextButton(
              onBack: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          SkipTextButton(
            onSkip: () {
              onOnboardingComplete(context);
            },
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: OnboardingPageItemBuilder(
                index: index,
                title: onboardingData[index].title,
                text: onboardingData[index].text,
                image: onboardingData[index].image,
                isForInvestor: onboardingData[index].isForInvestor,
                alignment: index % 2 == 1
                    ? OnboardingAlignment.bottom
                    : OnboardingAlignment.top,
                pageLength: onboardingData.length,
                onNext: () {
                  if (index != onboardingData.length - 1) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  } else {
                    onOnboardingComplete(context);
                  }
                }),
          );
        },
        itemCount: onboardingData.length,
      ),
    );
  }
}
