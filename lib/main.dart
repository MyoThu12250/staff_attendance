import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_ui/pages/sendingrequest.dart';

import 'pages/homepage.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Project ui',
    home: const HomePage(),
  ));
}
