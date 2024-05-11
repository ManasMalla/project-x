import 'package:flutter/material.dart';

class NewVenturePage extends StatelessWidget {
  const NewVenturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 280,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                alignment: Alignment.topLeft,
              ),
              Positioned(
                bottom: -48,
                left: 16,
                child: ClipOval(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: 96,
                    width: 96,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 42,
        ),
      ],
    );
  }
}
