import 'package:flutter/material.dart';

class RequestDetailPage extends StatelessWidget {
  final dynamic requestDetail;

  RequestDetailPage({required this.requestDetail});

  IconData getIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.error;
    }
  }

  Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.grey;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    var reason = requestDetail['reason'] ?? 'N/A';
    var status = requestDetail['status'] ?? 'N/A';
    var date = requestDetail['date'] ?? 'N/A';
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Detail'),
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
                  date.toString(),
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
                  'Reason',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  reason.toString(),
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
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      status.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      getIcon(status),
                      color: getColor(status),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
