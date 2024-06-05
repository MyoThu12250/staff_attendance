import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/leaveController.dart';
import '../Controller/loginController.dart';
import '../Controller/photoController.dart';
import '../Controller/profileController.dart';
import 'changePassword.dart';
import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage() {
    loginController.loadProfileData();
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getURl();
  }

  final ProfileController _controller = Get.put(ProfileController());

  LeaveController lontroller = Get.put(LeaveController());

  ImageUploadController controller = Get.put(ImageUploadController());

  final LoginController loginController = Get.find();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage(
          leaveDetail: {},
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(HomePage(leaveDetail: {}));
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        // backgroundColor: Colors.white60,
        body: Container(
          color: Colors.blueGrey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 200,
                            width: 400,
                            child: _controller.url.value.isEmpty
                                ? Image.asset(
                                    fit: BoxFit.fitWidth,
                                    'assets/images/default_profile.jpg')
                                : Image.network(
                                    _controller.url.value,
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                    Positioned(
                      child: Center(
                        child: _controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : CircleAvatar(
                                radius: 85,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 80,
                                  backgroundImage: _controller.url.value.isEmpty
                                      ? AssetImage(
                                          'assets/images/default_profile.jpg')
                                      : NetworkImage(_controller.url.value)
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
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        BottomSheetOptions(
                                                            _controller),
                                                  );
                                                  // _controller.pickImage(
                                                  //     ImageSource.gallery);
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
              SizedBox(height: 80),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontFamily: 'Epilogue',
                        ),
                        'Name: ${loginController.userInfo['username']}',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                          style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Epilogue',
                          ),
                          'Email: ${loginController.userInfo['email']}'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Epilogue',
                          ),
                          'Employee Id: ${loginController.userInfo['employeeId']}'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                          style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Epilogue',
                          ),
                          'Date Of Birth : ${loginController.userInfo['DOB']}'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                          style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Epilogue',
                          ),
                          'Address: ${loginController.userInfo['address']}'),
                    ),
                  ),
                ],
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
                        loginController.logout();
                      },
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontFamily: 'Epilogue',
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(ChangePassword());
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.pink,
                        fontFamily: 'Epilogue',
                      ),
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

class BottomSheetOptions extends StatelessWidget {
  final ProfileController controller;

  BottomSheetOptions(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Choose from Gallery'),
            onTap: () {
              controller.pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a Photo'),
            onTap: () {
              controller.pickImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
