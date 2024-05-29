import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'loginController.dart';

final box = GetStorage();

class LeaveController extends GetxController {
  var Info = {}.obs;
  var isLoading = false.obs;
  var profileImage = ''.obs; // Path to the profile image
  final LoginController controller = Get.find();

  Future<void> Leave() async {
    try {
      isLoading.value = true; // Show loading state
      final response = await http.get(
        Uri.parse('http://10.103.1.29:8000/api/v1/leaveRecord/15'),
      );
      if (response.statusCode == 200) {
        final responseBody = response.body;
        print('Response body: $responseBody'); // Debug print
        final jsonData = jsonDecode(responseBody);

        if (jsonData != null && jsonData['leaveListByUserId'] != null) {
          List<dynamic> leaveList = jsonData['leaveListByUserId'];
          print('Parsed leave list: $leaveList'); // Debug print

          List<dynamic> Rlist =
              leaveList.where((item) => item['status'] == "Rejected").toList();
          List<dynamic> Alist =
              leaveList.where((item) => item['status'] == "Approved").toList();
          List<dynamic> Plist =
              leaveList.where((item) => item['status'] == "Pending").toList();

          Map<String, dynamic> arguments = {
            'filteredData': leaveList,
            'Rlist': Rlist,
            'Alist': Alist,
            'Plist': Plist
          };
          Get.offNamed('/leave', arguments: arguments);
        } else {
          Get.snackbar('Error', 'Unexpected response format');
        }
      } else {
        Get.snackbar(
          'Connection Error',
          'Fail to get Leave History',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10),
          borderRadius: 10,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      isLoading.value = false; // Hide loading state
    }
  }

  dynamic retrieveUserId() {
    Map<String, dynamic> userInfo = box.read('userInfo') ?? {};
    return userInfo['userId'];
  }

  dynamic retrieveLeave() {
    Map<String, dynamic> LeaveInfo = box.read('leave') ?? {};
    return LeaveInfo['reasons'];
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
      box.write('profileImage', profileImage.value);
    }
  }
}
