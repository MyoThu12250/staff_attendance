import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

 import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../Controller/loginController.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());

  late StreamSubscription<InternetConnectionStatus> _subscription;
  bool _isNoInternetDialogShown = false; // To track the dialog state

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
        // Internet is connected
          break;
        case InternetConnectionStatus.disconnected:
        // Internet is disconnected
          _showNoInternetDialog();
          break;
      }
    });
  }

  @override
  void dispose() {
    // _subscription.cancel(); // Cancel the subscription when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE1FF3C),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => controller.username.value = value,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    hintText: 'employeeId',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                      () => TextField(
                    onChanged: (value) => controller.password.value = value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.https_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.obscureText.value =
                          !controller.obscureText.value;
                        },
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: controller.obscureText.value,
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                      () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: controller.login,
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFE1FF3C),
                      textStyle: TextStyle(fontSize: 18),
                      padding: EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNoInternetDialog() {
    if (_isNoInternetDialogShown)
      return; // Prevent showing the dialog multiple times

    _isNoInternetDialogShown = true;

    Get.dialog(
      AlertDialog(
        title: Text("No Internet Connection"),
        content: Text(
            "This app requires an internet connection. Please check your settings."),
        actions: <Widget>[
          TextButton(
              child: Text("OK"),
              onPressed: () {
                SystemNavigator.pop();
              }),
        ],
      ),
      barrierDismissible: false, // Make dialog non-dismissible
    ).then((_) {
      _isNoInternetDialogShown = false; // Reset the dialog state when closed
    });
  }
}
