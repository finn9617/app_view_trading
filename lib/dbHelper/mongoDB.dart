// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:app_view_trading/dbHelper/contants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(mongoConnUrl);
    await db.open();
    userCollection = db.collection(userColletionDB);
  }

  static Future<List<Map<String, dynamic>>> getDataTable(
      String collection) async {
    var data = await userCollection.find().toList();
    return data;
  }

  static Future<void> updateDownloadApp() async {
    var result = await userCollection.findOne({'_id': idApp});
    result['download_app'] = result['download_app'] + 1;
    userCollection.updateOne(where.eq('_id', idApp),
        modify.set('download_app', result['download_app']));
  }

  static Future<void> updateOpenApp() async {
    var result = await userCollection.findOne({'_id': idApp});
    result['open_app'] = result['open_app'] + 1;
    userCollection.updateOne(
        where.eq('_id', idApp), modify.set('open_app', result['open_app']));
  }

  static Future getH5() async {
    var result = await userCollection.findOne({'_id': idApp});
    return result['h5'] ?? "https://m.citifutures.cc/";
  }

  static Future getSuper() async {
    var result = await userCollection.findOne({'_id': idApp});
    return result['super'] ?? false;
  }
}
