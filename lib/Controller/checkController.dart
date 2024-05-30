import 'dart:math';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeospatialController extends GetxController {
  // Center point
  final LatLng center = LatLng(45.521563, -122.677433);

  // Point to check
  final LatLng pointToCheck = LatLng(45.523064, -122.676483);

  // Radius in meters
  final double radius = 500.0;

  // Observable to track if the point is within range
  final isInRange = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Perform the initial range check
    checkRange();
  }

  void checkRange() {
    isInRange.value = isWithinRange(
      center.latitude,
      center.longitude,
      pointToCheck.latitude,
      pointToCheck.longitude,
      radius,
    );
  }

  // Haversine formula to calculate the distance between two points
  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371e3; // Earth's radius in meters
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final deltaPhi = (lat2 - lat1) * pi / 180;
    final deltaLambda = (lon2 - lon1) * pi / 180;

    final a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = R * c;
    return distance;
  }

  // Check if the point is within the specified radius
  bool isWithinRange(
      double lat1, double lon1, double lat2, double lon2, double radius) {
    final distance = haversine(lat1, lon1, lat2, lon2);
    return distance <= radius;
  }
}
