import 'package:flutter/material.dart';
import 'package:app_view_trading/core/extension/context_extension.dart';
import 'package:app_view_trading/view/home/service/icon-service/get_icon_from_network.dart';

class CryptoIcon extends StatelessWidget {
  const CryptoIcon({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.iconMediumHeight,
      child: Image.network(
        IconNetwork().getIconToNetwork(url),
      ),
    );
  }
}
