import 'package:socialpreneur/domain/entity/onboarding_data.dart';

const onboardingData = [
  OnboardingStateHolder(
    "Start investing for\nthe future.",
    "Tristique pretium cum sem\nscelerisque tortor, eget.",
    "assets/images/graphs-statistics.svg",
  ),
  OnboardingStateHolder(
    "Launch your venture\nwith the world.",
    "Tristique pretium cum sem\nscelerisque tortor, eget.",
    "assets/images/launch-venture.svg",
  ),
  OnboardingStateHolder(
    "Network with\nlike-minded people.",
    "connect, exchange ideas, and\ncollaborate on new initiatives",
    "assets/images/collaborate.svg",
  ),
  OnboardingStateHolder(
    "Share your\nproject milestones",
    "Tristique pretium cum sem\nscelerisque tortor, eget.",
    "assets/images/newsletter-model.svg",
  ),
  OnboardingStateHolder(
    "We'll make sure your\ninvestment's safe.",
    "financial metrics help investors\nmake informed decisions",
    "assets/images/telescope-viewing.svg",
    isForInvestor: true,
  ),
  OnboardingStateHolder(
      "With data-driven\nanalytics tool",
      "evaluates the social and\nenvironmental impact",
      "assets/images/analyze-data-driven.svg",
      isForInvestor: true),
];
