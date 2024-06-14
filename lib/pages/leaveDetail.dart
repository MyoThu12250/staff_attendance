import 'package:CheckMate/pages/half_day_leave.dart';
import 'package:CheckMate/pages/session_expire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../config_route.dart';
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
    var id = widget.leaveDetail['id'];
    var leaveType = widget.leaveDetail['leaveType'];
    var status = widget.leaveDetail['status'];
    var date = DateTime.parse(widget.leaveDetail['createdAt']);
    var reason = widget.leaveDetail['reasons'];
    var from = widget.leaveDetail['from'];
    var to = widget.leaveDetail['to'];
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    Future<void> Delete() async {
      try {
        final response = await http.delete(
          Uri.parse('${Config.deleteLeaveRecordByIdRoute}/$id'),
          headers: {
            'Authorization': 'Bearer ${loginController.authorization.value}',
          },
        );

        if (response.statusCode == 200) {
          Get.snackbar('Success', 'Your Leave Record Successfully Deleted.',
              backgroundColor: Colors.greenAccent,
              duration: const Duration(seconds: 4));
          Get.offAllNamed('/leave');
        } else if (response.statusCode == 401) {
          showSessionExpiredDialog();
        } else {
          // Handle server error
          print('Failed to delete: ${response.statusCode}');
          Get.snackbar('Fail', 'Unable to Delete. Please try again.',
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4));
        }
      } catch (e) {
        // Handle network error
        print('Error Deleting: $e');
        Get.snackbar('Error', 'An error occurred. Please try again.',
            backgroundColor: Colors.red, duration: const Duration(seconds: 4));
      }
    }

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
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Reason',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Duration',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        maxLines: 1,
                        reason.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
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
                          if (leaveType.toLowerCase().trim() ==
                              'Medical Leave'.toLowerCase().trim()) {
                            Get.to(MedicalLeave(
                                isedit: true.obs,
                                leaveDetail: widget.leaveDetail));
                          } else if (leaveType.toLowerCase().trim() ==
                              'Annual Leave'.toLowerCase().trim()) {
                            Get.to(AnnualLeave(
                                isedit: true, leaveDetail: widget.leaveDetail));
                          } else {
                            Get.to(HalfDayLeave(
                                isedit: true, leaveDetail: widget.leaveDetail));
                          }
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
                          Delete();
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
