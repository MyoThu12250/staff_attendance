import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'loginController.dart';

class RequestHistoryController extends GetxController {
  static const _pageSize = 10;

  LoginController loginController = Get.find();

  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  RequestHistoryController() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await http.get(
        Uri.parse(Config.getAttdanceRequestHistoryRoute + '?page=$pageKey'),
        headers: {
          'Authorization': 'Bearer ${loginController.authorization.value}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newItems = data['datas'];

        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}