import 'dart:convert';

import 'package:CheckMate/config_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request with Bearer Token'),
        ),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiUrl = Config.testRoute;
  final String accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySW5mbyI6eyJlbXBJZCI6IjEwMCIsInJvbGUiOjEwMDB9LCJpYXQiOjE3MTgwOTI0NzQsImV4cCI6MTcxODEwMzI3NH0.PfebKzmZy42wSQm4EAmuCVeauAZfOqNt-egayAzd57A'; // Replace with your actual access token

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      // Handle the data
    } else {
      print(response.statusCode);
      print('Failed to load data');
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: fetchData,
          child: Text('Fetch Data'),
        ),
      ],
    );
  }
}
