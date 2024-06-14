import 'dart:async';
import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'loginController.dart';

LoginController loginController = Get.find();

class LeaveController extends GetxController with SingleGetTickerProviderMixin {
  var _pageSize = 0.obs;
  final id = loginController.userInfo['userId'];
  final acount = loginController.userInfo['annualLeave'];
  final mcount = loginController.userInfo['medicalLeave'];

  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  var Rlist = <dynamic>[].obs;
  var Alist = <dynamic>[].obs;
  var Plist = <dynamic>[].obs;
  var allLeaves = <dynamic>[].obs;
  var isloading = false.obs;

  late TabController tabController;

  LeaveController() {
    pagingController.addPageRequestListener((pageKey) {
      Leave(pageKey);
    });
  }

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 4, vsync: this);
  }

  Future<void> Leave(int pageKey) async {
    isloading.value = true;
    try {
      final response = await http.get(
        Uri.parse(Config.getLeaveRecordByIdRoute + '/$id?page=$pageKey'),
        headers: {
          'Authorization': 'Bearer ${loginController.authorization.value}',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> newItems = jsonData['datas'] ?? [];
        _pageSize.value = jsonData['totalPage'];
        print(_pageSize.value);

        if (pageKey == 0) {
          Rlist.clear();
          Alist.clear();
          Plist.clear();
          allLeaves.clear();
        }

        Rlist.addAll(newItems.where((item) => item['status'] == "Rejected"));
        Alist.addAll(newItems.where((item) => item['status'] == "Approved"));
        Plist.addAll(newItems.where((item) => item['status'] == "Pending"));
        allLeaves.addAll(newItems);

        final isLastPage = newItems.length < _pageSize.value;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          CircularProgressIndicator();
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      } else {
        pagingController.error = 'Failed to load data';
      }
    } catch (error) {
      pagingController.error = error;
    } finally {
      isloading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
