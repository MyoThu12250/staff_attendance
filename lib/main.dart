import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_ui/pages/login.dart';
import 'package:project_ui/pages/profile.dart';
import 'package:project_ui/pages/sendingrequest.dart';

import 'pages/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLogin = true;
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Project ui',
    home: (isLogin == true) ? HomePage() : Login(),
    // home: HomePage(),
  ));
}
