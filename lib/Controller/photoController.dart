// import 'dart:ffi';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// class ImageUploadController extends GetxController {
//   final _picker = ImagePicker();
//   var fileName = Rx<String?>(null);
//   var imageUrl = Rx<String?>(null);
//   late File _imageFile;
//
//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _imageFile = File(pickedFile.path);
//       fileName.value = pickedFile.name;
//       update();
//     } else {
//       print('No image selected.');
//     }
//   }
//
//   Future<void> uploadImage() async {
//     try {
//       if (_imageFile == null) {
//         throw Exception('No image selected');
//       }
//
//       final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final firebase_storage.Reference ref = firebase_storage
//           .FirebaseStorage.instance
//           .ref()
//           .child('images')
//           .child('$fileName.jpg');
//
//       await ref.putFile(_imageFile);
//       imageUrl.value = await ref.getDownloadURL();
//       print('Image uploaded to Firebase: $imageUrl');
//
//       print('hello${ref.name}');
//     } catch (e) {
//       print('Error uploading image to Firebase: $e');
//     }
//   }
// }

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  final _picker = ImagePicker();
  late File _imageFile;
  var imageUrl = ''.obs;
  var fileName = ''.obs;
  var imageFile = Rx<File?>(null);

  Future<String> pickImage() async {
    try {
      // to pick the image
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path) as File;
        fileName.value = pickedFile.name;
        return fileName.value;
      } else {
        // Handle the case when no image is picked
        fileName.value = '';
        return '';
      }
    } catch (e) {
      print("Image pick error: $e");
      fileName.value = '';
      return '';
    }
  }

  Future<void> uploadImage() async {
    try {
      if (_imageFile == null) {
        throw Exception('No image selected');
      }
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child('$fileName.jpg');
      await ref.putFile(_imageFile as File);
      imageUrl.value = await ref.getDownloadURL();
      print('Image uploaded to Firebase: $imageUrl');

      print('hello${ref.name}');
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }
}
