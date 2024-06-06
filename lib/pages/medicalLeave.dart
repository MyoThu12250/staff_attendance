import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Controller/leaveController.dart';
import '../Controller/loginController.dart';
import '../Controller/photoController.dart';
import '../Controller/timeController.dart';
import 'leave.dart';

class MedicalLeave extends StatefulWidget {
  bool isedit;
  int? index;
  final Map<String, dynamic> leaveDetail;

  MedicalLeave(
      {Key? key, required this.isedit, this.index, required this.leaveDetail})
      : super(key: key);

  @override
  State<MedicalLeave> createState() => _MedicalLeaveState();
}

final LeaveController controller = Get.put(LeaveController());

class _MedicalLeaveState extends State<MedicalLeave> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isedit == true) {
      _reasonController.text = widget.leaveDetail['reasons'];
      _selectedDateTimef = DateTime.parse(widget.leaveDetail['from']);
      _selectedDateTimet = DateTime.parse(widget.leaveDetail['to']);
      // imageController.imageFile.value = widget.leaveDetail['attachnment'];

      // _attatchController.text = widget.leaveDetail['attachmentUrl'] ?? 'photo';
    }
  }

  RxBool isLoading = false.obs;

  final ImageUploadController imageController =
      Get.put(ImageUploadController());
  final DateTimeController timecontroller = Get.put(DateTimeController());
  final LoginController loginController = Get.find();
  DateTime? _selectedDateTimef;
  DateTime? _selectedDateTimet;
  TextEditingController _reasonController = TextEditingController();

  // TextEditingController _attatchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final List<String> items = ['Medical Leave', 'Annual Leave'];
  String selectedValue = 'Medical Leave';

  Future<void> _sendData() async {
    // is Loading
    isLoading.value = true;
    print(imageController.imageUrl.value);
    final todate = DateFormat('yyyy-MM-dd').format(_selectedDateTimef!);
    final fromdate = DateFormat('yyyy-MM-dd').format(_selectedDateTimet!);
    final String reason = _reasonController.text;
    final String leavetype = 'Medical leave';
    final id = loginController.userInfo['userId'].toString();
    // final String userId = controller.retrieveUserId().toString();
    final String attachment = imageController.imageUrl.value.toString();
    final response = await http.post(
      Uri.parse(Config.createLeaveRecordRoute),
      body: {
        'reasons': reason,
        'from': fromdate,
        'to': todate,
        'leaveType': leavetype,
        'attachmentUrl': attachment,
        'UserId': id
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      isLoading.value = false;
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
                  Get.off(Leave(
                    leaveDetail: {},
                  )); // Close the dialog.
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
            title: Text(' Unsuccessfully  '),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Ok'),
                onPressed: () {
                  Get.off(Leave(
                    leaveDetail: {},
                  )); // Close the dialog.
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

  void _onSubmit() async {
    if (_validate()) {
      isLoading.value = true;
      await imageController.uploadImage();

      if (imageController.imageUrl.value != null) {
        isLoading.value = true;
        _sendData();
      } else {
        print("Error: Could not retrieve the download URL");
      }
    } else {
      print("Enter Required Data");
    }
  }

  bool _validate() {
    String _leavetype = selectedValue;
    String _fromDate = _selectedDateTimef.toString();
    String _toDate = _selectedDateTimet.toString();
    String _reason = _reasonController.text;

    RxString _filename = imageController.fileName;
    if (_leavetype.isNotEmpty &&
        _fromDate.isNotEmpty &&
        _toDate.isNotEmpty &&
        _reason.isNotEmpty &&
        _filename.isNotEmpty) {
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
    final mcount = loginController.userInfo['medicalLeave'];
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.off(
          Leave(
            leaveDetail: {},
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.off(Leave(leaveDetail: {}));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    mcount == 0
                        ? Center(
                            child: Text(
                              'You have nothing attempt left',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Remaining Medical Leave attempt : ${mcount}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: screenWidth,
                        child: Column(
                          children: [
                            Container(
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 95,
                                            child: Icon(Icons.access_time),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 95,
                                            child: Icon(Icons.library_books),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 50.0),
                                            child: Container(
                                              width: 100,
                                              height: 95,
                                              child: Icon(Icons.link),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 320,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 320,
                                            height: 95,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 70,
                                                  width: 150,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: _selectedDateTimef !=
                                                              null
                                                          ? '${_selectedDateTimef!.day}/${_selectedDateTimef!.month}/${_selectedDateTimef!.year}'
                                                          : null,
                                                    ),
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
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
                                                  width: 150,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: _selectedDateTimet !=
                                                              null
                                                          ? '${_selectedDateTimet!.day}/${_selectedDateTimet!.month}/${_selectedDateTimet!.year}'
                                                          : null,
                                                    ),
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
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
                                            width: 320,
                                            height: 95,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                            height: 200,
                                            width: 200,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Obx(() {
                                                  if (imageController
                                                          .imageFile.value !=
                                                      null) {
                                                    return Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: Image.file(
                                                        imageController
                                                            .imageFile.value!,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text(
                                                        'Choose image..');
                                                  }
                                                }),
                                                IconButton(
                                                  onPressed: () {
                                                    imageController.pickImage();
                                                  },
                                                  icon: Icon(Icons.link),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => isLoading.value == true
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: SizedBox(
                                        width: 130,
                                        child: ElevatedButton(
                                          onPressed: mcount == 0
                                              ? null
                                              : () async {
                                                  _onSubmit();
                                                },
                                          child: Text(
                                            'Submit',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 8,
                                              backgroundColor:
                                                  Color(0xFFE1FF3C)),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
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
      initialDate: _selectedDateTimef ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTimef = _pickedDate;
        if (_selectedDateTimet != null &&
            _pickedDate.isAfter(_selectedDateTimet!)) {
          _selectedDateTimet = null;
        }
      });
    }
  }

  Future<void> _selectedDatet() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimet ?? _selectedDateTimef ?? DateTime.now(),
      firstDate: _selectedDateTimef ?? DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        if (_selectedDateTimef != null &&
            _pickedDate.isBefore(_selectedDateTimef!)) {
          return;
        }
        _selectedDateTimet = _pickedDate;
      });
    }
  }
}
