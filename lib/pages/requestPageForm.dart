import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ui/pages/sendingrequest.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  TextEditingController _name = TextEditingController();
  DateTime ? _date ;
  TextEditingController _reason = TextEditingController();


  bool _validate() {
 final String name = _name.text;
    final String reason = _reason.text;
 final date = DateFormat('yyyy-MM-dd').format(_date!);
    if (name.isNotEmpty &&
        date.isNotEmpty &&
        reason.isNotEmpty
       ) {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                        padding: const EdgeInsets.symmetric(vertical: 55.0),
                        child: Icon(Icons.person),
                      ),
                      // SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Icon(Icons.calendar_month),
                      ),
                      // SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Icon(Icons.my_library_books),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: SizedBox(

                          width:300,
                          child: TextField(
                            controller: TextEditingController(
                              text: _date != null
                                  ? '${_date!.day}/${_date!.month}/${_date!.year}'
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 6, backgroundColor: Color(0xFFE1FF3C)),
                child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
               _validate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
