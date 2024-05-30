import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (authController.accessToken.value.isEmpty) {
            return ElevatedButton(
              onPressed: () async {
                await authController.login('username', 'password');
              },
              child: Text('Login'),
            );
          } else {
            return Text(
                'Logged in with token: ${authController.accessToken.value}');
          }
        }),
      ),
    );
  }
}
