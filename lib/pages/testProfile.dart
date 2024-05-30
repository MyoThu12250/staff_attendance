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

class ProfilePage extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());
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
                    _controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 200,
                            width: 400,
                            child: _controller.imageUrl.value.isEmpty
                                ? Image.asset(
                                    fit: BoxFit.fitWidth,
                                    'assets/images/default_profile.jpg')
                                : Image.network(
                                    _controller.imageUrl.value,
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
                                  backgroundImage: _controller
                                          .imageUrl.value.isEmpty
                                      ? AssetImage(
                                          'assets/images/default_profile.jpg')
                                      : NetworkImage(_controller.imageUrl.value)
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
              // Center(
              //   child: Text(
              //     'User Information',
              //     style: TextStyle(
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black),
              //   ),
              // ),
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

// class ProfilePage extends StatelessWidget {
//   final ProfileController _controller = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile Setup')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() => _controller.imageUrl.isNotEmpty
//                 ? Image.network(_controller.imageUrl.value)
//                 : Icon(Icons.person, size: 100)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _controller.pickImage(ImageSource.gallery),
//               child: Text('Choose from Gallery'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () => _controller.pickImage(ImageSource.camera),
//               child: Text('Take a Photo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await GetStorage.init();
//   runApp(GetMaterialApp(home: ProfilePage()));
// }
