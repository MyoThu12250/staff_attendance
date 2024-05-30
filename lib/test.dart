import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'Controller/testt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UserProfilePage());
}

class UserProfilePage extends StatelessWidget {
  final String userId = 'user123'; // Replace with actual user ID
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.fetchProfileUrl(userId);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return profileController.profileImageUrl.value.isNotEmpty
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            profileController.profileImageUrl.value),
                      )
                    : CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person),
                      );
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showImageSourceDialog(context);
                },
                child: Text('Upload Profile Picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              ontap: () {
                profileController.uploadProfilePicture(
                    userId, ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                profileController.uploadProfilePicture(
                    userId, ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
