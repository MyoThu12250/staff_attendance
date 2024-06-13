import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Controller/leaveController.dart';
import '../config_route.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  DateTime? _selectedDateTime;
  TextEditingController _name = TextEditingController();
  DateTime? _date;
  RxBool isLoading = false.obs;

  TextEditingController _reason = TextEditingController();
  RxString dropdownValue = 'Check In'.obs;

  Future<void> _sendData() async {
    isLoading.value = true;
    final id = loginController.userInfo['userId'].toString();
    final date = DateFormat('yyyy-MM-dd').format(_date!).toString();
    String reason;
    if (dropdownValue.value == 'Check In') {
      print(dropdownValue.value);
      reason = 'in_time_late';
    } else if (dropdownValue.value == 'Check Out') {
      print(dropdownValue.value);
      reason = 'out_time_late';
    } else {
      reason = 'in_time_late';
      // For "Both" or any other case
    }
    print(reason);
    final response = await http.post(
      Uri.parse(Config.createAttendanceRequestRoute),
      body: {'reason': reason.toString(), 'date': date, 'UserId': id},
      headers: {
        'Authorization': 'Bearer ${loginController.authorization.value}',
      },
    );
    print(response.statusCode);
    isLoading.value = false;
    if (response.statusCode == 200) {
      _showDialog('Attendance Request Submitted Successfully', 'Successfully',
          Colors.lightGreenAccent);
    } else if (response.statusCode == 401) {
      showSessionExpiredDialog();
    } else if (response.statusCode == 400) {
      _showDialog('Unsuccessful',
          'You already Created Attendance Request For this day', Colors.red);
    } else {
      _showDialog(
          'Unsuccessful', 'Check Your Connection and Try Again', Colors.red);
    }
  }

  void _showDialog(String title, String content, Color color) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8,
          title: Text(title),
          content: Container(
            width: 300,
            height: 60,
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color)),
              child: Text('Ok'),
              onPressed: () {
                Get.off(RequestPage(attendanceDetail: {})); // Close the dialog.
              },
            ),
          ],
        );
      },
    );
  }

  bool _validate() {
    final String name = _name.text;
    final String reason = dropdownValue.value;
    final date = DateFormat('yyyy-MM-dd').format(_date!);
    if (date.isNotEmpty && reason.isNotEmpty) {
      return true;
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Required'),
              content: Text('Please enter your data'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
      return false;
    }
  }

  Future<void> _selectedDatef() async {
    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Rcount = loginController.userInfo['attendanceLeave'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(
                RequestPage(
                  attendanceDetail: {},
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Rcount != 0
                  ? Text(
                      'You have $Rcount attempt to request',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  : Text(
                      'You have nothing attempts to request',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  'Attendance Request Form',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Icon(Icons.access_time),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80.0),
                        child: Icon(Icons.my_library_books),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 40.0),
                      //   child: Center(
                      //     child: SizedBox(
                      //       width: 150,
                      //       child: Obx(
                      //         () => DropdownButton<String>(
                      //           value: dropdownValue.value,
                      //           onChanged: (String? newValue) {
                      //             dropdownValue.value = newValue!;
                      //           },
                      //           items: <String>[
                      //             'Check In',
                      //             'Check Out'
                      //           ].map<DropdownMenuItem<String>>((String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(value),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70.0),
                        child: Container(
                          width: 300,
                          child: TextField(
                            onTap: () {
                              _selectedDatef();
                            },
                            controller: TextEditingController(
                              text: _date != null
                                  ? '${_date!.day}/${_date!.month}/${_date!.year}'
                                  : null,
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              suffixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          width: 250,
                          child: Obx(
                            () => DropdownButton<String>(
                              value: dropdownValue.value,
                              onChanged: (String? newValue) {
                                dropdownValue.value = newValue!;
                              },
                              items: <String>[
                                'Check In',
                                'Check Out'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 40.0),
                      //   child: SizedBox(
                      //     width: 300,
                      //     height: 120,
                      //     child: TextField(
                      //       controller: _reason,
                      //       maxLines: null,
                      //       expands: true,
                      //       decoration: InputDecoration(
                      //           labelText: 'Reason',
                      //           hintText: 'Enter reason',
                      //           border: OutlineInputBorder()),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 6, backgroundColor: Color(0xFFE1FF3C)),
                child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: Rcount == 0
                    ? null
                    : () {
                        if (_validate()) {
                          _sendData();
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
