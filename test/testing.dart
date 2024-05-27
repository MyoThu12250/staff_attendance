// // // // // // // import 'dart:io';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:firebase_storage/firebase_storage.dart';
// // // // // // // import 'package:image_picker/image_picker.dart';
// // // // // // // import 'package:firebase_core/firebase_core.dart';
// // // // // // //
// // // // // // // void main() async {
// // // // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // // // //   await Firebase.initializeApp();
// // // // // // //   runApp(MyImageUploadScreen());
// // // // // // // }
// // // // // // //
// // // // // // // class MyImageUploadScreen extends StatelessWidget {
// // // // // // //   // Future<void> _uploadImage() async {
// // // // // // //   //   final picker = ImagePicker();
// // // // // // //   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
// // // // // // //   //
// // // // // // //   //   if (pickedFile != null) {
// // // // // // //   //     final file = File(pickedFile.path);
// // // // // // //   //     final Reference storageRef = FirebaseStorage.instance
// // // // // // //   //         .ref()
// // // // // // //   //         .child('images/${DateTime.now().toString()}');
// // // // // // //   //     await storageRef.putFile(file);
// // // // // // //   //     print('Image uploaded to Firebase Storage');
// // // // // // //   //   } else {
// // // // // // //   //     print('No image selected.');
// // // // // // //   //   }
// // // // // // //   // }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: Text('Upload Image to Firebase'),
// // // // // // //       ),
// // // // // // //       body: Center(
// // // // // // //         child: ElevatedButton(
// // // // // // //           onPressed: () {},
// // // // // // //           child: Text('Select Image'),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // //
// // // // // // import 'package:flutter/material.dart';
// // // // // //
// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }
// // // // // //
// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       home: Scaffold(
// // // // // //         appBar: AppBar(
// // // // // //           title: Text('Dropdown Example'),
// // // // // //         ),
// // // // // //         body: ElevatedButton(
// // // // // //           onPressed: () {
// // // // // //             _showDialog(context);
// // // // // //           },
// // // // // //           child: Text('Dialog'),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _showDialog(BuildContext context) async {
// // // // // //     return showDialog<void>(
// // // // // //       context: context,
// // // // // //       barrierDismissible: false,
// // // // // //       // Dialog is dismissible with a tap on the barrier.
// // // // // //       builder: (BuildContext context) {
// // // // // //         return AlertDialog(
// // // // // //           title: Text('Dialog Title'),
// // // // // //           content: SingleChildScrollView(
// // // // // //             child: ListBody(
// // // // // //               children: <Widget>[
// // // // // //                 Text('This is a Flutter dialog box.'),
// // // // // //                 Text('You can add any content here.'),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //           actions: <Widget>[
// // // // // //             TextButton(
// // // // // //               child: Text('Close'),
// // // // // //               onPressed: () {
// // // // // //                 Navigator.of(context).pop(); // Close the dialog.
// // // // // //               },
// // // // // //             ),
// // // // // //           ],
// // // // // //         );
// // // // // //       },
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // // import 'package:flutter/material.dart';
// // // // //
// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }
// // // // //
// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       // Wrap your app with MaterialApp
// // // // //       title: 'My App',
// // // // //       home: MyHomePage(),
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // // // Future<void> _showDialog(BuildContext context) async {
// // // // //   return showDialog<void>(
// // // // //     context: context,
// // // // //     barrierDismissible: false,
// // // // //     // Dialog is dismissible with a tap on the barrier.
// // // // //     builder: (BuildContext context) {
// // // // //       return AlertDialog(
// // // // //         title: Text('Dialog Title'),
// // // // //         content: SingleChildScrollView(
// // // // //           child: ListBody(
// // // // //             children: <Widget>[
// // // // //               Text('This is a Flutter dialog box.'),
// // // // //               Text('You can add any content here.'),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //         actions: <Widget>[
// // // // //           TextButton(
// // // // //             child: Text('Close'),
// // // // //             onPressed: () {
// // // // //               Navigator.of(context).pop(); // Close the dialog.
// // // // //             },
// // // // //           ),
// // // // //         ],
// // // // //       );
// // // // //     },
// // // // //   );
// // // // // }
// // // // //
// // // // // class MyHomePage extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Home'),
// // // // //       ),
// // // // //       body: Center(
// // // // //         child: ElevatedButton(
// // // // //           onPressed: () {
// // // // //             // Show dialog box here
// // // // //
// // // // //             _showDialog(context);
// // // // //           },
// // // // //           child: Text('Show Dialog'),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // import 'dart:ui';
// // // //
// // // // import 'package:flutter/material.dart';
// // // //
// // // // void main() {
// // // //   runApp(MyApp());
// // // // }
// // // //
// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       home: Scaffold(
// // // //         appBar: AppBar(
// // // //           title: Text('Blurred Card Example'),
// // // //         ),
// // // //         body: Center(
// // // //           child: Container(
// // // //             width: 300,
// // // //             height: 200,
// // // //             child: ClipRRect(
// // // //               borderRadius: BorderRadius.circular(10.0),
// // // //               child: BackdropFilter(
// // // //                 filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
// // // //                 child: Card(
// // // //                   elevation: 1,
// // // //                   // Optional: You can remove the default elevation of the card
// // // //                   color: Colors.red.withOpacity(0.3),
// // // //                   // Adjust opacity as needed
// // // //                   child: Center(
// // // //                     child: Text(
// // // //                       'Blurred Card',
// // // //                       style: TextStyle(color: Colors.black, fontSize: 24.0),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // //
// // // void main() {
// // //   runApp(MaterialApp(
// // //     home: YourWidget(),
// // //   ));
// // // }
// // //
// // // class YourWidget extends StatefulWidget {
// // //   @override
// // //   _YourWidgetState createState() => _YourWidgetState();
// // // }
// // //
// // // class _YourWidgetState extends State<YourWidget> {
// // //   DateTime? _selectedDateTime;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return SizedBox(
// // //       height: 50,
// // //       width: 90,
// // //       child: TextField(
// // //         readOnly: true,
// // //         decoration: InputDecoration(
// // //           labelText: 'From',
// // //           hintText: 'From',
// // //           suffixIcon: Icon(
// // //             Icons.date_range,
// // //             size: 20,
// // //           ),
// // //         ),
// // //         onTap: () {
// // //           _selectedDate();
// // //         },
// // //         controller: TextEditingController(
// // //           text: _selectedDateTime != null
// // //               ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}'
// // //               : null,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Future<void> _selectedDate() async {
// // //     final pickedDate = await showDatePicker(
// // //       context: context,
// // //       initialDate: DateTime.now(),
// // //       firstDate: DateTime(2000),
// // //       lastDate: DateTime(2100),
// // //     );
// // //
// // //     if (pickedDate != null) {
// // //       setState(() {
// // //         _selectedDateTime = pickedDate;
// // //       });
// // //     }
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:table_calendar/table_calendar.dart';
// //
// // void main() {
// //   runApp(MaterialApp(
// //     home: MyCalendarPage(),
// //   ));
// // }
// //
// // class MyCalendarPage extends StatefulWidget {
// //   @override
// //   _MyCalendarPageState createState() => _MyCalendarPageState();
// // }
// //
// // class _MyCalendarPageState extends State<MyCalendarPage> {
// //   CalendarFormat _calendarFormat = CalendarFormat.month;
// //   DateTime _focusedDay = DateTime.now();
// //   DateTime _selectedDay = DateTime.now();
// //
// //   // Example list of events per day
// //   Map<DateTime, List<String>> _events = {
// //     DateTime(2024, 4, 10): ['Event A', 'Event B'],
// //     DateTime(2024, 5, 15): ['Event C'],
// //     DateTime(2024, 5, 20): ['Event D', 'Event E'],
// //     // Add more events as needed
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Calendar with Events'),
// //       ),
// //       body: Column(
// //         children: [
// //           TableCalendar(
// //             firstDay: DateTime.utc(2024, 1, 1),
// //             lastDay: DateTime.utc(2024, 12, 31),
// //             focusedDay: _focusedDay,
// //             calendarFormat: _calendarFormat,
// //             startingDayOfWeek: StartingDayOfWeek.monday,
// //             eventLoader: (day) {
// //               return _events[day] ?? [];
// //             },
// //             onFormatChanged: (format) {
// //               setState(() {
// //                 _calendarFormat = format;
// //               });
// //             },
// //             onPageChanged: (focusedDay) {
// //               _focusedDay = focusedDay;
// //             },
// //             onDaySelected: (selectedDay, focusedDay) {
// //               setState(() {
// //                 _selectedDay = selectedDay;
// //                 _focusedDay = focusedDay;
// //               });
// //             },
// //             calendarStyle: CalendarStyle(
// //               markerDecoration: BoxDecoration(color: Colors.red),
// //               // markersColor: Colors.blue,
// //               todayDecoration: BoxDecoration(
// //                 color: Colors.red,
// //                 shape: BoxShape.circle,
// //               ),
// //               selectedDecoration: BoxDecoration(
// //                 color: Colors.green,
// //                 shape: BoxShape.circle,
// //               ),
// //               todayTextStyle: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 18,
// //                 color: Colors.white,
// //               ),
// //               selectedTextStyle: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 18,
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ),
// //           // You can display events for the selected day here
// //           if (_events.containsKey(_selectedDay))
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: _events[_selectedDay]!.length,
// //                 itemBuilder: (context, index) {
// //                   return ListTile(
// //                     title: Text(_events[_selectedDay]![index]),
// //                   );
// //                 },
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // Copyright 2019 Aleksander Woźniak
// // SPDX-License-Identifier: Apache-2.0
//
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:project_ui/pages/home.dart';
//
// //
// // import 'pages/basics_example.dart';
// // import 'pages/complex_example.dart';
// // import 'pages/events_example.dart';
// // import 'pages/multi_example.dart';
// // import 'pages/range_example.dart';
//
// void main() {
//   initializeDateFormatting().then((_) => runApp(MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TableCalendar Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StartPage(),
//     );
//   }
// }
//
// class StartPage extends StatefulWidget {
//   @override
//   _StartPageState createState() => _StartPageState();
// }
//
// class _StartPageState extends State<StartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               child: Text('Basics'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HomePage()),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             ElevatedButton(
//               child: Text('Range Selection'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HomePage()),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             ElevatedButton(
//               child: Text('Events'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HomePage()),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             ElevatedButton(
//               child: Text('Multiple Selection'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HomePage()),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             ElevatedButton(
//               child: Text('Complex'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HomePage()),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//           ],
//         ),
//       ),
//     );
//   }
//

import 'package:Global_TA/Controller/testController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'testingForm.dart';

void main() {
  Get.put(TestController());
  runApp(GetMaterialApp(
    home: Test(),
  ));
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  TestController c = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              c.getData();
            },
            child: Text('Get data'),
          ),
          Obx(() => Expanded(
              child: ListView.builder(
                  itemCount: c.leaveList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      title: Text(c.leaveList[index].leaveType),
                      trailing: IconButton(
                          onPressed: () async {},
                          icon: Icon(Icons.delete_forever)),
                    );
                  })))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
