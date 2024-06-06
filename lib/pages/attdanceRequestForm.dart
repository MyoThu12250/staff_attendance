import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controller/leaveController.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  DateTime? _selectedDateTime;
  TextEditingController _name = TextEditingController();
  DateTime? _date;

  TextEditingController _reason = TextEditingController();
  String dropdownValue = 'Check In';

  bool _validate() {
    final String name = _name.text;
    final String reason = _reason.text;
    final date = DateFormat('yyyy-MM-dd').format(_date!);
    if (name.isNotEmpty && date.isNotEmpty && reason.isNotEmpty) {
      return true;
    } else {
      showDialog(
          context: context,
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
                      'You have ${Rcount} attempt to request',
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
                      // SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80.0),
                        child: Icon(Icons.my_library_books),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: SizedBox(
                            width: 150,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['Check In', 'Check Out', 'Both']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: 300,
                          child: TextField(
                            onTap: () {
                              _selectedDatef();
                            },
                            controller: TextEditingController(
                              text: _selectedDateTime != null
                                  ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}'
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
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: SizedBox(
                          width: 300,
                          height: 120,
                          child: TextField(
                            controller: _reason,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                                labelText: 'Reason',
                                hintText: 'Enter reason',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
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
                        Get.off(RequestPage(
                          attendanceDetail: {},
                        ));
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
