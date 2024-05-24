import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TestLeave(),
  ));
}

class TestLeave extends StatefulWidget {
  const TestLeave({Key? key}) : super(key: key);

  @override
  State<TestLeave> createState() => _TestLeaveState();
}

class _TestLeaveState extends State<TestLeave> {
  var status = 'rejected'; // Example status, change this as needed

  // Function to return icon based on status
  IconData getIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'accepted':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.error;
    }
  }

  Color getColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.grey;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Icon(
                    getIcon(status),
                    color: getColor(status),
                  ),
                  // Use the getIcon function to get the appropriate icon
                  title: Text('ahhuerhru'),
                  subtitle: Text('asfrhauiwe'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
