import 'package:flutter/material.dart';

class RequestPageForm extends StatefulWidget {
  const RequestPageForm({super.key});

  @override
  State<RequestPageForm> createState() => _RequestPageFormState();
}

class _RequestPageFormState extends State<RequestPageForm> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text('Sending Request Form'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                label: Text('NAME'),
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                label: Text('Email'),
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  label: Text('Reason'),
                  hintText: 'Reason',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
