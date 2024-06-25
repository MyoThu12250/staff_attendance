import 'package:CheckMate/Controller/loginController.dart';
import 'package:CheckMate/pages/profile.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config_route.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  RxBool isLoading = false.obs;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _reNewPassword = TextEditingController();
  LoginController loginController = Get.find();

  bool _obscureText = false;

  Future<void> password() async {
    // is Loading
    isLoading.value = true;
    final String email = _email.text.toString();
    final String oldpassword = _password.text.toString();
    final String newPassword = _newPassword.text.toString();
    final response = await http.post(
      Uri.parse(Config.resetPasswordRoute),
      body: {
        'email': email,
        'oldPassword': oldpassword,
        'newPassword': newPassword
      },
      headers: {
        'Authorization': 'Bearer ${loginController.authorization.value}',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      isLoading.value = false;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text('Your Password Successfully Changed'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent)),
                child: Text('Ok'),
                onPressed: () {
                  Get.offAllNamed('/profile'); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' Unsuccessfully'),
            content: Text('Your Email  is Incorrect Please Try Again'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.back(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      // Handle error response
      print('Failed to send data');
    } else if (response.statusCode == 401) {
      showSessionExpiredDialog();
    } else if (response.statusCode == 403) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' Unsuccessful'),
            content: Text('Old Password is Incorrect Please Try Again'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.back(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      // Handle error response
      print('Failed to send data');
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' Unsuccessfully'),
            content: Text('Connection Error Please Try Again'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.back(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      // Handle error response
      print('Failed to send data');
    }
  }

  bool validate() {
    String password = _password.text.trim();
    String email = _email.text.trim();
    String newPassword = _newPassword.text.trim();
    String reNewPassword = _reNewPassword.text.trim();

    if (password.isEmpty ||
        email.isEmpty ||
        newPassword.isEmpty ||
        reNewPassword.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' Required'),
            content: Text('All Field are required.'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.back(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (newPassword != reNewPassword) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' unmatch'),
            content: Text('New Password and Confirm Password must be same'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.back(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(ProfilePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.off(ProfilePage());
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text('Reset Password'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: SizedBox(
                    width: 340,
                    child: Card(
                      margin: EdgeInsets.only(top: 60),
                      elevation: 8,
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                              child: SizedBox(
                                width: 280,
                                child: TextField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.mail),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 20.0),
                              child: SizedBox(
                                width: 280,
                                child: TextField(
                                  obscureText: !_obscureText,
                                  controller: _password,
                                  decoration: InputDecoration(
                                    labelText: 'Old Password',
                                    prefixIcon: Icon(Icons.https),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                              child: SizedBox(
                                width: 280,
                                child: TextField(
                                  obscureText: !_obscureText,
                                  controller: _newPassword,
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    prefixIcon: Icon(Icons.https),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 20.0),
                              child: SizedBox(
                                width: 280,
                                child: TextField(
                                  obscureText: !_obscureText,
                                  controller: _reNewPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon: Icon(Icons.https),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _obscureText,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _obscureText = value ?? false;
                                      });
                                    },
                                  ),
                                  Text('Show Password'),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  validate() ? password() : print('object');
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontFamily: 'Epilogue',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
