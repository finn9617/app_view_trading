// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:io';

import 'package:app_view_trading/view/home/view/home_page.dart';
import 'package:changeicon/changeicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dbHelper/mongoDB.dart';
import 'view/home/view/h5.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final storage = const FlutterSecureStorage();
  final _changeiconPlugin = Changeicon();
  String h5 = "https://m.citifutures.cc/";
  bool? isLogo = false;
  bool? iscrytrade;
  @override
  void initState() {
    super.initState();
  }

  initCheck() async {
    isLogo = await storage.read(key: 'isLogo') == 'true' ? true : false;
    if (iscrytrade!) {
      storage.write(key: 'isLogo', value: "true");
      if (Platform.isAndroid) {
        storage.write(key: 'isFirst', value: "true");
        await storage.write(key: 'changelogo', value: "false");
        Changeicon.initialize(
          classNames: ['favicon1', 'favicon'],
        );
        _changeiconPlugin.switchIconTo(classNames: ["favicon1", '']);
      } else {
        try {
          if (await FlutterDynamicIcon.supportsAlternateIcons) {
            await Changeicon.setAlternateIconName("favicon1", showAlert: false);
            return;
          }
        } on PlatformException {
        } catch (e) {}
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => H5(
                    h5: h5,
                  )));
    } else {
      storage.write(key: 'isFirst', value: "false");
      storage.write(key: 'isLogo', value: "false");
      storage.write(key: 'changelogo', value: "true");
      if (Platform.isAndroid) {
        storage.write(key: 'isFirst', value: "true");
        await storage.write(key: 'changelogo', value: "false");
        Changeicon.initialize(
          classNames: ['favicon1', 'favicon'],
        );
        _changeiconPlugin.switchIconTo(classNames: ["favicon", '']);
      } else {
        try {
          if (await FlutterDynamicIcon.supportsAlternateIcons) {
            await Changeicon.setAlternateIconName("trading", showAlert: false);
            return;
          }
        } on PlatformException {
        } catch (e) {}
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    return true;
  }

  initChangeIcon() async {
    iscrytrade = await MongoDatabase.getSuper();
    h5 = await MongoDatabase.getH5();
    return iscrytrade;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff20222c),
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: initChangeIcon(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center();
              }
              final logo = snapshot.data as bool;
              return FutureBuilder(
                future: initCheck(),
                builder: (context, snapshot1) {
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
                },
              );
            }));
  }
}
