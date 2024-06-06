import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:CheckMate/pages/homepage.dart';
import 'package:CheckMate/pages/leave.dart';
import 'package:CheckMate/pages/login.dart';
import 'package:CheckMate/pages/splashScreen.dart';
import 'package:CheckMate/pages/testProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      initialRoute: '/splash',
      // initialRoute: isLoggedIn ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(
            name: '/home',
            page: () => HomePage(
                  leaveDetail: {},
                )),
        GetPage(
            name: '/leave',
            page: () => Leave(
                  leaveDetail: {},
                )),
        GetPage(
            name: '/addtence',
            page: () => RequestPage(
                  attendanceDetail: {},
                )),
        GetPage(name: '/splash', page: () => SplashScreen())
      ],
    );
  }
}
