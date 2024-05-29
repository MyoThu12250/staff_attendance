import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Controller/leaveController.dart';
import '../Controller/loginController.dart';

import 'dart:io';

import '../Controller/photoController.dart';
import 'changePassword.dart';
import 'home.dart';

class ProfilePage extends StatelessWidget {
  LeaveController lontroller = Get.put(LeaveController());
  ImageUploadController controller = Get.put(ImageUploadController());
  final LoginController loginController = Get.find();
  final box = GetStorage();

  ProfilePage() {
    loginController.loadProfileData();
  }

  void _logout() {
    box.erase();
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(HomePage());
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Profile Page'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.logout),
          //     onPressed: _logout,
          //   ),
          // ],
        ),
        // backgroundColor: Colors.white60,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: Colors.indigoAccent,
                      height: 180,
                      child: Image.asset(
                        'assets/images/default_profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 80,
                            backgroundImage:
                                loginController.profileImage.value.isEmpty
                                    ? AssetImage(
                                        'assets/images/default_profile.jpg')
                                    : FileImage(File(
                                            loginController.profileImage.value))
                                        as ImageProvider,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: Center(
                                        child: IconButton(
                                          iconSize: 30.0,
                                          color: Colors.black,
                                          onPressed: () {
                                            print('jahfurhfa');
                                            // controller.pickImage();
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
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
                  ],
                ),
              ),
              SizedBox(height: 110),
              Center(
                child: Text(
                  'User Information',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
              Obx(
                () => Text(
                    style: TextStyle(
                        // fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 21),
                    'Name: ${loginController.userInfo['username']}'),
              ),
              SizedBox(height: 30),
              Obx(
                () => Text(
                    style: TextStyle(
                        // fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 21),
                    'Email: ${loginController.userInfo['email']}'),
              ),
              SizedBox(height: 30),
              Obx(
                () => Text(
                    style: TextStyle(color: Colors.black, fontSize: 21),
                    'Employee Id: ${loginController.userInfo['employeeId']}'),
              ),
              SizedBox(height: 30),
              Obx(
                () => Text(
                    style: TextStyle(
                        // fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 21),
                    'Date Of Birth : ${loginController.userInfo['DOB']}'),
              ),
              SizedBox(height: 30),
              Obx(
                () => Text(
                    style: TextStyle(
                        // fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: 21),
                    'Address: ${loginController.userInfo['address']}'),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _logout();
                        // lontroller.Leave();
                      },
                      child: Text("Log Out"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(ChangePassword());
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
