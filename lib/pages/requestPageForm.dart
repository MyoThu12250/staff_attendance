import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/sendingrequest.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  DateTime? _selectedDateTime;
  TextEditingController _email = TextEditingController();
  TextEditingController _reason = TextEditingController();

  String _selectedItem = 'item 1';

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
    return SafeArea(
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
                        padding: const EdgeInsets.symmetric(vertical: 80.0),
                        child: Icon(Icons.access_time),
                      ),
                      // SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Icon(Icons.my_library_books),
                      ),
                    ],
                  ),
                  Column(
                    children: [
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
                  Get.off(RequestPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
