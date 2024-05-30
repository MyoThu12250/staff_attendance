import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_ui/Controller/leaveController.dart';
import 'package:project_ui/pages/leave.dart';

class AnnualLeave extends StatefulWidget {
  const AnnualLeave({super.key});

  @override
  State<AnnualLeave> createState() => _AnnualLeaveState();
}

final LeaveController controller = Get.put(LeaveController());

class _AnnualLeaveState extends State<AnnualLeave> {
  DateTime? _selectedDateTimef;
  DateTime? _selectedDateTimet;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  Future<void> _sendData() async {
    final todate = DateFormat('yyyy-MM-dd').format(_selectedDateTimef!);
    final fromdate = DateFormat('yyyy-MM-dd').format(_selectedDateTimet!);

    final String reason = _reasonController.text;
    final String leavetype = 'Annual Leave';
    // final String userId = controller.retrieveUserId().toString();
    final response = await http.post(
      Uri.parse('http://10.103.1.6:8000/api/v1/leaveRecord/createLeave'),
      body: {
        'reasons': reason,
        'from': fromdate,
        'to': todate,
        'leaveType': leavetype,
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
            title: Text('Annual Leave Request Submitted Successfully '),
            content: Container(
              width: 300,
              height: 60,
              child: Text("Successfully"),
            ),
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            title: Text(' Unsuccessful  '),
            content: Container(
              width: 300,
              height: 60,
              child: Text("Unsuccessful"),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.to(Leave()); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
      // Handle error response
      print('Failed to send data');
    }
  }

  bool _validate() {
    final testdate = _selectedDateTimef!.day.toInt() + 3;
    final testdate1 = DateTime.now().day.toInt();
    String _name = _nameController.text.trim();
    String _fromDate = _selectedDateTimef.toString();
    String _toDate = _selectedDateTimet.toString();
    String _reason = _reasonController.text;
    if ((_name.isNotEmpty &&
            _fromDate.isNotEmpty &&
            _toDate.isNotEmpty &&
            _reason.isNotEmpty) &&
        testdate > testdate1 + 3) {
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
        appBar: AppBar(
          // title: Text('Annual Leave'),
          leading: IconButton(
            onPressed: () {
              Get.off(Leave());
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                          ),
                          Container(
                            height: screenHeight * .15,
                            width: screenWidth * .7,
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                        height: 70,
                                        width: 125,
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
                                      height: 70,
                                      width: 125,
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
                            width: screenWidth * .7,
                            // color: Colors.red,
                            child: Container(
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
                                    hintText: 'Enter reason ',
                                    border: OutlineInputBorder(),
                                  ),
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
}
