import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../Controller/attendanceRequestController.dart';
import 'attendanceRequestDetail.dart';

class RequestHistoryPage extends StatelessWidget {
  final RequestHistoryController controller =
  Get.put(RequestHistoryController());

  IconData getIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.error;
    }
  }

  Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.grey;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, dynamic>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text(
            'Empty attendance request record',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Epilogue',
            ),
          ),
        ),
        itemBuilder: (context, item, index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(RequestDetailPage(requestDetail: item));
              },
              child: ListTile(
                title: Text(item['reason']),
                subtitle: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(item['date'])),
                ),
                leading: Icon(
                  size: 45,
                  getIcon(item['status']),
                  color: getColor(item['status']),
                ),
              ),
            ),
            if (index < controller.pagingController.itemList!.length - 1)
              Divider(),
            // Add Divider only if it's not the last item
          ],
        ),
      ),
    );
  }
}
