import 'package:CheckMate/pages/leave.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Controller/leaveController.dart';
import '../config_route.dart';

class HalfDayLeave extends StatefulWidget {
  bool isedit;
  int? index;
  final Map<String, dynamic> leaveDetail;

  HalfDayLeave(
      {Key? key, required this.isedit, this.index, required this.leaveDetail})
      : super(key: key);

  @override
  State<HalfDayLeave> createState() => _HalfDayLeaveState();
}

class _HalfDayLeaveState extends State<HalfDayLeave> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isedit == true) {
      dropdownValue.value = widget.leaveDetail['leaveType'];
      _reasonController.text = widget.leaveDetail['reason'];
      _date = DateTime.parse(widget.leaveDetail['from']);
    }
  }

  DateTime? _date;
  RxBool isLoading = false.obs;

  RxString dropdownValue = 'Morning Leave'.obs;
  TextEditingController _reasonController = TextEditingController();

  Future<void> _sendData() async {
    isLoading.value = true;
    final id = loginController.userInfo['userId'].toString();
    final date = DateFormat('yyyy-MM-dd').format(_date!).toString();

    final response = await http.post(
      Uri.parse(Config.createLeaveRecordRoute),
      body: {
        'leaveType': dropdownValue.value,
        'reasons': _reasonController.text.toString(),
        'from': date,
        'to': date,
        'UserId': id
      },
      headers: {
        'Authorization': 'Bearer ${loginController.authorization.value}',
      },
    );
    print(response.statusCode);
    isLoading.value = false;
    if (response.statusCode == 200) {
      _showDialog('Leave Request Submitted Successfully', 'Successfully',
          Colors.lightGreenAccent);
    } else if (response.statusCode == 401) {
      showSessionExpiredDialog();
    } else if (response.statusCode == 400) {
      _showDialog('Unsuccessful',
          'You already Created Leave Request For this day', Colors.red);
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
                Get.offAll(Leave(leaveDetail: {})); // Close the dialog.
              },
            ),
          ],
        );
      },
    );
  }

  bool _validate() {
    final String leaveType = dropdownValue.value;
    final date = DateFormat('yyyy-MM-dd').format(_date!);
    if (date.isNotEmpty && leaveType.isNotEmpty) {
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

  Future<void> Update() async {
    isLoading.value = true;
    final recordId = widget.leaveDetail['id'];
    final date = DateFormat('yyyy-MM-dd').format(_date!);

    final String reason = _reasonController.text;

    try {
      final response = await http.put(
        Uri.parse('${Config.updateLeaveRecordByIdRoute}/$recordId'),
        body: {
          'reasons': reason,
          'from': date,
          'to': date,
          'leaveType': dropdownValue.value
        },
        headers: {
          'Authorization': 'Bearer ${loginController.authorization.value}',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Update successful',
            backgroundColor: Colors.greenAccent,
            duration: const Duration(seconds: 4));
        Get.offAllNamed('/leave');
      } else if (response.statusCode == 401) {
        showSessionExpiredDialog();
      } else {
        print('Failed to update: ${response.statusCode}');
        Get.snackbar('Fail', 'Unable to update. Please try again.',
            backgroundColor: Colors.red, duration: const Duration(seconds: 4));
      }
    } catch (e) {
      print('Error updating: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: Colors.red, duration: const Duration(seconds: 4));
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
                Leave(
                  leaveDetail: {},
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
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
                  'Half Day Leave Form',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 90.0),
                        child: Icon(Icons.my_library_books),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Icon(Icons.access_time),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 90.0),
                        child: Icon(Icons.library_books),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60.0),
                        child: SizedBox(
                          width: 250,
                          child: Obx(() {
                            return DropdownButton<String>(
                              value: dropdownValue.value,
                              onChanged: (String? newValue) {
                                dropdownValue.value = newValue!;
                              },
                              items: <String>[
                                'Morning Leave',
                                'Evening Leave'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                              hintText: 'Selecte date',
                              labelText: 'Date',
                              suffixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70.0),
                        child: Container(
                          width: 300,
                          child: TextField(
                            maxLines: null,
                            controller: _reasonController,
                            decoration: InputDecoration(
                              hintText: 'Reason',
                              border: OutlineInputBorder(),
                              label: Text('Reason'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              widget.isedit == true
                  ? ElevatedButton(
                      onPressed: () {
                        _validate() ? Update() : print("error");
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
                    )
                  : ElevatedButton(
                      onPressed: Rcount == 0
                          ? null
                          : () {
                              _validate() ? _sendData() : print("error");
                            },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
