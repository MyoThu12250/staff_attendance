// // // import 'package:flutter/material.dart';
// // //
// // // void main() {
// // //   runApp(MaterialApp(
// // //     home: Leave(),
// // //   ));
// // // }
// // //
// // // class Leave extends StatefulWidget {
// // //   const Leave({super.key});
// // //
// // //   @override
// // //   State<Leave> createState() => _LeaveState();
// // // }
// // //
// // // class _LeaveState extends State<Leave> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(),
// // //     );
// // //   }
// // // }
// //
// // //-----------------------
// //
// // import 'package:flutter/material.dart';
// //
// // void main() => runApp(MyApp());
// //
// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   List<bool> _selections = List.generate(3, (_) => false);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(title: Text('Custom ToggleButtons')),
// //         body: Center(
// //           child: ToggleButtons(
// //             isSelected: _selections,
// //             onPressed: (int index) {
// //               setState(() {
// //                 _selections[index] = !_selections[index];
// //               });
// //             },
// //             color: Colors.black,
// //             selectedColor: Colors.red,
// //             fillColor: Colors.yellow,
// //             splashColor: Colors.blue,
// //             highlightColor: Colors.green,
// //             borderColor: Colors.black,
// //             selectedBorderColor: Colors.red,
// //             borderWidth: 2,
// //             borderRadius: BorderRadius.circular(10),
// //             children: <Widget>[
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text('Button 1'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text('Button 2'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text('Button 3'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<bool> _selections = List.generate(3, (_) => false);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('ToggleButtons Example')),
//         body: Center(
//           child: ToggleButtons(
//             isSelected: _selections,
//             onPressed: (int index) {
//               setState(() {
//                 _selections[index] = !_selections[index];
//               });
//             },
//             children: <Widget>[
//               Icon(Icons.ac_unit),
//               Icon(Icons.call),
//               Icon(Icons.cake),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<bool> _selections = List.generate(3, (_) => false);

  void _toggleButtons() {
    setState(() {
      // Toggle all buttons when the FAB is pressed
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = !_selections[i];
      }
    });
  }

  void _resetButtons() {
    setState(() {
      // Reset all buttons to false
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ToggleButtons with FAB'),
        ),
        body: Container(),
        floatingActionButton: SpeedDial(
          child: Icon(Icons.add),
          activeIcon: Icons.close,
          buttonSize: Size(58, 58),
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              child: Icon(Icons.phone),
              labelWidget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('Page 1'),
              ),
            ),
            SpeedDialChild(
              child: Icon(Icons.message),
            ),
          ],
        ),
      ),
    );
  }
}
