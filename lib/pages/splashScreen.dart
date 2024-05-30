import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_ui/pages/homepage.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _isLogin = true;
  void main() async {
    await GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final bool _isLogin = box.read('isLoggedIn') ?? false;
    Timer(Duration(seconds: 3), () {
      Get.off(_isLogin == true ? HomePage() : LoginPage());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Center(
            child: CircleAvatar(
              radius: 200,
              child: Image.asset(
                width: 300,
                'assets/images/logo.jpg',
                // color: Colors.black,
              ),
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
