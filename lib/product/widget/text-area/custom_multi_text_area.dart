import 'package:flutter/material.dart';
import 'package:app_view_trading/core/component/fitted/fitted_label_medium_text.dart';
import 'package:app_view_trading/core/extension/context_extension.dart';
import 'package:app_view_trading/product/widget/fitted/fitted_small_text.dart';

class CustomMultiTextArea extends StatelessWidget {
  const CustomMultiTextArea({
    required this.title,
    required this.description,
    super.key,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.multiTextHeight,
      width: context.quarterWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedSmallLabetTextManatee(text: title),
          FittedMediumLabelText(text: description),
        ],
      ),
    );
  }
}
