import 'package:flutter/material.dart';
import 'package:app_view_trading/core/constants/color/color_constant.dart';
import 'package:app_view_trading/product/features/conversion/currency_conversion.dart';
import 'package:app_view_trading/view/home/model/crypto.dart';

class EurPriceColored extends StatelessWidget {
  const EurPriceColored({required this.crypto, super.key});
  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Text(
      CurrencyConversion().convertUsdToEuro(crypto.quote?.uSD?.price ?? 0),
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: crypto.quote?.uSD?.percentChange24h
                        .toString()
                        .substring(0, 1) ==
                    '-'
                ? ProjectColors.cabaret
                : ProjectColors.jungleGreen,
          ),
    );
  }
}
