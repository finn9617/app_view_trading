import 'package:app_view_trading/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      color: const Color(0xff20222c),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
