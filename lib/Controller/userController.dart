import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  RxList users = [].obs;

  Future<void> getData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Config.loginRoute));
    request.body = json.encode({"username": "Nu Nu", "password": "password"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(request.body);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
