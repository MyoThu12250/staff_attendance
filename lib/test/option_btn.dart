import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OptionButtonExample(),
    );
  }
}

class OptionButtonExample extends StatefulWidget {
  @override
  _OptionButtonExampleState createState() => _OptionButtonExampleState();
}

class _OptionButtonExampleState extends State<OptionButtonExample> {
  String maptype = 'normal';

  void _selectOption(String choice) {
    setState(() {
      maptype = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuButton Example'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _selectOption,
            itemBuilder: (BuildContext context) {
              return {'normal', 'satellite', 'transit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Selected option: $maptype'),
      ),
    );
  }
}
