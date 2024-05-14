import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUploadController extends GetxController {
  final _picker = ImagePicker();
  var fileName = Rx<String?>(null);
  var imageUrl = Rx<String?>(null);
  late File _imageFile;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      fileName.value = pickedFile.name;
      update();
    } else {
      print('No image selected.');
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

      await ref.putFile(_imageFile);
      imageUrl.value = await ref.getDownloadURL();
      print('Image uploaded to Firebase: $imageUrl');

      print('hello${ref.name}');
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }
}
