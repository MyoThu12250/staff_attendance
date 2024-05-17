import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/medicalLeave.dart';
import 'package:project_ui/pages/sendingrequest.dart';
import 'package:project_ui/pages/splashScreen.dart';

//
// import '../Controller/leaveController.dart';
//
// class Leave extends StatefulWidget {
//   Leave({super.key});
//
//   @override
//   State<Leave> createState() => _LeaveState();
// }
//
// class _LeaveState extends State<Leave> {
//   int _selectedIndex = 1;
//
//   LeaveController lontroller = Get.put(LeaveController());
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void initState() {
//     super.initState();
//     // lontroller.Leave();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // List<dynamic> filteredData = Get.arguments as List<dynamic>;
//
//     // print(filteredData);
//     MediaQueryData mediaQuery = MediaQuery.of(context);
//     Size size = mediaQuery.size;
//     double screenWidth = size.width;
//     double screenHeight = size.height;
//     return WillPopScope(
//       onWillPop: () async {
//         Get.off(HomePage());
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//             // title: Center(child: Text('Leave Page')),
//             ),
//         body: MediaQuery(
//           data: MediaQuery.of(context),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: screenWidth * 1,
//                   height: screenHeight * 0.2,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: 130,
//                         height: 60,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(MedicalLeave());
//                           },
//                           child: Text(
//                             'Medical Leave',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                               elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 130,
//                         height: 60,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(AnnualLeave());
//                           },
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Text(
//                               'Annual Leave',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black),
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                               elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Center(
//                     child: Text(
//                       'Leave Request History',
//                       style: TextStyle(fontSize: 25),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   elevation: 8,
//                   child: Container(
//                     width: screenWidth * 1,
//                     height: screenHeight * 0.540,
//                     color: Colors.white,
//                     child: Center(
//                       child: ListView.builder(
//                         // itemCount: filteredData.length,
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           // var item = filteredData[index];
//                           return Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text("item['reasons']"),
//                                       subtitle: Text('item 0 for index 0'),
//                                       isThreeLine: true,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   width: screenWidth,
//                                   height: 140,
//                                   child: Card(
//                                     color: Colors.white,
//                                     elevation: 8,
//                                     child: ListTile(
//                                       title: Text('item 0'),
//                                       subtitle: Text('item 0 for index 0'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: InkWell(
//                 onTap: () {
//                   Get.off(
//                     HomePage(),
//                     transition: Transition.fadeIn,
//                   );
//                 },
//                 child: Image.asset(
//                   'assets/icons/home.png',
//                   width: 30,
//                   color: Colors.black,
//                 ),
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(
//                 onTap: () {
//                   Get.off(Leave(), transition: Transition.fadeIn);
//                 },
//                 child: Image.asset(
//                   'assets/icons/leave.png',
//                   width: 30,
//                   color: Colors.black,
//                 ),
//               ),
//               label: 'Leave',
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(
//                 onTap: () {
//                   Get.off(RequestPage(), transition: Transition.fadeIn);
//                 },
//                 child: Image.asset(
//                   'assets/icons/attendance_history.png',
//                   width: 30,
//                 ),
//               ),
//               label: 'Attendance',
//             ),
//             BottomNavigationBarItem(
//               icon: InkWell(
//                 onTap: () {
//                   Get.off(Calender(), transition: Transition.fadeIn);
//                 },
//                 child: Icon(
//                   Icons.calendar_month,
//                   color: Colors.black,
//                   size: 30,
//                 ),
//               ),
//               label: 'Calendar',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.green,
//           selectedIconTheme: IconThemeData(
//             size: 35,
//             color: Color(0xFFE1FF3C),
//           ),
//           onTap: _onItemTapped,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/medicalLeave.dart';

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

  var dropdownvalue;
  var _items = [
    'by pervious month',
    'by current month',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Leave History'),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.lightGreenAccent,
                      height: 70,
                      child: TabBar(
                        tabs: [
                          Text('Pending'),
                          Text('Accepted'),
                          Text('Rejected'),
                          Text('All'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Text('Pending1'), // PendingPage()
                    ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                          ],
                        );
                      },
                    ),
                    // Text('Pending2'), // AcceptedPage()
                    ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                          ],
                        );
                      },
                    ),
                    // Text('Pending3'), // RejectedPage()
                    ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                          ],
                        );
                      },
                    ),
                    // Text('Pending4'), // AllPage()
                    ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                            ListTile(
                              title: Text('ahgh'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            child: Icon(Icons.add),
            activeIcon: Icons.close,
            children: [
              SpeedDialChild(
                  elevation: 0,
                  child: Icon(Icons.medication),
                  labelWidget: Text('Medical leave'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MedicalLeave(),
                      ),
                    );
                    // Get.to(MedicalLeave());
                  }),
              SpeedDialChild(
                elevation: 0,
                child: Icon(Icons.access_time),
                labelWidget: Text('Annual leave'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AnnualLeave(),
                    ),
                  );
                  // Get.to(AnnualLeave());
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Get.off(
                      HomePage(),
                      transition: Transition.fadeIn,
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
                    Get.off(Leave(), transition: Transition.fadeIn);
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
                    Get.off(RequestPage(), transition: Transition.fadeIn);
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
                    Get.off(Calender(), transition: Transition.fadeIn);
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
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}
