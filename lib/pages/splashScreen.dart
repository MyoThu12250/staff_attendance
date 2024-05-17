import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final bool _isLogin = box.read('isLoggedIn') ?? false;
    Timer(Duration(seconds: 3), () {
      Get.off(_isLogin == false ? HomePage() : LoginPage());
    });
    return Scaffold(
      backgroundColor: Color(0xFFE1FF3C),
      body: Column(
        children: [
          Spacer(),
          Center(
            child: Image.asset(
              width: 150,
              'assets/images/novalink.png',
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            color: Colors.black,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
