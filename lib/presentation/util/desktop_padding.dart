import 'package:flutter/cupertino.dart';

class DesktopPadding extends StatelessWidget {
  final Widget child;
  final bool applyPadding;
  final BoxConstraints? layoutConstraints;
  const DesktopPadding(
      {super.key,
      required this.child,
      this.layoutConstraints,
      this.applyPadding = true});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final _constraints = layoutConstraints ?? constraints;
      return Padding(
          padding: applyPadding
              ? EdgeInsets.symmetric(
                  horizontal: _constraints.maxWidth <= 600
                      ? 0
                      : _constraints.maxWidth <= 840
                          ? 64
                          : 120)
              : EdgeInsets.zero,
          child: child);
    });
  }
}
