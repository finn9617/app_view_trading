import 'package:flutter/material.dart';
import 'package:app_view_trading/core/extension/context_extension.dart';
import 'package:app_view_trading/view/_product/tabbar/trading_tab_views.dart';
import 'package:app_view_trading/view/_product/tabbar/trading_tabbar_constants.dart';
import 'package:app_view_trading/view/_product/tabbar/trading_view_tabbars.dart';
import 'package:app_view_trading/view/home/model/crypto.dart';

import '../../../product/widget/divider/medium_full_width_divider.dart';
import '../../_product/widget/appbar/tradingview_app_bar.dart';
import '../../_product/widget/chart/trading_view_widget_chart.dart';

class TradingView extends StatelessWidget {
  const TradingView({required this.crypto, super.key});
  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TradingAppBar(crypto: crypto),
      body: DefaultTabController(
        length: TabbarConstants.tabbarItems.length,
        child: SizedBox(
          height: context.bodyHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TradingViewWidgetChart(crypto: crypto),
             ],
          ),
        ),
      ),
    );
  }
}
