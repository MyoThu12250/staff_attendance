import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'loginController.dart';

class AddController extends GetxController {
  RxList<dynamic> attendanceData = <dynamic>[].obs;
  int currentPage = 0;
  bool hasMoreData = true;
  bool isLoading = false;
  LoginController controller = Get.find();

  Future<void> fetchAttendanceHistory({bool isRefresh = false}) async {
    final id = controller.userInfo['userId'].toString();
    if (isLoading) return;

    try {
      isLoading = true;

      // If refreshing, reset the currentPage and clear the existing data
      if (isRefresh) {
        currentPage = 1;
        attendanceData.clear();
        hasMoreData = true;
      }

      // Send HTTP GET request to the API endpoint with the current page
      final response = await http.get(
        Uri.parse(Config.getAttendanceRouteById + '/$id?page=$currentPage'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['datas'];

        // If no more data is returned, set hasMoreData to false
        if (jsonData.isEmpty) {
          hasMoreData = false;
        } else {
          attendanceData.addAll(jsonData);
          currentPage++;
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
    } finally {
      isLoading = false;
    }
  }
}

// In your widget where you want to display the data
class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AddController addController = Get.put(AddController());

  @override
  void initState() {
    super.initState();
    addController.fetchAttendanceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance History')),
      body: Obx(() {
        if (addController.attendanceData.isEmpty && addController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                addController.hasMoreData &&
                !addController.isLoading) {
              addController.fetchAttendanceHistory();
            }
            return true;
          },
          child: ListView.builder(
            itemCount: addController.attendanceData.length,
            itemBuilder: (context, index) {
              final item = addController.attendanceData[index];
              return ListTile(
                title: Text(item['leaveType']),
                subtitle: Text(item['createdAt']), // Adjust as needed
              );
            },
          ),
        );
      }),
    );
  }
}
