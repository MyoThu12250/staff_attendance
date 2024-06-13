// location_controller.dart
import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'loginController.dart';

class RangeController extends GetxController {
  var lat = 0.0.obs;
  var lon = 0.0.obs;
  var range = 0.0.obs;

  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    fetchLocationData();
  }

  void fetchLocationData() async {
    print(loginController.authorization.value);
    final response = await http.get(
      Uri.parse(Config.RangeRoute),
      headers: {
        'Authorization': 'Bearer ${loginController.authorization.value}',
      },
    );
    print(loginController.authorization.value);
    print(response.statusCode);
    print('hi');
    if (response.statusCode == 200) {
      print('object');
      final data = jsonDecode(response.body);
      final location = data['location'][0];
      lat.value = double.parse(location['lat']);
      lon.value = double.parse(location['lon']);
      range.value = location['range'].toDouble();
    } else if (response.statusCode == 401) {
      showSessionExpiredDialog();
    } else {
      throw Exception('Failed to load location data');
    }
  }
}
