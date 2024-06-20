// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// void main() {
//   // Initialize time zone database
//   tz.initializeTimeZones();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MedicalLeave(),
//     );
//   }
// }
//
// class MedicalLeave extends StatefulWidget {
//   @override
//   _MedicalLeaveState createState() => _MedicalLeaveState();
// }
//
// class _MedicalLeaveState extends State<MedicalLeave> {
//   tz.TZDateTime? _currentMyanmarTime;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _setCurrentMyanmarTime();
//     _startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _setCurrentMyanmarTime();
//     });
//   }
//
//   void _setCurrentMyanmarTime() {
//     final myanmarTimeZone = tz.getLocation('Asia/Rangoon');
//     final utcNow = DateTime.now().toUtc();
//     final myanmarTime = tz.TZDateTime.from(utcNow, myanmarTimeZone);
//     setState(() {
//       _currentMyanmarTime = myanmarTime;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Medical Leave'),
//       ),
//       body: Center(
//         child: _currentMyanmarTime == null
//             ? CircularProgressIndicator()
//             : Text(
//                 'Current Time in Myanmar: ${DateFormat('yyyy-MM-dd hh:mm:ss a').format(_currentMyanmarTime!)}',
//                 style: TextStyle(fontSize: 20),
//               ),
//       ),
//     );
//   }
// }
