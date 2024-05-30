import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  var selectedImagePath = ''.obs;
  final _picker = ImagePicker();
  late File _imageFile;
  var imageUrl = ''.obs;
  var fileName = ''.obs;
  var imageFile = Rx<File?>(null);
  Future<void> PImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      // Handle user canceling image picking
      selectedImagePath.value = '';
    }
  }


  Future<String> pickImage() async {
  try {
  // to pick the image
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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


