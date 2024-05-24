import 'package:Global_TA/pages/home.dart';
import 'package:Global_TA/pages/leave.dart';
import 'package:Global_TA/pages/login.dart';
import 'package:Global_TA/pages/notification.dart';
import 'package:Global_TA/pages/profile.dart';
import 'package:Global_TA/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Controller/loginController.dart';

void main() async {
  await GetStorage.init();
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
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/noti', page: () => NotiPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/leave', page: () => Leave()),
        GetPage(name: '/splash', page: () => SplashScreen())
      ],
    );
  }
}
