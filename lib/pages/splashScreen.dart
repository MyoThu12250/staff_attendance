import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controller/loginController.dart';
import 'homepage.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController controller = Get.put(LoginController());

  // bool _isLogin = true;
  void main() async {
    controller.loadProfileData();
    controller.loadloginData();
    await GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool islogin = box.read('isLogin') ?? false;
    Timer(const Duration(seconds: 3), () {
      Get.off(islogin == true
          ? HomePage(
              leaveDetail: {},
            )
          : LoginPage());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              width: 200,
              'assets/images/hero.jpg',
              // color: Colors.black,
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
