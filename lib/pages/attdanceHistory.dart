import 'package:CheckMate/pages/attdanceRequestForm.dart';
import 'package:CheckMate/pages/attdanceRequestHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../Controller/attendanceController.dart';
import 'attendanceDetail.dart';
import 'homepage.dart';
import 'leave.dart';

class RequestPage extends StatefulWidget {
  late final Map<String, dynamic> attendanceDetail;

  RequestPage({required this.attendanceDetail});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<RequestPage> {
  final AddController addController = Get.put(AddController());

  @override
  void initState() {
    super.initState();
    addController.fetchAttendanceHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage(leaveDetail: {}));
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: 90,
            title: Text('Attendance History'),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Image.asset(
                'assets/icons/appIcon.png',
              ),
            ),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      color: Colors.lightGreenAccent,
                      child: TabBar(
                        tabs: [
                          Text('Attendance History'),
                          Text('Attendance Request History'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(
                          () {
                        if (addController.attendanceData.isEmpty &&
                            addController.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                                addController.hasMoreData &&
                                !addController.isLoading) {
                              addController.fetchAttendanceHistory(context);
                            }
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: addController.attendanceData.isEmpty
                                ? Center(
                                child: Text(
                                  'Empty Attendance Data',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Epilogue',
                                  ),
                                ))
                                : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 0.5,
                                  color: Colors.black,
                                );
                              },
                              itemCount:
                              addController.attendanceData.length,
                              itemBuilder: (context, index) {
                                final item =
                                addController.attendanceData[index];
                                return GestureDetector(
                                  child: ListTile(
                                    leading: item['in_time'] != null &&
                                        item['in_time'].isNotEmpty &&
                                        item['out_time'] != null &&
                                        item['out_time'].isNotEmpty
                                        ? CircleAvatar(
                                      backgroundColor:
                                      Colors.greenAccent,
                                      child: Icon(Icons.done),
                                    )
                                        : CircleAvatar(
                                      backgroundColor: Colors.pink,
                                      child: Icon(Icons.close),
                                    ),
                                    title: Text('Date: ${item['date']}'),
                                    subtitle: Text(
                                        'In Time: ${item['in_time'] ?? 'N/A'}\nOut Time: ${item['out_time'] ?? 'N/A'}'),
                                    onTap: () {
                                      Get.to(
                                            () => AttendanceDetailPage(
                                            attendanceDetail: item),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    RequestHistoryPage()
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            child: Icon(Icons.add),
            children: [
              SpeedDialChild(
                elevation: 0,
                child: Icon(Icons.medication),
                labelWidget: Text('Request Form'),
                onTap: () {
                  Get.off(RequestPageForm());
                },
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Get.off(
                        HomePage(
                          leaveDetail: {},
                        ),
                        transition: Transition.fadeIn);
                  },
                  icon: Image.asset(
                    'assets/icons/home.png',
                    color: Colors.black,
                    width: 35,
                  ),
                ),
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Get.off(
                        Leave(
                          leaveDetail: {},
                        ),
                        transition: Transition.fadeIn);
                  },
                  icon: Image.asset(
                    'assets/icons/leave.png',
                    color: Colors.black,
                    width: 35,
                  ),
                ),
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Get.off(
                        RequestPage(
                          attendanceDetail: {},
                        ),
                        transition: Transition.fadeIn);
                  },
                  icon: Image.asset(
                    'assets/icons/attendance_history.png',
                    color: Colors.green,
                    width: 35,
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
