import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../config/dio_config.dart';

@module
abstract class AppModule {
  //shared pref instance
  @preResolve
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => createDio(baseUrl: AppConfig.instance.apiBaseUrl);

  @lazySingleton
  FirebaseFirestore get fireStore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseStorage get reference => FirebaseStorage.instance;
}
