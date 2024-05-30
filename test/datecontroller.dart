// date_controller.dart
import 'package:get/get.dart';

class DateController extends GetxController {
  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  void setFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value.isBefore(date)) {
      toDate.value = date;
    }
  }

  void setToDate(DateTime date) {
    if (date.isAfter(fromDate.value)) {
      toDate.value = date;
    } else {
      Get.snackbar(
        'Invalid Date',
        'To date cannot be earlier than from date',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

// date_picker_screen.dart
