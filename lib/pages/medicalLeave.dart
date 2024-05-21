import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:project_ui/pages/leave.dart';

import '../Controller/photoController.dart';

class MedicalLeave extends StatefulWidget {
  const MedicalLeave({super.key});

  @override
  State<MedicalLeave> createState() => _MedicalLeaveState();
}

class _MedicalLeaveState extends State<MedicalLeave> {
  final ImageUploadController imageController =
      Get.put(ImageUploadController());
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
    final String leavetype = 'medical leave';
    final String attachment = imageController.imageUrl.value.toString();
    final response = await http.post(
      Uri.parse('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/myint'),
      body: {
        'Reason': reason,
        'fromday': fromdate,
        'today': todate,
        'Leave': leavetype,
        'attachment': attachment
      },
    );

    if (response.statusCode == 201) {
      // Handle successful response
      print('Data sent successfully');
    } else {
      // Handle error response
      print('Failed to send data');
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text('Medical Request  Successfully Submitted '),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Get.to(Leave()); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
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
    return WillPopScope(
      onWillPop: () async {
        Get.off(Leave());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(Leave());
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
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
                                      child: Icon(Icons.medication),
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
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              // Update selected value when an item is selected
                                              selectedValue = newValue;
                                            }
                                            setState(() {});
                                          },
                                          items: items.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
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
                                                _attatchController.text =
                                                    imageController
                                                        .fileName.value
                                                        .toString();
                                                imageController.pickImage();
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () async {
                            _validate()
                                ? imageController.uploadImage()
                                : print("Enter Required Data");
                            imageController.imageUrl.value != null
                                ? _sendData()
                                : print("error");
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
                        ),
                      ),
                    ),
                  ],
                ),
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTimef = _pickedDate;
      });
    }
  }

  Future<void> _selectedDatet() async {
    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTimet = _pickedDate;
      });
    }
  }
}
