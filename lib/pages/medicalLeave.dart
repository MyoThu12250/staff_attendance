import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_ui/Controller/timeController.dart';
import 'package:project_ui/pages/leave.dart';

import '../Controller/leaveController.dart';
import '../Controller/photoController.dart';

class MedicalLeave extends StatefulWidget {
  // bool isedit;
  // int? index;
  //
  // MedicalLeave({
  //   Key? key,
  //   required this.isedit,
  //   this.index,
  // }) : super(key: key);

  @override
  State<MedicalLeave> createState() => _MedicalLeaveState();
}

final LeaveController controller = Get.put(LeaveController());

class _MedicalLeaveState extends State<MedicalLeave> {
  final ImageUploadController imageController =
      Get.put(ImageUploadController());
  final DateTimeController timecontroller = Get.put(DateTimeController());
  DateTime? _selectedDateTimef;
  DateTime? _selectedDateTimet;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _attatchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final List<String> items = ['Medical Leave', 'Annual Leave'];
  String selectedValue = 'Medical Leave'; // Default selected value
  Future<void> _sendData() async {
    final todate = DateFormat('yyyy-MM-dd').format(_selectedDateTimef!);
    final fromdate = DateFormat('yyyy-MM-dd').format(_selectedDateTimet!);
    final String reason = _reasonController.text;
    final String leavetype = 'Medical leave';
    // final String userId = controller.retrieveUserId().toString();
    final String attachment = imageController.imageUrl.value.toString();
    final response = await http.post(
      Uri.parse('http://10.103.1.9:8000/api/v1/leaveRecord/createLeave'),
      body: {
        'reasons': reason,
        'from': fromdate,
        'to': todate,
        'leaveType': leavetype,
        'attachmentUrl': attachment,
        'UserId': 15
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text('Medical Leave Request Submitted Successfully  '),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent)),
                child: Text('Ok'),
                onPressed: () {
                  Get.to(Leave()); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
    } else {
      // Handle error response
      print('Failed to send data');
    }
  }

  void _onSubmit() async {
    if (_validate()) {
      await imageController.uploadImage();

      if (imageController.imageUrl.value != null) {
        _sendData();
      } else {
        print("Error: Could not retrieve the download URL");
      }
    } else {
      print("Enter Required Data");
    }
  }

  bool _validate() {
    String _name = _nameController.text.trim();
    String _leavetype = selectedValue;
    String _fromDate = _selectedDateTimef.toString();
    String _toDate = _selectedDateTimet.toString();
    String _reason = _reasonController.text;
    String _attatch = _attatchController.text.toString();
    if (_name.isNotEmpty &&
        _leavetype.isNotEmpty &&
        _fromDate.isNotEmpty &&
        _toDate.isNotEmpty &&
        _reason.isNotEmpty &&
        _attatch.isNotEmpty) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Required'),
              content: Text('Please Enter All Required Data'),
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
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(Leave());
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            // color: Color(0xFFE1FF3C),
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.7,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.greenAccent,
                          width: screenWidth,
                          height: screenHeight * .1,
                          child: Center(
                            child: Text(
                              'Medical Leave Form',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 95,
                                    // color: Colors.amber,
                                    child: Icon(Icons.person),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 95,
                                    // color: Colors.amber,
                                    child: Icon(Icons.access_time),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 95,
                                    // color: Colors.amber,
                                    child: Icon(Icons.library_books),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 95,
                                    // color: Colors.amber,
                                    child: Icon(Icons.link),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 290,
                                    height: 95,
                                    // color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            hintText: 'Enter your name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 290,
                                    height: 95,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 130,
                                          child: TextField(
                                            controller: TextEditingController(
                                              text: _selectedDateTimef != null
                                                  ? '${_selectedDateTimef!.day}/${_selectedDateTimef!.month}/${_selectedDateTimef!.year}'
                                                  : null,
                                            ),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'From',
                                              hintText: 'From',
                                              suffixIcon: Icon(
                                                Icons.date_range,
                                                size: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              _selectedDatef();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 70,
                                          width: 130,
                                          child: TextField(
                                            controller: TextEditingController(
                                              text: _selectedDateTimet != null
                                                  ? '${_selectedDateTimet!.day}/${_selectedDateTimet!.month}/${_selectedDateTimet!.year}'
                                                  : null,
                                            ),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'to',
                                              hintText: 'to',
                                              suffixIcon: Icon(
                                                Icons.date_range,
                                                size: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              _selectedDatet();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 290,
                                    height: 95,
                                    // color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: _reasonController,
                                        maxLines: null,
                                        expands: true,
                                        decoration: InputDecoration(
                                          labelText: 'Reason',
                                          hintText: 'Enter Reason ',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 290,
                                    height: 95,
                                    // color: Colors.blue,
                                    child: Center(
                                      child: SizedBox(
                                        width: 290,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _attatchController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Choose File',
                                                suffixIcon: Icon(Icons.link)),
                                            readOnly: true,
                                            onTap: () async {
                                              String fileName =
                                                  await imageController
                                                      .pickImage();
                                              _attatchController.text =
                                                  fileName;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _onSubmit();
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    backgroundColor: Color(0xFFE1FF3C)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectedDatef() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimef ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTimef = _pickedDate;
        if (_selectedDateTimet != null &&
            _pickedDate.isAfter(_selectedDateTimet!)) {
          // Reset the "to" date if it's after the newly selected "from" date
          _selectedDateTimet = null;
        }
      });
    }
  }

  Future<void> _selectedDatet() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimet ?? DateTime.now(),
      firstDate: _selectedDateTimef ?? DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        if (_selectedDateTimef != null &&
            _pickedDate.isBefore(_selectedDateTimef!)) {
          // Do not update the "to" date if it's before the "from" date
          return;
        }
        _selectedDateTimet = _pickedDate;
      });
    }
  }
}
