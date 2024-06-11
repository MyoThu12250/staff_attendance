import 'dart:async';

import 'package:CheckMate/Controller/circleController.dart';
import 'package:CheckMate/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  RangeController rangeController = Get.put(RangeController());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(
          leaveDetail: {},
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/hero.jpg',
          color: Colors.black,
        ),
      ),
    );
  }
}
