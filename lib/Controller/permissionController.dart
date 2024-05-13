import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
class PermissionController extends GetxController{

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog to enable location services
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Services Disabled"),
            content: Text("Please enable location services to use this feature."),
            actions: <Widget>[
              TextButton(
                child: Text("No Thanks"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("OK"),
                onPressed: () async {
                  // Open location settings
                  bool serviceEnabled = await Geolocator.openLocationSettings();
                  if (serviceEnabled) {
                    // Location services enabled, close dialog
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }
    // if (!serviceEnabled) {
    //   print('Location services are disabled. Please enable the services');
    //   return false;
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Location Permission Required'),
              content: Text('This app requires access to your location to function properly.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: Text('Allow'),
                    onPressed: () async {
                      permission == LocationPermission.always;
                      Navigator.of(context).pop();
                    }



                ),
              ],
            );
          },
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
}
