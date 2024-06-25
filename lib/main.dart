import 'package:CheckMate/Controller/attendanceController.dart';
import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:CheckMate/pages/homepage.dart';
import 'package:CheckMate/pages/leave.dart';
import 'package:CheckMate/pages/login.dart';
import 'package:CheckMate/pages/profile.dart';
import 'package:CheckMate/pages/splashScreen.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(
            leaveDetail: {},
          ),
        ),
        GetPage(
          name: '/leave',
          page: () => Leave(
            leaveDetail: {},
          ),
        ),
        GetPage(
          name: '/addtence',
          page: () => RequestPage(
            attendanceDetail: {},
          ),
        ),
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
        )
      ],
    );
  }
}
