// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:app_view_trading/view/home/view/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_icons/flutter_app_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'view/home/view/h5.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final storage = FlutterSecureStorage();
  bool isLogo = true;
  @override
  void initState() {
    super.initState();
    isLogo = storage.read(key: 'isLogo') == 'true' ? true : false;
  }

  initCheck() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('appForex');
    final data = await users.doc("app_forex").get();
    Map<String, dynamic> dataFirebase = data.data() as Map<String, dynamic>;
    final iscrytrade = dataFirebase['super'];

    if (iscrytrade) {
      storage.write(key: 'isLogo', value: "true");
      if (!isLogo) {
        final _flutterAppIconsPlugin = FlutterAppIcons();
        _flutterAppIconsPlugin.setIcon(
          icon: 'favicon-failure.png',
          oldIcon: 'favicon.png',
        );
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const H5()));
    } else {
      storage.write(key: 'isLogo', value: "false");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: initCheck(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: isLogo
                    ? Image.asset(
                        'assets/playstore-icon.png',
                        width: 100,
                        height: 100,
                      )
                    : Image.asset(
                        'assets/icon.png',
                        width: 100,
                        height: 100,
                      ),
              );
            }
          },
        ));
  }
}
