import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/detailPages/attendanceHistoryDetail.dart';
import 'package:project_ui/pages/home.dart';
import 'package:project_ui/pages/leave.dart';
import 'package:project_ui/pages/requestPageForm.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Attendance History'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.off(AttendanceHistoryDetail());
                            },
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date : 12/2/2024',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'In time : 9:30',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Out time : 3:30',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
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
          // onPress: () {
          //   Get.to(RequestPageForm());
          // },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       // label: 'Home',
        //       // icon: IconButton(
        //       //   onPressed: () {
        //       //     Get.off(HomePage(), transition: Transition.fadeIn);
        //       //   },
        //       //   icon: Image.asset(
        //       //     'assets/icons/home.png',
        //       //     color: Colors.black,
        //       //     width: 30,
        //       //   ),
        //       // ),
        //       icon: InkWell(
        //         onTap: () {
        //           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
        //           Get.off(HomePage(), transition: Transition.fadeIn);
        //         },
        //         child: Image.asset(
        //           'assets/icons/home.png',
        //           width: 30,
        //           color: Colors.black,
        //         ),
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       // label: 'Leave',
        //       // icon: IconButton(
        //       //   onPressed: () {},
        //       //   icon: Image.asset(
        //       //     'assets/icons/leave.png',
        //       //     width: 30,
        //       //     color: Colors.black,
        //       //   ),
        //       // )
        //       icon: InkWell(
        //         onTap: () {
        //           Get.off(Leave(), transition: Transition.fadeIn);
        //         },
        //         child: Image.asset(
        //           'assets/icons/leave.png',
        //           width: 30,
        //           color: Colors.black,
        //         ),
        //       ),
        //       label: 'Leave',
        //     ),
        //     BottomNavigationBarItem(
        //       // label: 'Attendance',
        //       // icon: IconButton(
        //       //     onPressed: () {},
        //       //     icon: Image.asset(
        //       //       'assets/icons/attendance_history.png',
        //       //       width: 30,
        //       //       color: Colors.green,
        //       //     ))
        //       icon: InkWell(
        //         onTap: () {
        //           Get.off(RequestPage(), transition: Transition.fadeIn);
        //         },
        //         child: Image.asset(
        //           'assets/icons/attendance_history.png',
        //           width: 30,
        //         ),
        //       ),
        //       label: 'Attendance',
        //     ),
        //     BottomNavigationBarItem(
        //       // label: 'Calendar',
        //       // icon: IconButton(
        //       //   onPressed: () {},
        //       //   icon: Icon(
        //       //     Icons.calendar_month,
        //       //     color: Colors.black,
        //       //   ),
        //       // ),
        //       icon: InkWell(
        //         onTap: () {
        //           Get.off(Calender(), transition: Transition.fadeIn);
        //         },
        //         child: Icon(
        //           Icons.calendar_month,
        //           color: Colors.black,
        //           size: 30,
        //         ),
        //       ),
        //       label: 'Calendar',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.green,
        //   selectedIconTheme: IconThemeData(
        //     size: 35,
        //     color: Color(0xFFE1FF3C),
        //   ),
        //   onTap: _onItemTapped,
        //   type: BottomNavigationBarType.fixed,
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(HomePage(), transition: Transition.fadeIn);
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
                  Get.off(Leave(), transition: Transition.fadeIn);
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
                  Get.off(RequestPage(), transition: Transition.fadeIn);
                },
                icon: Image.asset(
                  'assets/icons/attendance_history.png',
                  color: Colors.green,
                  width: 35,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(Calender(), transition: Transition.fadeIn);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
