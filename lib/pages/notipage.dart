import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Notification'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 5,
                      ),
                      child: ListTile(
                        title: Text(
                          'Request Rejected',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'May, 12, 2024',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Your Request Rejected blah blah',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
