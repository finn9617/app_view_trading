import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/base_status.dart';
import '../../../product/init/locale/project_keys.dart';
import '../../tradingview/view/trading_page.dart';
import '../view-model/cubit/crypto_cubit.dart';
import '../view-model/cubit/crypto_state.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}