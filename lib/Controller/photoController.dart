import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  var selectedImagePath = ''.obs;
  var imageFile = Rx<File?>(null);
  var imageUrl = ''.obs;
  var fileName = ''.obs;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        imageFile.value = file;
        fileName.value = pickedFile.name;
      } else {
        fileName.value = '';
        imageFile.value = null;
      }
    } catch (e) {
      print("Image pick error: $e");
      fileName.value = '';
      imageFile.value = null;
    }
  }

  Future<void> uploadImage() async {
    try {
      if (imageFile.value == null) {
        throw Exception('No image selected');
      }
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child('$fileName.jpg');
      await ref.putFile(imageFile.value!);
      imageUrl.value = await ref.getDownloadURL();
      print('Image uploaded to Firebase: $imageUrl');

      print('hello${ref.name}');
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }
}
