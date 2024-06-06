import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestHistoryController extends GetxController {
  static const _pageSize = 10;

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
          Uri.parse(Config.getAttdanceRequestHistoryRoute + '?page=$pageKey'));
      final data = json.decode(response.body);
      final newItems =
          data['datas']; // Adjust this based on the actual JSON structure

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
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
