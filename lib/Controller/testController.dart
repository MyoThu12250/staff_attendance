import 'dart:convert';

import 'package:Global_TA/Model/testModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  RxList leaveList = [].obs;

  Future<void> getData() async {
    var dio = Dio();
    var response = await dio.request(
      'https://6642e3fe3c01a059ea20b604.mockapi.io/leave',
      options: Options(
        method: 'GET',
      ),
    );
    try {
      if (response.statusCode == 200) {
        List jsonData = response.data;
        jsonData.forEach((element) {
          leaveList.add(TestModel.fromJson(element));
        });
        print(jsonData);
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  // done
  Future<void> deleteData(String id) async {
    EasyLoading.show(status: 'Loading');
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      'https://6642e3fe3c01a059ea20b604.mockapi.io/leave/$id',
      options: Options(
        method: 'DELETE',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Delete success');

      print('delete preform');
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> updateData(TestModel model, String id) async {
    print('perform update');
    EasyLoading.show(status: 'Loading');
    var data = model.toJson();

    var dio = Dio();
    var response = await dio.request(
      'https://6642e3fe3c01a059ea20b604.mockapi.io/leave/$id',
      options: Options(
        method: 'GET',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print('succcess update');
      Get.back();
      EasyLoading.showSuccess('Update Success!');
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> addData(TestModel model) async {
    // loading indicator
    EasyLoading.show(status: 'loading...');

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 118|BSgoKTYoz5Y8ui7zEPGhpctb87YL7haoLDDT9oIv90777167'
    };

    //get data
    var data = model.toJson();
    var dio = Dio();
    var response = await dio.request(
      'https://6642e3fe3c01a059ea20b604.mockapi.io/leave',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 201) {
      // get data
      getData();
      Get.back();
      EasyLoading.showSuccess('Great Success!');
    } else {
      print(response.statusMessage);
    }
  }
}
