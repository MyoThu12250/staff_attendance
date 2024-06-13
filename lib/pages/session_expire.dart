// dialog_utils.dart

import 'package:CheckMate/Controller/loginController.dart';
import 'package:CheckMate/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import the main file where the global key is defined
LoginController controller = Get.put(LoginController());

void showSessionExpiredDialog() {
  showDialog(
    context: navigatorKey.currentState!.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8,
        title: Text('Expire'),
        content: Container(
          width: 300,
          height: 60,
          child: Text("Session Expired Please LogIn Again"),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            child: Text('Ok'),
            onPressed: () {
              controller.logout(); // Execute the provided logout callback
            },
          ),
        ],
      );
    },
  );
}
