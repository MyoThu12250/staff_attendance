
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_ui/Controller/timeController.dart';
// final ClockController clockcontroller = Get.put(ClockController());
final DateTimeController dateTimeController = Get.put(DateTimeController());
class LocationController extends GetxController {

  Rx<Position?> currentLocation = Rx<Position?>(null);
String status=(DateTime.now().hour<12)? "In"
    : "Out"
  ;
  void sendLocationToServer(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentLocation.value = position;


    if (position!= null) {
      final url = Uri.parse('http://10.103.0.142:8000/api/v1/mapCheck');
      final response = await http.post(
        url,
        body: json.encode({
          'lat': position.latitude,
          'lon': position.longitude,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        String check=response.body;
        bool isValid = checkIsValid(check);
        if (isValid) {
          dateTimeController.sendDateTimeToServer();
          showDialog(

            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Successful Check "+status),
                content: Text("Successful."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {


                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }


        else{

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Unsuccessful "),
                content: Text(" Unsuccessful Check "+status+
                    "Out of Range "),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      // dateTimeController.sendDateTimeToServer();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );


          // print('out of range');
        }
        print(response.statusCode);
        print('Location sent successfully');
      } else {
        print('Failed to send location. Error: ${response.reasonPhrase}');
      }
    } else {
      print('Location not available');
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

// Future<void> fetchUsers() async {
//   try {
//     var response = await Dio().get('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/check');
//     List<dynamic> jsonData = response.data;
//     var users = jsonData;
//     print(users[1]);
//   } catch (e) {
//     print('Error fetching users: $e');
//   }
// }
// void getCurrentLocation() async {
//   try {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     currentLocation.value = position;
//   } catch (e) {
//     print('Error: $e');
//   }
// }
