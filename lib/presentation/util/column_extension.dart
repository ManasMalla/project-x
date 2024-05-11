import 'package:flutter/material.dart';

extension ColumnExtension on Column {
  Column childrenPadding(EdgeInsets padding) {
    return Column(
      children: children
          .map((e) => Padding(
                padding: padding,
                child: e,
              ))
          .toList(),
    );
  }
}
