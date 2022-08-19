import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controller/Auth_controller.dart';
import 'package:movie/controller/common_controller.dart';
import 'package:movie/pages/splash_screen.dart';
import 'package:movie/utils/mytheme.dart';

import 'controller/Location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Authcontroller());
  Get.put(LocationController());
  Get.put(CommonController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: MyTheme.myLightTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
