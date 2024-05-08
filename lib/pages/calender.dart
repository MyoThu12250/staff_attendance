import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/approves.dart';
import 'package:table_calendar/table_calendar.dart';

import 'homepage.dart';
import 'leave.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime? _selectedDay;

  DateTime? _focusedDay;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calender'),
      ),
      body: MediaQuery(
          data: MediaQuery.of(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.lightBlueAccent.withOpacity(0.5),
                  width: screenWidth,
                  height: screenHeight * 0.47,
                  child: TableCalendar(
                    firstDay: DateTime.utc(2024, 4, 1),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: Container(
                    height: screenHeight * .3,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range),
                            Icon(Icons.watch_later_outlined),
                            Icon(Icons.location_on_outlined),
                            Icon(Icons.lan),
                            Icon(Icons.medication),
                          ],
                        ),
                        SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Mon, May 20 2024'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('From 8:30 to 4:30'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('L1 Developer'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('AGB Communication'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Medical Leave'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purpleAccent.withOpacity(0.3),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Get.to(HomePage());
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            label: "Home",
            // activeIcon: Icon(Icons.home_sharp)
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Leave());
              },
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
            ),
            label: "Leave",
            // activeIcon: Icon(Icons.exit_to_app_sharp)
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Calender());
              },
              icon: Icon(Icons.calendar_month),
              color: Colors.white,
            ),
            label: "Calender",
            // activeIcon: Icon(Icons.calendar_month_sharp)
          ),
          // BottomNavigationBarItem(
          //   icon: IconButton(
          //     onPressed: () {
          //       Get.to(ApprovePage());
          //     },
          //     icon: Icon(Icons.history),
          //     color: Colors.white,
          //   ),
          //   label: "History",
          // ),
        ],
      ),
    );
  }
}
