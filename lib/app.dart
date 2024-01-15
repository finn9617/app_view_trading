import 'package:app_view_trading/splash.dart';
import 'package:flutter/material.dart';
import 'package:app_view_trading/core/init/theme/dark/dark_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ProjectTheme().darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
