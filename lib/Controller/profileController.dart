import 'dart:io';

import 'package:CheckMate/Controller/loginController.dart';
import 'package:CheckMate/config_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../pages/session_expire.dart';

class ProfileController extends GetxController {
  var imageUrl = ''.obs;
  var isLoading = false.obs;
  var url = ''.obs;
  final box = GetStorage();
  LoginController controller = Get.put(LoginController());

  @override
  void onInit() {
    controller.loadProfileData();
    super.onInit();
    getURl();
    String storedUrl = box.read('profile_image_url') ?? '';
    if (storedUrl.isNotEmpty) {
      imageUrl.value = storedUrl;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await uploadImageToFirebase(imageFile);
    }
  }

  Future<void> uploadImageToFirebase(File imageFile) async {
    isLoading.value = true;
    try {
      CircularProgressIndicator();
      if (imageUrl.value.isNotEmpty) {
        await deleteImageFromFirebase(imageUrl.value);
      }
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      imageUrl.value = downloadUrl;
      // Store the image URL in GetStorage
      await sendImageUrlToApi(downloadUrl);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteImageFromFirebase(String url) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Failed to delete image from Firebase: $e');
    }
  }

  Future<void> sendImageUrlToApi(String url) async {
    final id = controller.userInfo['userId'].toString();
    box.write('profile_image_url', url);
    isLoading = true.obs;
    try {
      final response = await http.post(
        Uri.parse(Config.updateProfileRoute),
        headers: {
          'Authorization': 'Bearer ${controller.authorization.value}',
        },
        body: {'imageUrl': url, 'id': id},
      );
      if (response.statusCode == 200) {
        getURl();
        Get.snackbar(
          'Success',
          'Profile image updated successfully',
          backgroundColor: Colors.lightGreenAccent,
        );
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      } else {
        Get.snackbar('Error', 'Failed to update profile image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send image URL to API: $e');
    }
  }

  Future<void> getURl() async {
    final ids = controller.userInfo['userId'].toString();
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(Config.getUpdateProfileRoute),
        headers: {
          'Authorization': 'Bearer ${controller.authorization.value}',
        },
        body: {'id': ids},
      );

      if (response.statusCode == 202) {
        url.value = response.body;
      } else if (response.statusCode == 401) {
      } else {
        Get.snackbar('Error', 'Failed to Load Image',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to Get Image,Check Your Connection',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
