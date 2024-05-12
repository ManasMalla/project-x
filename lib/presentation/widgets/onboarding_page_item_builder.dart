import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum OnboardingAlignment { top, bottom }

class OnboardingPageItemBuilder extends StatelessWidget {
  final int index;
  final int pageLength;
  final String title;
  final String text;
  final String image;
  final bool isForInvestor;
  final Function() onNext;
  final OnboardingAlignment alignment;
  const OnboardingPageItemBuilder({
    super.key,
    this.index = 0,
    this.pageLength = 10,
    required this.title,
    required this.text,
    required this.image,
    required this.isForInvestor,
    required this.onNext,
    this.alignment = OnboardingAlignment.top,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 48,
        ),
        alignment == OnboardingAlignment.top
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SvgPicture.asset(
                  image,
                  height: 240,
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              const SizedBox(
                width: 36,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...(isForInvestor
                      ? [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "For Investors".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ]
                      : []),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6)),
                  ),
                ],
              ),
            ],
          ),
        ),
        alignment != OnboardingAlignment.top
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SvgPicture.asset(
                  image,
                  height: 240,
                ),
              )
            : const SizedBox(),
        PageViewIndicator(index, pageLength),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: MaterialButton(
            height: 54,
            minWidth: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            onPressed: onNext,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Next",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 96,
        ),
      ],
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  final int index;
  final int pageLength;
  const PageViewIndicator(this.index, this.pageLength, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageLength, (index) {
          return Container(
            width: 14,
            height: 4,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: this.index == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}

class SkipTextButton extends StatelessWidget {
  final Function() onSkip;
  const SkipTextButton({
    super.key,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSkip,
      child: Text(
        "Skip",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class BackTextButton extends StatelessWidget {
  final Function() onBack;

  const BackTextButton({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onBack,
      child: Text(
        "Back",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
