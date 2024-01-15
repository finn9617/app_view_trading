// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:app_view_trading/view/home/view/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:launcher_icon_switcher/launcher_icon_switcher.dart';

import 'view/home/view/h5.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final storage = const FlutterSecureStorage();
  final _launcherIconSwitcherPlugin = LauncherIconSwitcher();

  bool? isLogo = false;
  @override
  void initState() {
    super.initState();
  }

  initCheck() async {
    await _launcherIconSwitcherPlugin
        .initialize(["favicon1", "favicon"], "favicon");
    await _launcherIconSwitcherPlugin.getCurrentIcon();
    CollectionReference users =
        FirebaseFirestore.instance.collection('appForex');
    final data = await users.doc("app_forex").get();
    Map<String, dynamic> dataFirebase = data.data() as Map<String, dynamic>;
    final iscrytrade = dataFirebase['super'];
    isLogo = await storage.read(key: 'isLogo') == 'true' ? true : false;
    final isFirst = await storage.read(key: 'isFirst') == 'true' ? true : false;
    final changLogo =
        await storage.read(key: 'changelogo') == 'true' ? true : false;

    if (iscrytrade && isFirst) {
      storage.write(key: 'isLogo', value: "true");
      if (changLogo) {
        await storage.write(key: 'changelogo', value: "false");
        await _launcherIconSwitcherPlugin.setIcon("favicon1");
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const H5()));
    } else {
      storage.write(key: 'isFirst', value: "true");
      storage.write(key: 'isLogo', value: "false");
      storage.write(key: 'changelogo', value: "true");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    return true;
  }

  initChangeIcon() async {
    isLogo = await storage.read(key: 'isLogo') == 'true' ? true : false;
    return isLogo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: initChangeIcon(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final logo = snapshot.data as bool;
              return FutureBuilder(
                future: initCheck(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: logo
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
              );
            }));
  }
}
