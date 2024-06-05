import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'annualLeave.dart';
import 'medicalLeave.dart';

class LeaveDetailPage extends StatefulWidget {
  final Map<String, dynamic> leaveDetail;

  LeaveDetailPage({required this.leaveDetail});

  @override
  State<LeaveDetailPage> createState() => _LeaveDetailPageState();
}

class _LeaveDetailPageState extends State<LeaveDetailPage> {
  @override
  Widget build(BuildContext context) {
    var leaveType = widget.leaveDetail['leaveType'];
    var status = widget.leaveDetail['status'];
    var date = DateTime.parse(widget.leaveDetail['createdAt']);
    var reason = widget.leaveDetail['reasons'];
    var from = widget.leaveDetail['from'];
    var to = widget.leaveDetail['to'];
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Detail'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'Leave Type',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Reason',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        leaveType,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      reason.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From- ${from}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'To- ${to}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            getIcon(status),
                            color: getColor(status),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          status.toLowerCase() == 'pending'.toLowerCase()
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          leaveType.toLowerCase().trim() ==
                                  'Medical Leave'.toLowerCase().trim()
                              ? Get.off(MedicalLeave(
                                  isedit: true,
                                  leaveDetail: widget.leaveDetail))
                              : Get.off(AnnualLeave(
                                  isedit: true,
                                  leaveDetail: widget.leaveDetail));
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.lightGreenAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Perform delete method',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              action: SnackBarAction(
                                  label: 'Undo', onPressed: () {}),
                            ),
                          );
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              : Spacer(),
          // : Spacer();
        ],
      ),
    );
  }
}
