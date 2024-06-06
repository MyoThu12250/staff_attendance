import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login.dart';

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -90,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          Positioned(
            right: -70,
            bottom: -50,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.4),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            right: -80,
            top: -50,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.4),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            left: -180,
            bottom: -90,
            child: Container(
              height: 350,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.4),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            top: 220,
            right: 150,
            child: Text(
              'Login Fail',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 15,
            child: Text(
              '401',
              style: TextStyle(fontSize: 270),
            ),
          ),
          Positioned(
            top: 80,
            right: -120,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Image.asset(
                'assets/images/a.png',
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            right: 130,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Get.off(LoginPage());
              },
              child: Text(
                'Login Again',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 245,
            left: 40,
            child: Text(
              'Try again to login \n Something was wrong',
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
