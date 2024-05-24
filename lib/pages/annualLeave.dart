import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'leave.dart';

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
      initialDate: _selectedDateTimef ?? DateTime.now().add(Duration(days: 4)),
      // If _selectedDateTimef is null, set initialDate to the day after 3 days from today
      firstDate: DateTime.now().add(Duration(days: 4)),
      // Set firstDate to 3 days after today
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTimef = _pickedDate;
      });
    }
  }

  Future<void> _selectedDateTo() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimet ?? _selectedDateTimef ?? DateTime.now(),
      firstDate: _selectedDateTimef ?? DateTime.now().add(Duration(days: 4)),
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

  @override
  Widget build(BuildContext context) {
    final int acount = 0;
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
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context),
          child: Container(
            // color: Colors.lightGreenAccent,
            width: screenWidth,
            height: screenHeight * 0.7,
            // color: Colors.indigoAccent.withOpacity(0.4),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  acount == 0
                      ? Center(
                          child: Text(
                            'You have nothing attempt left',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        )
                      : Center(
                          child: Text(
                            'Remaining Annual Leave : ${acount} attempts left',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Center(
                      child: Text(
                        'Annual Leave Form',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: screenHeight * .15,
                                width: screenWidth * .29,
                                child: Icon(Icons.access_time),
                              ),
                              Container(
                                height: screenHeight * .15,
                                width: screenWidth * .29,
                                child: Icon(Icons.library_books),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 320,
                          child: Column(
                            children: [
                              Container(
                                height: screenHeight * .15,
                                width: screenWidth * .8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: SizedBox(
                                            height: 70,
                                            width: 140,
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
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 70,
                                          width: 140,
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
                                              _selectedDateTo();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight * .15,
                                width: screenWidth * .8,
                                child: Container(
                                  width: 290,
                                  height: 95,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                              ),
                            ],
                          ),
                        )

                        //
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: acount == 0
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
