import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_view_trading/app.dart';
import 'package:app_view_trading/cubit_observer.dart';
import 'package:app_view_trading/view/home/service/get-it/get_it_source.dart';

import 'firebase_options.dart';

Future<void> main() async {
  GetItSource.setup();
  Bloc.observer = CubitObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
