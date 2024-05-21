import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/sendingrequest.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _reason = TextEditingController();

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
                        padding: const EdgeInsets.symmetric(vertical: 55.0),
                        child: Icon(Icons.person),
                      ),
                      // SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Icon(Icons.email),
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
                          width: 300,
                          child: TextField(
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter email',
                              border: OutlineInputBorder(),
                            ),
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
