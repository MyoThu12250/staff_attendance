import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AnnualLeave extends StatefulWidget {
  const AnnualLeave({super.key});

  @override
  State<AnnualLeave> createState() => _AnnualLeaveState();
}

class _AnnualLeaveState extends State<AnnualLeave> {
  DateTime? _selectedDateTimef;
  DateTime? _selectedDateTimet;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  Future<void> _sendData() async {
    final todate = DateFormat('yyyy-MM-dd').format(_selectedDateTimef!);
    final fromdate = DateFormat('yyyy-MM-dd').format(_selectedDateTimet!);
    final String reason = _reasonController.text;
    final String leavetype = 'Annual leave';

    final response = await http.post(
      Uri.parse('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/myint'),
      body: {
        'Reason': reason,
        'fromday': fromdate,
        'today': todate,
        'Leave': leavetype
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
    String _fromDate = _selectedDateTimef.toString();
    String _toDate = _selectedDateTimet.toString();
    String _reason = _reasonController.text;
    if (_name.isNotEmpty &&
        _fromDate.isNotEmpty &&
        _toDate.isNotEmpty &&
        _reason.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text('Annual Leave Submitted Successfully '),
            content: Container(
              width: 300,
              height: 60,
              child: Text("Successfully"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog.
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
              title: Text('required'),
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
        appBar: AppBar(
            // title: Text('Annual Leave'),
            ),
        body: MediaQuery(
            data: MediaQuery.of(context),
            child: Container(
              // color: Colors.lightGreenAccent,
              width: screenWidth,
              height: screenHeight * 0.7,
              // color: Colors.indigoAccent.withOpacity(0.4),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Annual Leave Form',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .29,
                            // color: Colors.red,
                            child: Icon(Icons.person),
                          ),
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .29,
                            // color: Colors.red,
                            child: Icon(Icons.access_time),
                          ),
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .29,
                            // color: Colors.red,
                            child: Icon(Icons.library_books),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .7,
                            // color: Colors.red,
                            child: Center(
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your name',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .7,
                            // color: Colors.red,
                            child: Row(
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
                                  width: 10,
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
                            height: screenHeight * .15,
                            width: screenWidth * .7,
                            // color: Colors.red,
                            child: Container(
                              width: 290,
                              height: 95,
                              // color: Colors.blue,
                              child: TextField(
                                controller: _reasonController,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                  labelText: 'Reason',
                                  hintText: 'Enter reason ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                      //
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        _validate() ? _sendData() : print("error");
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
                    ),
                  )
                ],
              ),
            )));
  }
}
