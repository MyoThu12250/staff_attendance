import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/medicalLeave.dart';
import 'package:project_ui/pages/sendingrequest.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
          // title: Center(child: Text('Leave Page')),
          ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth * 1,
              height: screenHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(MedicalLeave());
                      },
                      child: Text(
                        'Medical Leave Request',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE1FF3C)),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(AnnualLeave());
                      },
                      child: Text(
                        'Annual Leave Request',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE1FF3C)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Leave Request History',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Card(
              elevation: 8,
              child: Container(
                width: screenWidth * 1,
                height: screenHeight * 0.540,
                color: Colors.white,
                child: Center(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 1'),
                                  subtitle: Text('item 0 for index 0'),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: 140,
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: ListTile(
                                  title: Text('item 0'),
                                  subtitle: Text('item 0 for index 0'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(HomePage());
              },
              icon: Icon(Icons.home),
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Leave());
              },
              icon: Icon(Icons.leave_bags_at_home),
              color: Colors.lightGreenAccent,
            ),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(RequestPage());
              },
              icon: Icon(Icons.request_page),
              color: Colors.black,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Calender());
              },
              icon: Icon(Icons.calendar_today),
              color: Colors.black,
            ),
            label: 'Calendar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        selectedIconTheme: IconThemeData(
          size: 25,
          color: Color(0xFFE1FF3C),
        ),
        onTap: _onItemTapped,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () {
      //           Get.to(HomePage());
      //         },
      //         icon: Icon(
      //           Icons.home,
      //           color: Colors.black,
      //         ),
      //       ),
      //       label: "Home",
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
      //     ),
      //   ],
      // ),
    );
  }
}
