import 'package:flutter/material.dart';
import 'package:app_view_trading/core/component/text/label_medium_text.dart';
import 'package:app_view_trading/core/constants/color/color_constant.dart';

class FittedMediumLabelText extends StatelessWidget {
  const FittedMediumLabelText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: LabelMediumText(
        color: ProjectColors.white,
        fontWeight: FontWeight.w700,
        text: text,
      ),
    );
  }
}
