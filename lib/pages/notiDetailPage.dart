import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notipage.dart';

class NotiDetailPage extends StatefulWidget {
  const NotiDetailPage({super.key});

  @override
  State<NotiDetailPage> createState() => _NotiDetailPageState();
}

class _NotiDetailPageState extends State<NotiDetailPage> {
  IconData getIcon(String status) {
    switch (status.toLowerCase()) {
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
    switch (status.toLowerCase()) {
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
    final String status = 'Pending';

    return WillPopScope(
      onWillPop: () async {
        Get.off(NotiPage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.off(NotiPage());
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
              )),
        ),
        body: Card(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  height: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                'Request status',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Leave Type',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              'Duration',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                'Reason',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              'Approved info',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Icon(
                                getIcon(status),
                                color: getColor(status),
                              ),
                            ),
                            Text(
                              'Medical or Annual Leave',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                '12/2/24',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              'From: 12/2/24 to: 14/2/24',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                'Something...............',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              'Approverd asgurguievn',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
