import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Controller/leaveController.dart';
import '../Controller/loginController.dart';

import 'dart:io';

class ProfilePage extends StatelessWidget {
  LeaveController lontroller = Get.put(LeaveController());
  final LoginController controller = Get.find();
  final box = GetStorage();

  ProfilePage() {
    controller.loadProfileData();
  }

  void _logout() {
    box.erase();
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    double _radius = 70;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: _logout,
        //   ),
        // ],
      ),
      backgroundColor: Colors.white60,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(
                () => CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.pinkAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 80,
                    backgroundImage: controller.profileImage.value.isEmpty
                        ? AssetImage('assets/images/default_profile.jpg')
                        : FileImage(File(controller.profileImage.value))
                            as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: IconButton(
                            iconSize: 30.0,
                            color: Colors.black,
                            onPressed: () {
                              controller.pickImage();
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'User Information',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent),
              ),
            ),
            SizedBox(height: 30),

            Obx(
              () => Text(
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreenAccent,
                      fontSize: 21),
                  'Name: ${controller.userInfo['username']}'),
            ),

            SizedBox(height: 30),
            Obx(
              () => Text(
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreenAccent,
                      fontSize: 21),
                  'Email: ${controller.userInfo['email']}'),
            ),

            SizedBox(height: 30),
            Obx(
              () => Text(
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreenAccent,
                      fontSize: 21),
                  'Employee Id: ${controller.userInfo['employeeId']}'),
            ),
            SizedBox(height: 30),
            Obx(
              () => Text(
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreenAccent,
                      fontSize: 21),
                  'Date Of Birth : ${controller.userInfo['DOB']}'),
            ),
            SizedBox(height: 30),
            Obx(
              () => Text(
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreenAccent,
                      fontSize: 21),
                  'Address: ${controller.userInfo['address']}'),
            ),

            SizedBox(
              height: 30,
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.lightGreenAccent),
                onPressed: () {
                  _logout();
                  // lontroller.Leave();
                },
                child: Text("Log Out"),
              ),
            ) // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
