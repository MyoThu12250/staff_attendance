import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Wrap Example')),
        body: Center(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 4.0,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Center(
                    child: Text('1',
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: Center(
                    child: Text('2',
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                    child: Text('3',
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text('4',
                        style: TextStyle(color: Colors.black, fontSize: 20))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
