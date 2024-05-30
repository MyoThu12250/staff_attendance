import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AddController extends GetxController {
  Future<void> fetchAttendanceHistory() async {
    try {
      // Send HTTP GET request to the API endpoint
      final response = await http.get(
        Uri.parse('http://10.103.1.6:8000/api/v1/attendance'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];

        // Optionally filter the data based on some criteria
        // For example, if you want to filter by user ID
        final userId = retrieveUserId();
        if (userId != null) {
          List<dynamic> filteredData =
              jsonData.where((data) => data['UserId'] == userId).toList();

          // Prepare the arguments to pass to the next page
          Map<String, dynamic> arguments = {
            'attendanceData': filteredData,
          };
          print('hi');

          // Navigate to the attendance page with the filtered data
          Get.toNamed(
            '/attendance',
            arguments: arguments,
          );
        } else {
          // If no filtering is required, pass all data
          Get.toNamed(
            '/addtence',
            arguments: {
              'attendanceData': jsonData,
            },
          );
        }
      } else {
        // Show a snackbar in case of a connection error
        Get.snackbar(
          'Connection Error',
          'Failed to get Attendance History',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10),
          borderRadius: 10,
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  dynamic retrieveUserId() {
    final box = GetStorage();
    Map<String, dynamic> userInfo = box.read('userInfo') ?? {};
    return userInfo['userId'];
  }
}
