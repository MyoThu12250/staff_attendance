// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:project_ui/pages/annualLeave.dart';
// import 'package:project_ui/pages/calender.dart';
// import 'package:project_ui/pages/home.dart';
// import 'package:project_ui/pages/medicalLeave.dart';
// import 'package:project_ui/pages/sendingrequest.dart';
// import 'package:project_ui/pages/splashScreen.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:get/get.dart';
// import 'package:project_ui/pages/annualLeave.dart';
// import 'package:project_ui/pages/medicalLeave.dart';
//
// import '../Controller/leaveController.dart';
//
// class Leave extends StatefulWidget {
//   const Leave({super.key});
//
//   @override
//   State<Leave> createState() => _LeaveState();
// }
//
// class _LeaveState extends State<Leave> {
//   int _selectedIndex = 1;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   LeaveController controller = Get.put(LeaveController());
//
//   var dropdownvalue;
//   var _items = [
//     'by pervious month',
//     'by current month',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.off(HomePage());
//         return false;
//       },
//       child: DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text('Leave History'),
//             ),
//             body: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         // color: Colors.lightGreenAccent,
//                         height: 70,
//                         child: TabBar(
//                           tabs: [
//                             Text('Pending'),
//                             Text('Accepted'),
//                             Text('Rejected'),
//                             Text('All'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       // Text('Pending1'), // PendingPage()
//                       ListView.builder(
//                         //pending count
//                         itemCount: 3,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 leading: CircleAvatar(
//                                   child: Text('A'),
//                                 ),
//                                 title: Text('Name'),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Reason'),
//                                     Text('Duration'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       // Text('Pending2'), // AcceptedPage()
//                       ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 title: Text('ahgh'),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       // Text('Pending3'), // RejectedPage()
//                       ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 title: Text('ahgh'),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       // Text('Pending4'), // AllPage()
//                       ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 title: Text('ahgh'),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             floatingActionButton: SpeedDial(
//               child: Icon(Icons.add),
//               activeIcon: Icons.close,
//               children: [
//                 SpeedDialChild(
//                     elevation: 0,
//                     child: Icon(
//                       Icons.medication,
//                       color: Colors.green,
//                     ),
//                     labelWidget: Text('Medical leave'),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => MedicalLeave(),
//                         ),
//                       );
//                       // Get.to(MedicalLeave());
//                     }),
//                 SpeedDialChild(
//                   elevation: 0,
//                   child: Icon(
//                     Icons.access_time,
//                     color: Colors.pink,
//                   ),
//                   labelWidget: Text('Annual leave'),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => AnnualLeave(),
//                       ),
//                     );
//                     // Get.to(AnnualLeave());
//                   },
//                 ),
//               ],
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     onTap: () {
//                       Get.off(
//                         HomePage(),
//                         transition: Transition.fadeIn,
//                       );
//                     },
//                     child: Image.asset(
//                       'assets/icons/home.png',
//                       width: 30,
//                       color: Colors.black,
//                     ),
//                   ),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     onTap: () {
//                       Get.off(Leave(), transition: Transition.fadeIn);
//                     },
//                     child: Image.asset(
//                       'assets/icons/leave.png',
//                       width: 30,
//                       color: Colors.black,
//                     ),
//                   ),
//                   label: 'Leave',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     onTap: () {
//                       Get.off(RequestPage(), transition: Transition.fadeIn);
//                     },
//                     child: Image.asset(
//                       'assets/icons/attendance_history.png',
//                       width: 30,
//                     ),
//                   ),
//                   label: 'Attendance',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: InkWell(
//                     onTap: () {
//                       Get.off(Calender(), transition: Transition.fadeIn);
//                     },
//                     child: Icon(
//                       Icons.calendar_month,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                   ),
//                   label: 'Calendar',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedItemColor: Colors.green,
//               selectedIconTheme: IconThemeData(
//                 size: 35,
//                 color: Color(0xFFE1FF3C),
//               ),
//               onTap: _onItemTapped,
//               type: BottomNavigationBarType.fixed,
//             ),
//           )),
//     );
//   }
// }
//
// //
// // import '../Controller/leaveController.dart';
// //
// // class Leave extends StatefulWidget {
// //   Leave({super.key});
// //
// //   @override
// //   State<Leave> createState() => _LeaveState();
// // }
// //
// // class _LeaveState extends State<Leave> {
// //   int _selectedIndex = 1;
// //
// //   LeaveController lontroller = Get.put(LeaveController());
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// //
// //   void initState() {
// //     super.initState();
// //     // lontroller.Leave();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // List<dynamic> filteredData = Get.arguments as List<dynamic>;
// //
// //     // print(filteredData);
// //     MediaQueryData mediaQuery = MediaQuery.of(context);
// //     Size size = mediaQuery.size;
// //     double screenWidth = size.width;
// //     double screenHeight = size.height;
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Get.off(HomePage());
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //             // title: Center(child: Text('Leave Page')),
// //             ),
// //         body: MediaQuery(
// //           data: MediaQuery.of(context),
// //           child: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 SizedBox(
// //                   width: screenWidth * 1,
// //                   height: screenHeight * 0.2,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       SizedBox(
// //                         width: 130,
// //                         height: 60,
// //                         child: ElevatedButton(
// //                           onPressed: () {
// //                             Get.to(MedicalLeave());
// //                           },
// //                           child: Text(
// //                             'Medical Leave',
// //                             style: TextStyle(
// //                                 color: Colors.black,
// //                                 fontWeight: FontWeight.bold),
// //                           ),
// //                           style: ElevatedButton.styleFrom(
// //                               elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         width: 130,
// //                         height: 60,
// //                         child: ElevatedButton(
// //                           onPressed: () {
// //                             Get.to(AnnualLeave());
// //                           },
// //                           child: SingleChildScrollView(
// //                             scrollDirection: Axis.horizontal,
// //                             child: Text(
// //                               'Annual Leave',
// //                               style: TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Colors.black),
// //                             ),
// //                           ),
// //                           style: ElevatedButton.styleFrom(
// //                               elevation: 8, backgroundColor: Color(0xFFE1FF3C)),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(10.0),
// //                   child: Center(
// //                     child: Text(
// //                       'Leave Request History',
// //                       style: TextStyle(fontSize: 25),
// //                     ),
// //                   ),
// //                 ),
// //                 Card(
// //                   elevation: 8,
// //                   child: Container(
// //                     width: screenWidth * 1,
// //                     height: screenHeight * 0.540,
// //                     color: Colors.white,
// //                     child: Center(
// //                       child: ListView.builder(
// //                         // itemCount: filteredData.length,
// //                         itemCount: 1,
// //                         itemBuilder: (context, index) {
// //                           // var item = filteredData[index];
// //                           return Column(
// //                             children: [
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text("item['reasons']"),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                       isThreeLine: true,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: screenWidth,
// //                                   height: 140,
// //                                   child: Card(
// //                                     color: Colors.white,
// //                                     elevation: 8,
// //                                     child: ListTile(
// //                                       title: Text('item 0'),
// //                                       subtitle: Text('item 0 for index 0'),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //         bottomNavigationBar: BottomNavigationBar(
// //           items: <BottomNavigationBarItem>[
// //             BottomNavigationBarItem(
// //               icon: InkWell(
// //                 onTap: () {
// //                   Get.off(
// //                     HomePage(),
// //                     transition: Transition.fadeIn,
// //                   );
// //                 },
// //                 child: Image.asset(
// //                   'assets/icons/home.png',
// //                   width: 30,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               label: 'Home',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: InkWell(
// //                 onTap: () {
// //                   Get.off(Leave(), transition: Transition.fadeIn);
// //                 },
// //                 child: Image.asset(
// //                   'assets/icons/leave.png',
// //                   width: 30,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               label: 'Leave',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: InkWell(
// //                 onTap: () {
// //                   Get.off(RequestPage(), transition: Transition.fadeIn);
// //                 },
// //                 child: Image.asset(
// //                   'assets/icons/attendance_history.png',
// //                   width: 30,
// //                 ),
// //               ),
// //               label: 'Attendance',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: InkWell(
// //                 onTap: () {
// //                   Get.off(Calender(), transition: Transition.fadeIn);
// //                 },
// //                 child: Icon(
// //                   Icons.calendar_month,
// //                   color: Colors.black,
// //                   size: 30,
// //                 ),
// //               ),
// //               label: 'Calendar',
// //             ),
// //           ],
// //           currentIndex: _selectedIndex,
// //           selectedItemColor: Colors.green,
// //           selectedIconTheme: IconThemeData(
// //             size: 35,
// //             color: Color(0xFFE1FF3C),
// //           ),
// //           onTap: _onItemTapped,
// //           type: BottomNavigationBarType.fixed,
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/home.dart';
import 'package:project_ui/pages/medicalLeave.dart';
import 'package:project_ui/pages/sendingrequest.dart';
import 'package:project_ui/pages/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Controller/leaveController.dart';
import 'detailPages/leaveDetailPage.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  int _selectedIndex = 1;
  LeaveController controller = Get.put(LeaveController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<dynamic> filteredData;
  late List<dynamic> Rlist;

  @override
  void initState() {
    super.initState();
    controller.Leave();
    // Get.arguments != null ? Get.arguments as Map<String, dynamic> : [];
    // filteredData = Get.arguments != null ? Get.arguments as List<dynamic> : [];
  }

  var dropdownvalue;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;

    final List<dynamic> filteredData = arguments?['filteredData'] ?? [];
    final List<dynamic> Rlist = arguments?['Rlist'] ?? [];
    final List<dynamic> Alist = arguments?['Alist'] ?? [];
    final List<dynamic> Plist = arguments?['Plist'] ?? [];
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          Get.off(HomePage());
          return false;
        },
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('All'),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          // Text('All'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    if (Plist.isEmpty)
                      Center(
                          child: Text('Empty Leave History',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.green)))
                    else
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.black,
                            thickness: 0.5,
                          );
                        },
                        // itemCount: 2,
                        itemCount: Plist.length,
                        itemBuilder: (context, index) {
                          var item = Plist[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Get.off(LeaveDetailPage());
                                  },
                                  child: ListTile(
                                    trailing: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            //Perform edit function
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.lightGreenAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            //perform delete function
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      'Leave Type    :   ${item['leaveType']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Date : ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // subtitle: Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       'Reason              :    ${item['reasons']}',
                                    //       style: TextStyle(
                                    //         fontSize: 15,
                                    //         color: Colors.grey,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       'From                  :    ${item['from']}',
                                    //       style: TextStyle(
                                    //         fontSize: 13,
                                    //         color: Colors.grey,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       'To                      :     ${item['to']}',
                                    //       style: TextStyle(
                                    //         fontSize: 13,
                                    //         color: Colors.grey,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    // Text('Pending2'), // AcceptedPage()

                    Alist.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              );
                            },
                            itemCount: Alist.length,
                            itemBuilder: (context, index) {
                              var item = Alist[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(LeaveDetailPage());
                                    },
                                    child: ListTile(
                                      isThreeLine: true,
                                      title: Text(
                                        'Leave Type    :   ${item['leaveType']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Date  : ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      // subtitle: Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       'Reason              :    ${item['reasons']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       'From                  :    ${item['from']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       'To                      :   ${item['to']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    // Text('Pending3'), // RejectedPage()
                    Rlist.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              );
                            },
                            itemCount: Rlist.length,
                            itemBuilder: (context, index) {
                              var item = Rlist[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(LeaveDetailPage());
                                    },
                                    child: ListTile(
                                      title: Text(
                                        'Leave Type    :   ${item['leaveType']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Date : ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      // subtitle: Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       'Reason              :    ${item['reasons']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       'From                  :    ${item['from']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       'To                      :   ${item['to']}',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    // Text('Pending4'), // AllPage()
                    filteredData.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.builder(
                            itemCount: filteredData.length,
                            itemBuilder: (context, index) {
                              var item = filteredData[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(LeaveDetailPage());
                                    },
                                    child: ListTile(
                                      title: Text(
                                        'Leave Type    :   ${item['leaveType']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reason              :    ${item['reasons']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'From                  :    ${item['from']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'To                      :   ${item['to']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                  child: Icon(
                    Icons.medication,
                    color: Colors.pink,
                  ),
                  labelWidget: Text('Leave Details'),
                  onTap: () {
                    Get.off(LeaveDetailPage(), transition: Transition.fadeIn);
                  }),
              SpeedDialChild(
                  elevation: 0,
                  child: Icon(
                    Icons.medication,
                    color: Colors.pink,
                  ),
                  labelWidget: Text('Medical leave'),
                  onTap: () {
                    Get.off(MedicalLeave(), transition: Transition.fadeIn);
                  }),
              SpeedDialChild(
                elevation: 0,
                child: Icon(
                  Icons.access_time,
                  color: Colors.purpleAccent,
                ),
                labelWidget: Text('Annual leave'),
                onTap: () {
                  Get.off(AnnualLeave());
                },
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: InkWell(
          //         onTap: () {
          //           Get.off(
          //             HomePage(),
          //             transition: Transition.fadeIn,
          //           );
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
                    color: Colors.green,
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
                    color: Colors.black,
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
      ),
    );
  }
}
