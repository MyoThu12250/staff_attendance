import 'dart:convert';

import 'package:CheckMate/Controller/timeController.dart';
import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

final DateTimeController dateTimeController = Get.put(DateTimeController());
final LatLng center = LatLng(16.81605105, 96.12887631);
final double radius = 300.0;

class LocationController extends GetxController {
  // Observable to track if the point is within range
  final isInRange = false.obs;
  Rx<Position?> currentLocation = Rx<Position?>(null);
  String status = (DateTime.now().hour < 12) ? "In" : "Out";

  void sendLocationToServerin(BuildContext context) async {
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
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        String check = response.body;
        bool isValid = checkIsValid(check);
        if (isValid) {
          dateTimeController.sendDateTimeToServerin(context);
        }
        print(response.statusCode);
        print('Location sent successfully');
      } else {
        showDialog(
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
                " Unsuccessful Check " + status + " Connection Error",
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
    }
  }

  void sendLocationToServerout(BuildContext context) async {
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
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        String check = response.body;
        bool isValid = checkIsValid(check);
        if (isValid) {
          dateTimeController.sendDateTimeToServerout(context);
        }
        print(response.statusCode);
        print('Location sent successfully');
      } else {
        showDialog(
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
                " Unsuccessful Check " + status + " Connection Error",
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
    }
  }
}

bool checkIsValid(String jsonString) {
  // Parse the JSON string into a map
  Map<String, dynamic> responseMap = jsonDecode(jsonString);

  // Check the value of the "isValid" key
  bool isValid = responseMap['isValid'];

  return isValid;
}
