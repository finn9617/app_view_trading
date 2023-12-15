import 'package:flutter/material.dart';
import 'package:app_view_trading/core/constants/color/color_constant.dart';
import 'package:app_view_trading/core/extension/context_extension.dart';
import 'package:app_view_trading/product/init/locale/project_keys.dart';

class GlobalAverageDropdownButton extends StatelessWidget {
  const GlobalAverageDropdownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.marinique,
        borderRadius: context.mediumCircular,
      ),
      child: Padding(
        padding: context.halfVerticalxSmallPad,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isDense: true,
            padding: EdgeInsets.zero,
            value: ProjectKeys.globalAverage,
            iconEnabledColor: ProjectColors.white,
            borderRadius: context.mediumCircular,
            style: context.poonMediumTheme,
            items: const [
              DropdownMenuItem(
                value: ProjectKeys.globalAverage,
                child: Text(ProjectKeys.globalAverage),
              ),
              DropdownMenuItem(
                value: ProjectKeys.appName,
                child: Text(ProjectKeys.appName),
              )
            ],
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
