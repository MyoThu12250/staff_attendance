// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// import 'package:project_ui/pages/leave.dart';
//
// import 'loginController.dart';
//
// class LeaveController extends GetxController {
//   var Info = {}.obs;
//   var isLoading = false.obs;
//   final box = GetStorage();
//
//   var profileImage = ''.obs; // Path to the profile image
//   final LoginController controller = Get.find();
//
//   Future<void> Leave() async {
//     isLoading.value = true;
//     try {
//       final response = await http.get(
//         Uri.parse('http://10.103.0.142:8000/api/v1/leaveRecord'),
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = jsonDecode(response.body)['data'];
//         if (controller.userInfo['userId'] != null) {
//           List<dynamic> filteredData = jsonData
//               .where((data) => data['UserId'] == controller.userInfo['userId'])
//               .toList();
//           Get.toNamed('/leave', arguments: filteredData);
//         }
//       } else {
//         Get.snackbar('Error', 'Login failed');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Network error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       profileImage.value = pickedFile.path;
//       box.write('profileImage', profileImage.value);
//     }
//   }
// }
// //   void loadProfileData() {
// //     Info.value = box.read('userInfo') ?? {};
// //     profileImage.value = box.read('profileImage') ?? '';
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_ui/pages/leave.dart';
import 'loginController.dart';

final box = GetStorage();

class LeaveController extends GetxController {
  var Info = {}.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  var profileImage = ''.obs;
  final LoginController controller = Get.find();

  Future<void> Leave() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.103.1.9:8000/api/v1/leaveRecord'),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];

        if (retrieveUserId() != null) {
          List<dynamic> filteredData = jsonData
              .where((data) => data['UserId'] == retrieveUserId())
              .toList();
          List<dynamic> Rlist = filteredData
              .where((data) => data['status'] == "Rejected")
              .toList();
          List<dynamic> Alist = filteredData
              .where((data) => data['status'] == "Approved")
              .toList();
          List<dynamic> Plist = filteredData
              .where((data) => data['status'] == "Pending")
              .toList();
          Map<String, dynamic> arguments = {
            'filteredData': filteredData,
            'Rlist': Rlist,
            'Alist': Alist,
            'Plist': Plist
          };
          Get.toNamed(
            '/leave',
            arguments: arguments,
          );
        }
      } else {
        Get.snackbar(
          'Connection Error',
          'Fail to get Leave History',
          backgroundColor: Colors.red,
          // background color of the snackbar
          colorText: Colors.white,
          // text color of the snackbar
          snackPosition: SnackPosition.TOP,
          // position of the snackbar
          duration: Duration(seconds: 3),
          // duration of the snackbar
          margin: EdgeInsets.all(10),
          // margin around the snackbar
          borderRadius: 10, // border radius of the snackbar
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  dynamic retrieveUserId() {
    final box = GetStorage();
    Map<String, dynamic> userInfo = box.read('userInfo') ?? {};
    return userInfo['userId'];
  }

  dynamic retrieveLeave() {
    final box = GetStorage();
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
//   void loadProfileData() {
//     Info.value = box.read('userInfo') ?? {};
//     profileImage.value = box.read('profileImage') ?? '';
//   }
// }
