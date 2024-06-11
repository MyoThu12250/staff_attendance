// location_controller.dart
import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RangeController extends GetxController {
  var lat = 0.0.obs;
  var lon = 0.0.obs;
  var range = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocationData();
  }

  void fetchLocationData() async {
    final response = await http.get(Uri.parse(Config.RangeRoute));
    if (response.statusCode == 200) {
      print('object');
      final data = jsonDecode(response.body);
      final location = data['location'][0];
      lat.value = double.parse(location['lat']);
      lon.value = double.parse(location['lon']);
      range.value = location['range'].toDouble();
    } else {
      throw Exception('Failed to load location data');
    }
  }
}
