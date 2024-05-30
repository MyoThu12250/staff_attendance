import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project_ui/Controller/loginController.dart';

LoginController loginController = Get.find();

class LeaveController extends GetxController with SingleGetTickerProviderMixin {
  static const _pageSize = 10;
  final id = loginController.userInfo['userId'];

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
        Uri.parse(
            'http://10.103.0.226:8000/api/v1/leaveRecord/$id?page=$pageKey'),
      );

      if (response.statusCode == 200) {
        print(id);
        final jsonData = jsonDecode(response.body);
        final List<dynamic> newItems = jsonData['leaveListByUserId'] ?? [];

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

        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          CircularProgressIndicator();
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
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
    pagingController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
