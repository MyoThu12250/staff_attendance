import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homepage.dart';
import 'leave.dart';

class Calender extends StatefulWidget {
  late final Map<String, dynamic> leaveDetail;

  Calender({required this.leaveDetail});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime? _selectedDay;

  DateTime? _focusedDay;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage(
          leaveDetail: {},
        ));
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Calender'),
        // ),
        body: MediaQuery(
          data: MediaQuery.of(context),
          child: Center(
            child: Text(
              'Coming soon',
              style: TextStyle(
                fontSize: 50,
                color: Colors.amber,
              ),
            ),
          ),
          // child: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Container(
          //         // color: Colors.lightBlueAccent.withOpacity(0.5),
          //         width: screenWidth,
          //         height: screenHeight * 0.47,
          //         child: TableCalendar(
          //           firstDay: DateTime.utc(2024, 4, 1),
          //           lastDay: DateTime.utc(2030, 3, 14),
          //           focusedDay: DateTime.now(),
          //           selectedDayPredicate: (day) {
          //             return isSameDay(_selectedDay, day);
          //           },
          //           onDaySelected: (selectedDay, focusedDay) {
          //             setState(() {
          //               _selectedDay = selectedDay;
          //               _focusedDay = focusedDay;
          //             });
          //           },
          //           onPageChanged: (focusedDay) {
          //             _focusedDay = focusedDay;
          //           },
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 30.0, left: 20.0),
          //         child: Container(
          //           height: screenHeight * .3,
          //           width: screenWidth,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(Icons.date_range),
          //                   Icon(Icons.watch_later_outlined),
          //                   Icon(Icons.location_on_outlined),
          //                   Icon(Icons.lan),
          //                   Icon(Icons.medication),
          //                 ],
          //               ),
          //               SizedBox(
          //                 width: 300,
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.all(4.0),
          //                       child: Text('Mon, May 20 2024'),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.all(4.0),
          //                       child: Text('From 8:30 to 4:30'),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.all(4.0),
          //                       child: Text('L1 Developer'),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.all(4.0),
          //                       child: Text('AGB Communication'),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.all(4.0),
          //                       child: Text('Medical Leave'),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ),
        //
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
                        leaveDetail: widget.leaveDetail,
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
                  color: Colors.black,
                  width: 35,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(
                      Calender(
                        leaveDetail: {},
                      ),
                      transition: Transition.fadeIn);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
