import 'package:app_view_trading/splash.dart';
import 'package:flutter/material.dart';
import 'package:app_view_trading/core/init/theme/dark/dark_theme.dart';
import 'package:app_view_trading/view/home/view/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ProjectTheme().darkTheme,
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
