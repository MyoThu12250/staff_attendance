import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var userInfo = {}.obs;
  var isLoading = false.obs;
  final box = GetStorage();

  var profileImage = ''.obs; // Path to the profile image

  Future<void> login() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://10.103.0.142:8000/api/v1/users/loginUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        userInfo.value = jsonDecode(response.body)['userData'];
        box.write('isLoggedIn', true);
        box.write('userInfo', userInfo.value);
        Get.toNamed('/home');
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      box.write('profileImage', profileImage.value);
    }
  }

  void loadProfileData() {
    userInfo.value = box.read('userInfo') ?? {};
    profileImage.value = box.read('profileImage') ?? '';
  }
}
