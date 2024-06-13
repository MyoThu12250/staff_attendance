// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class TimeDisplayScreen extends StatefulWidget {
//   @override
//   _TimeDisplayScreenState createState() => _TimeDisplayScreenState();
// }
//
// class _TimeDisplayScreenState extends State<TimeDisplayScreen> {
//   late Stream<DateTime> _timeStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _timeStream = _getTimeStream();
//   }
//
//   Stream<DateTime> _getTimeStream() async* {
//     while (true) {
//       try {
//         final response = await http
//             .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Yangon'));
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final dateTimeString = data['datetime'];
//           final dateTime = DateTime.parse(dateTimeString)
//               .toUtc()
//               .add(Duration(hours: 6, minutes: 30)); // Adjust to UTC +6:30
//           yield dateTime;
//         } else {
//           throw Exception('Failed to load time');
//         }
//       } catch (e) {
//         yield DateTime.now().toUtc().add(Duration(
//             hours: 6, minutes: 30)); // Default to UTC +6:30 if there's an error
//       }
//       await Future.delayed(Duration(seconds: 1));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Myanmar Time Display'),
//       ),
//       body: Center(
//         child: StreamBuilder<DateTime>(
//           stream: _timeStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final dateTime = snapshot.data!;
//               final hour = dateTime.hour.toString().padLeft(2, '0');
//               final minute = dateTime.minute.toString().padLeft(2, '0');
//               final second = dateTime.second.toString().padLeft(2, '0');
//               final amPm = dateTime.hour < 12 ? 'AM' : 'PM';
//
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '$hour:',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   Text(
//                     '$minute:',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   Text(
//                     '$second ',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   Text(
//                     amPm,
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return SizedBox(
//                 height: 50,
//                 width: 130,
//                 child: Center(
//                   child: Text(
//                     'Loading....',
//                     style: TextStyle(
//                       fontFamily: 'Epilogue',
//                     ),
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
