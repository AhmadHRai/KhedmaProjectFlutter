import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khdma/page/home/home_page.dart';
import 'package:khdma/page/splash/splash_page.dart';
import 'package:khdma/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'classes.dart';
import 'vars.dart' as v;

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff424242), // navigation bar color
    // statusBarColor: Colors.grey, // status bar color
  ));
  runApp(const MyApp());
  print(GetStorage().read("user"));
  v.userData = jsonDecode(GetStorage().read("user")??"{}");
  await v.db.createDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.id,
      getPages: AppRoutes.allRoutes,
    );
  }
}