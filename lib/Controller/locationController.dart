import 'dart:convert';

import 'package:CheckMate/Controller/timeController.dart';
import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../pages/session_expire.dart';
import 'loginController.dart';

final DateTimeController dateTimeController = Get.put(DateTimeController());
final LatLng center = LatLng(16.81605105, 96.12887631);
final double radius = 300.0;

class LocationController extends GetxController {
  String checks = '';
  RxBool isLoading = false.obs;

  LoginController loginController = Get.find();

  final isInRange = false.obs;
  Rx<Position?> currentLocation = Rx<Position?>(null);

  void sendLocationToServerin(BuildContext context) async {
    isLoading.value = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentLocation.value = position;
    if (position != null) {
      final url = Uri.parse(Config.mapCheckRoute);

      final response = await http.post(
        url,
        body: json.encode({
          'lat': position.latitude,
          'lon': position.longitude,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginController.authorization.value}',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        String check = response.body;
        bool isInside = checkIsValid(check);
        if (isInside) {
          dateTimeController.sendDateTimeToServerin(context);
        } else if (isInside == false) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.red,
                elevation: 30,
                title: Text(
                  "Unsuccessful ",
                  style: TextStyle(
                    color: Colors.red[800],
                  ),
                ),
                content: Text(
                  " Unsuccessful Check In, Out of Range  ",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 8,
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(
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
        }
        isLoading.value = false;

        print(response.statusCode);
        print('Location sent successfully');
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shadowColor: Colors.red,
              elevation: 30,
              title: Text(
                "Unsuccessful ",
                style: TextStyle(
                  color: Colors.red[800],
                ),
              ),
              content: Text(
                " Unsuccessful Check In, Check Your Connection   ",
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 8,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
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
      }
    }
  }

  void sendLocationToServerout(BuildContext context) async {
    isLoading.value = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentLocation.value = position;
    if (position != null) {
      final url = Uri.parse(Config.mapCheckRoute);

      final response = await http.post(
        url,
        body: json.encode({
          'lat': position.latitude,
          'lon': position.longitude,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginController.authorization.value}',
        },
      );
      if (response.statusCode == 200) {
        String check = response.body;
        bool isInside = checkIsValid(check);
        if (isInside) {
          dateTimeController.sendDateTimeToServerout(context);
        } else if (isInside == false) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.red,
                elevation: 30,
                title: Text(
                  "Unsuccessful ",
                  style: TextStyle(
                    color: Colors.red[800],
                  ),
                ),
                content: Text(
                  " Unsuccessful Check Out, Out of Range  ",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 8,
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // dateTimeController.sendDateTimeToServer();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        isLoading.value = false;
        print(response.statusCode);
        print('Location sent successfully');
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shadowColor: Colors.red,
              elevation: 30,
              title: Text(
                "Unsuccessful ",
                style: TextStyle(
                  color: Colors.red[800],
                ),
              ),
              content: Text(
                " Unsuccessful Check Out , Check Your connection ",
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 8,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
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
      }
    }
  }
}

bool checkIsValid(String jsonString) {
  Map<String, dynamic> responseMap = jsonDecode(jsonString);

  bool isInside = responseMap['isInside'];

  return isInside;
}
