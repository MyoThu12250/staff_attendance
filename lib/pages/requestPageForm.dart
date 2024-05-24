import 'package:Global_TA/pages/sendingrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  DateTime? _selectedDateTime;

  final int Rcount = 0;
  TextEditingController _reason = TextEditingController();

  String dropdownValue = 'Check In';

  Future<void> _selectedDatef() async {
    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _selectedDateTime = _pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(RequestPage());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.off(
                  RequestPage(),
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
                          Get.off(RequestPage());
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
