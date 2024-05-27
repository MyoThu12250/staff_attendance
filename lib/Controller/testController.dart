import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Model/testModel.dart';

class TestController extends GetxController {
  RxList leaveList = [].obs;

  Future<void> getData() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"name": "Add your name in the body"});
    var dio = Dio();
    var response = await dio.request(
      'https://6642e3fe3c01a059ea20b604.mockapi.io/leave',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );
    try {
      if (response.statusCode == 200) {
        List jsonData = response.data;
        print(jsonData);
        jsonData.forEach((element) {
          leaveList.add(TestModel.fromJson(element));
        });

        print(json.encode(response.data));
        print(leaveList.length);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }
//
// Future<void> deleteData(String id) async {
//   var headers = {'Content-Type': 'application/json'};
//   var data = json.encode({"name": "name"});
//   var dio = Dio();
//   var response = await dio.request(
//     'https://6642e3fe3c01a059ea20b604.mockapi.io/leave/$id',
//     options: Options(
//       method: 'DELETE',
//       headers: headers,
//     ),
//     data: data,
//   );
//
//   if (response.statusCode == 200) {
//     getData();
//     print(json.encode(response.data));
//   } else {
//     print(response.statusMessage);
//   }
// }

// Future<void> editData(TestModel model, String id) async {
//   var headers = {'Content-Type': 'application/json'};
//   var data = json.encode({"name": "Add your name in the body"});
//   var dio = Dio();
//   var response = await dio.request(
//     'https://6642e3fe3c01a059ea20b604.mockapi.io/leave/$id',
//     options: Options(
//       method: 'PUT',
//       headers: headers,
//     ),
//     data: data,
//   );
//
//   if (response.statusCode == 200) {
//     getData();
//     print(json.encode(response.data));
//   } else {
//     print(response.statusMessage);
//   }
// }
//
// Future<void> addData() async {
//   var headers = {'Content-Type': 'application/json'};
//   var data = json.encode({"name": "MTA"});
//   var dio = Dio();
//   var response = await dio.request(
//     'https://6642e3fe3c01a059ea20b604.mockapi.io/leave',
//     options: Options(
//       method: 'POST',
//       headers: headers,
//     ),
//     data: data,
//   );
//
//   if (response.statusCode == 200) {
//     getData();
//     print(json.encode(response.data));
//   } else {
//     print(response.statusMessage);
//   }
// }
}
