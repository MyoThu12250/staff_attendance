import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datecontroller.dart';

void main() {
  runApp(MaterialApp(
    home: DatePickerScreen(),
  ));
}

class DatePickerScreen extends StatelessWidget {
  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leave Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() => ListTile(
                    title: Text(
                        'From Date: ${dateController.fromDate.value.toLocal()}'
                            .split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: dateController.fromDate.value,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null &&
                          picked != dateController.fromDate.value)
                        dateController.setFromDate(picked);
                    },
                  )),
              Obx(() => ListTile(
                    title: Text(
                        'To Date: ${dateController.toDate.value.toLocal()}'
                            .split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: dateController.toDate.value,
                        firstDate: dateController.fromDate.value,
                        lastDate: DateTime(2101),
                      );
                      if (picked != null &&
                          picked != dateController.toDate.value)
                        dateController.setToDate(picked);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
