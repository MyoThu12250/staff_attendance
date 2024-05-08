import 'package:flutter/material.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'pages/homepage.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(primaryColor: Colors.purpleAccent),
    title: 'Project ui',
    home: const HomePage(),
    // builder: EasyLoading.init(),
  ));
}
