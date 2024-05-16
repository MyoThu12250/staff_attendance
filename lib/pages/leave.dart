import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/medicalLeave.dart';
import 'package:project_ui/pages/sendingrequest.dart';
import 'package:project_ui/pages/splashScreen.dart';

import '../Controller/leaveController.dart';

class Leave extends StatefulWidget {
  Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  int _selectedIndex = 1;

  LeaveController lontroller = Get.put(LeaveController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    // lontroller.Leave();
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> filteredData = Get.arguments as List<dynamic>;

    // print(filteredData);
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
        child: SingleChildScrollView(
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
                            elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
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
                            elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
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
                      // itemCount: filteredData.length,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        // var item = filteredData[index];
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
                                    title: Text("item['reasons']"),
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
      ),

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
