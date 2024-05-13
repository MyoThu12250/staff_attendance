import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_ui/pages/login.dart';
import 'package:project_ui/pages/profile.dart';
import 'package:project_ui/pages/sendingrequest.dart';

import 'pages/homepage.dart';

void main() {
  bool isLogin = true;
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Project ui',
    home: (isLogin == true) ? HomePage() : Login(),
    // home: HomePage(),
  ));
}
