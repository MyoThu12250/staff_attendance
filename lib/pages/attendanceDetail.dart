import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDetailPage extends StatelessWidget {
  final Map<String, dynamic> attendanceDetail;

  AttendanceDetailPage({required this.attendanceDetail});

  @override
  Widget build(BuildContext context) {
    var inTime = attendanceDetail['in_time'] ?? 'N/A';
    var outTime = attendanceDetail['out_time'] ?? 'N/A';
    var lateTime = attendanceDetail['late_in_time'] ?? 'N/A';
    var earlyTime = attendanceDetail['early_out_time'] ?? 'N/A';
    var date = DateTime.parse(attendanceDetail['date'] ?? 'N/A');
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formattedDate.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'In Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  inTime.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Out Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  outTime.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Early Out Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  earlyTime.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Late Out Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  lateTime.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
