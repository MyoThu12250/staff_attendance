import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  final String notificationData;

  NotiPage({required this.notificationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Data'),
      ),
      body: Center(
        child: Text(notificationData),
      ),
    );
  }
}
