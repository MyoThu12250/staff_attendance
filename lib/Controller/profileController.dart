import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var imageUrl = ''.obs;
  var isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
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
    box.write('profile_image_url', url);
    isLoading = true.obs;
    try {
      final response = await http.post(
        Uri.parse('http://10.103.0.142:8000/api/v1/updateProfileImage'),
        body: {'imageUrl': url, 'id': '15'},
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile image updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update profile image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send image URL to API: $e');
    }
  }
}
