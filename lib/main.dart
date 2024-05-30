import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/leave.dart';
import 'package:project_ui/pages/login.dart';
import 'package:project_ui/pages/sendingrequest.dart';
import 'package:project_ui/pages/splashScreen.dart';
import 'package:project_ui/pages/testProfile.dart';

import 'Controller/loginController.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final bool isLoggedIn = box.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      // initialRoute: isLoggedIn ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/leave', page: () => Leave()),
        GetPage(name: '/addtence', page: () => RequestPage()),
        GetPage(name: '/splash', page: () => SplashScreen())
      ],
    );
  }
}
