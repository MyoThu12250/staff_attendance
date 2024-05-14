import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;

class MedicalLeave extends StatefulWidget {
  const MedicalLeave({super.key});

  @override
  State<MedicalLeave> createState() => _MedicalLeaveState();
}

class _MedicalLeaveState extends State<MedicalLeave> {
  DateTime? _selectedDateTimef;
  DateTime? _selectedDateTimet;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _attatchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final List<String> items = ['Medical Leave', 'Annual Leave'];
  String selectedValue = 'Medical Leave'; // Default selected value

  void _validate() {
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
            title: Text('Medical Submit Successful or fail'),
            content: Container(
              width: 300,
              height: 150,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'Leave type',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'Duration',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog.
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog.
                },
              ),
            ],
          );
        },
      );
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
          // title: Padding(
          //   padding: const EdgeInsets.only(left: 30.0),
          //   child: Text('Medical Leave Form'),
          // ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 95,
                                  // color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 95,
                                  // color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                      'Leave Type',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 95,
                                  // color: Colors.amber,
                                  child: Center(
                                      child: Text(
                                    'Duration',
                                    style: TextStyle(fontSize: 20),
                                  )),
                                ),
                                Container(
                                  width: 100,
                                  height: 95,
                                  // color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                      'Reason',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 95,
                                  // color: Colors.amber,
                                  child: Center(
                                      child: Text(
                                    'Attachment',
                                    style: TextStyle(fontSize: 20),
                                  )),
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
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Center(
                                      child: TextField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your name',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // child: Center(
                                  //     child: Text(
                                  //   'Enter ur name',
                                  //   style: TextStyle(fontSize: 20),
                                  // )),
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
                                            // if (_selectedDateTimef == null) {
                                            //   showDialog(
                                            //       context: context,
                                            //       builder:
                                            //           (BuildContext context) {
                                            //         return AlertDialog(
                                            //           title: Text('Error'),
                                            //           content:
                                            //               Text('sekected date'),
                                            //           actions: [
                                            //             TextButton(
                                            //               onPressed: () {
                                            //                 Navigator.of(
                                            //                         context)
                                            //                     .pop();
                                            //               },
                                            //               child: Text('Ok'),
                                            //             )
                                            //           ],
                                            //         );
                                            //       });
                                            // } else {
                                            _selectedDatef();
                                            // }
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
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                      controller: _reasonController,
                                      maxLines: null,
                                      expands: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 290,
                                  height: 95,
                                  // color: Colors.blue,
                                  child: Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: 230,
                                      child: TextField(
                                        controller: _attatchController,
                                        decoration: InputDecoration(
                                            hintText: 'Choose File',
                                            suffixIcon: Icon(Icons.link)),
                                        readOnly: true,
                                        onTap: () async {
                                          final file = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          if (file == null) return;
                                          // Extracting the file name
                                          String fileName =
                                              path.basename(file.path);
                                          print(fileName);

                                          // You can use fileName in your code
                                          _attatchController.text =
                                              fileName.toString();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          _validate();
                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       elevation: 8,
                          //       title:
                          //           Text('Medical Submit Successful or fail'),
                          //       content: Container(
                          //         width: 300,
                          //         height: 150,
                          //         child: Column(
                          //           children: [
                          //             Align(
                          //               alignment: Alignment.topLeft,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(25.0),
                          //                 child: Text(
                          //                   'Leave type',
                          //                   style: TextStyle(fontSize: 20),
                          //                 ),
                          //               ),
                          //             ),
                          //             Align(
                          //               alignment: Alignment.topLeft,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(25.0),
                          //                 child: Text(
                          //                   'Duration',
                          //                   style: TextStyle(fontSize: 20),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           child: Text('Ok'),
                          //           onPressed: () {
                          //             Navigator.of(context)
                          //                 .pop(); // Close the dialog.
                          //           },
                          //         ),
                          //         TextButton(
                          //           child: Text('Close'),
                          //           onPressed: () {
                          //             Navigator.of(context)
                          //                 .pop(); // Close the dialog.
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE1FF3C)),
                      ),
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
