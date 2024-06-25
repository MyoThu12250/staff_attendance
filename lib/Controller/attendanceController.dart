import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pages/session_expire.dart';
import 'loginController.dart';

class AddController extends GetxController {
  RxList<dynamic> attendanceData = <dynamic>[].obs;
  int currentPage = 0;
  bool hasMoreData = true;
  bool isLoading = false;
  LoginController controller = Get.find();

  Future<void> fetchAttendanceHistory(BuildContext context,
      {bool isRefresh = false}) async {
    final id = controller.userInfo['userId'].toString();
    if (isLoading) return;

    try {
      isLoading = true;
      if (isRefresh) {
        currentPage = 0;
        attendanceData.clear();
        hasMoreData = true;
      }

      final response = await http.get(
        Uri.parse(Config.getAttendanceRouteById + '/$id?page=$currentPage'),
        headers: {
          'Authorization': 'Bearer ${controller.authorization.value}',
        },
      );
      print(response.statusCode);
      print(controller.authorization.value);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['datas'];

        if (jsonData.isEmpty) {
          hasMoreData = false;
        } else {
          attendanceData.addAll(jsonData);
          currentPage++;
        }
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      } else {
        attendanceData.value = [];
      }
    } catch (e) {
      attendanceData.value=[];
      // Get.snackbar(
      //   'Error',
      //   'An unexpected error occurred',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 3),
      //   margin: EdgeInsets.all(10),
      //   borderRadius: 10,
      // );
    } finally {
      isLoading = false;
    }
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AddController addController = Get.put(AddController());

  @override
  void initState() {
    super.initState();
    addController.fetchAttendanceHistory(context);
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
              addController.fetchAttendanceHistory(context);
            }
            return true;
          },
          child: ListView.builder(
            itemCount: addController.attendanceData.length,
            itemBuilder: (context, index) {
              final item = addController.attendanceData[index];
              return ListTile(
                title: Text(item['leaveType']),
                subtitle: Text(item['createdAt']),
              );
            },
          ),
        );
      }),
    );
  }
}
