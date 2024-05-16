import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/sendingrequest.dart';
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
        ),
      ),
      //
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                Get.to(
                  HomePage(),
                );
              },
              child: Image.asset(
                'assets/icons/home.png',
                width: 30,
                color: Colors.black,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(Leave(), transition: Transition.rightToLeftWithFade);
              },
              child: Image.asset(
                'assets/icons/leave.png',
                width: 30,
                color: Colors.black,
              ),
            ),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(RequestPage(),
                    transition: Transition.rightToLeftWithFade);
              },
              child: Image.asset(
                'assets/icons/attendance_history.png',
                width: 30,
              ),
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(Calender(), transition: Transition.rightToLeftWithFade);
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 30,
              ),
            ),
            label: 'Calendar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        selectedIconTheme: IconThemeData(
          size: 35,
          color: Color(0xFFE1FF3C),
        ),
        onTap: _onItemTapped,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //           onPressed: () {
      //             Get.to(HomePage());
      //           },
      //           icon: Icon(
      //             Icons.home,
      //             color: Colors.black,
      //           )),
      //       label: "Home",
      //       // activeIcon: Icon(Icons.home_sharp)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () {
      //           Get.to(Leave());
      //         },
      //         icon: Icon(Icons.exit_to_app),
      //         color: Colors.black,
      //       ),
      //       label: "Leave",
      //       // activeIcon: Icon(Icons.exit_to_app_sharp)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.fact_check),
      //         color: Colors.black,
      //       ),
      //       label: "Request",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () {
      //           Get.to(Calender());
      //         },
      //         icon: Icon(Icons.calendar_month),
      //         color: Colors.black,
      //       ),
      //       label: "Calender",
      //       // activeIcon: Icon(Icons.calendar_month_sharp)
      //     ),
      //   ],
      // ),
    );
  }
}
