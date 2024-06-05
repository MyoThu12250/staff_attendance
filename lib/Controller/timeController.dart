import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginController.dart';

class DateTimeController extends GetxController {
  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  final isButtonDisabled = false.obs;

  DateTime? lastSuccessfulResponseTime;
  final box = GetStorage();

  @override
  final LoginController controller = Get.put(LoginController());

  void onInit() {
    super.onInit();
    _checkButtonState();
  }

  Future<void> _checkButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? disabledUntil = prefs.getInt('disabledUntil');

    if (disabledUntil != null) {
      DateTime now = DateTime.now();
      DateTime disabledUntilDate =
          DateTime.fromMillisecondsSinceEpoch(disabledUntil);
      if (now.isBefore(disabledUntilDate)) {
        isButtonDisabled.value = true;
        Future.delayed(disabledUntilDate.difference(now), () {
          isButtonDisabled.value = false;
        });
      }
    }
  }

  Future<void> disableButtonFor6Hours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    DateTime disableUntil = now.add(Duration(minutes: 5));
    await prefs.setInt('disabledUntil', disableUntil.millisecondsSinceEpoch);
    isButtonDisabled.value = true;

    Future.delayed(Duration(minutes: 5), () {
      isButtonDisabled.value = false;
    });
  }

  void sendDateTimeToServerin(BuildContext context) async {
    String status = (DateTime.now().hour < 12) ? "In" : "Out";
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formattedDateTime = formatter.format(now);
    var userID = controller.userInfo['userId'];
    final url = Uri.parse(Config.createAttendanceRoute);
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'dateTime': formattedDateTime,
          'userId': userID,
          'checkingStatus': 'in'
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      disableButtonFor6Hours();

      // Enable the button after 6 hours

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shadowColor: Colors.green[800],
            elevation: 30,
            title: Text(
              "Successful Check " + status,
              style: TextStyle(color: Colors.green[800]),
            ),
            content: Text(
              "Successful.",
              style: TextStyle(color: Colors.green[400]),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // print('out of range');

      print(response.statusCode);
      print('Date and time sent successfully');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shadowColor: Colors.red[800],
            elevation: 30,
            title: Text(
              "Unsuccessful Check " + status,
              style: TextStyle(color: Colors.red[800]),
            ),
            content: Text(
              "Unsuccessful.",
              style: TextStyle(color: Colors.red[400]),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      isButtonDisabled.value = false;

      print(response.statusCode);
      print(formattedDateTime);
      print('Failed to send date and time. Error: ${response.reasonPhrase}');
    }
  }

  void sendDateTimeToServerout(BuildContext context) async {
    String status = (DateTime.now().hour < 12) ? "In" : "Out";
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formattedDateTime = formatter.format(now);
    var userID = controller.userInfo['userId'];
    final url = Uri.parse(Config.createAttendanceRoute);

    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'dateTime': formattedDateTime,
          'userId': userID,
          'checkingStatus': 'out'
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      disableButtonFor6Hours();

      // Enable the button after 6 hours

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shadowColor: Colors.green[800],
            elevation: 30,
            title: Text(
              "Successful Check " + status,
              style: TextStyle(color: Colors.green[800]),
            ),
            content: Text(
              "Successful.",
              style: TextStyle(color: Colors.green[400]),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // print('out of range');

      print(response.statusCode);
      print('Date and time sent successfully');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shadowColor: Colors.green[800],
            elevation: 30,
            title: Text(
              "UnSuccessful Check " + status,
              style: TextStyle(color: Colors.green[800]),
            ),
            content: Text(
              "UnSuccessful.",
              style: TextStyle(color: Colors.green[400]),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      isButtonDisabled.value = false;

      print(response.statusCode);
      print(formattedDateTime);
      print('Failed to send date and time. Error: ${response.reasonPhrase}');
    }
  }
}
