import 'dart:io';

import 'package:app_view_trading/dbHelper/mongoDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_view_trading/app.dart';
import 'package:app_view_trading/cubit_observer.dart';
import 'package:app_view_trading/view/home/service/get-it/get_it_source.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  GetItSource.setup();
  Bloc.observer = CubitObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff20222c),
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MongoDatabase.connect();
  const storage = FlutterSecureStorage();
  final isFirst = await storage.read(key: 'isFirst') == 'true' ? true : false;
  if (!isFirst) {
    MongoDatabase.updateDownloadApp();
    await storage.write(key: 'isFirst', value: "true");
  }
  MongoDatabase.updateOpenApp();
  runApp(const MyApp());
}
