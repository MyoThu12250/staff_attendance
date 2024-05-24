// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_ui/pages/annualLeave.dart';
// import 'package:project_ui/pages/calender.dart';
// import 'package:project_ui/pages/home.dart';
// import 'package:project_ui/pages/medicalLeave.dart';
// import 'package:project_ui/pages/sendingrequest.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import '../Controller/leaveController.dart';
// import 'detailPages/leaveDetailPage.dart';
//
// class Leave extends StatefulWidget {
//   const Leave({super.key});
//
//   @override
//   State<Leave> createState() => _LeaveState();
// }
//
// class _LeaveState extends State<Leave> {
//   LeaveController controller = Get.put(LeaveController());
//
//   late List<dynamic> filteredData;
//   late List<dynamic> Rlist;
//
//   @override
//   void initState() {
//     super.initState();
//     controller.Leave();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic>? arguments =
//         Get.arguments as Map<String, dynamic>?;
//
//     final List<dynamic> filteredData = arguments?['filteredData'] ?? [];
//     final List<dynamic> Rlist = arguments?['Rlist'] ?? [];
//     final List<dynamic> Alist = arguments?['Alist'] ?? [];
//     final List<dynamic> Plist = arguments?['Plist'] ?? [];
//     return DefaultTabController(
//       length: 4,
//       child: WillPopScope(
//         onWillPop: () async {
//           Get.off(HomePage());
//           return false;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text('Leave History'),
//           ),
//           body: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       color: Colors.lightGreenAccent,
//                       height: 70,
//                       child: TabBar(
//                         tabs: [
//                           Text('Pending'),
//                           Text('Accepted'),
//                           Text('Rejected'),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('All'),
//                               Icon(Icons.arrow_drop_down)
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     if (Plist.isEmpty)
//                       Center(
//                         child: Text(
//                           'Empty Leave History',
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.green,
//                           ),
//                         ),
//                       )
//                     else
//                       ListView.separated(
//                         separatorBuilder: (context, index) {
//                           return Divider(
//                             color: Colors.black,
//                             thickness: 0.5,
//                           );
//                         },
//                         // itemCount: 2,
//                         itemCount: Plist.length,
//                         itemBuilder: (context, index) {
//                           var item = Plist[index];
//                           return Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Get.off(LeaveDetailPage());
//                                   },
//                                   child: ListTile(
//                                     trailing: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             //Perform edit function
//                                           },
//                                           icon: Icon(
//                                             Icons.edit,
//                                             color: Colors.lightGreenAccent,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             //perform delete function
//                                           },
//                                           icon: Icon(
//                                             Icons.delete,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     title: Text(
//                                       'Leave Type    :   ${item['leaveType']}',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     subtitle: Text(
//                                       'Date : ',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                     // Text('Pending2'), // AcceptedPage()
//
//                     Alist.isEmpty
//                         ? Center(
//                             child: Text('Empty Leave History',
//                                 style: TextStyle(
//                                     fontSize: 25, color: Colors.green)))
//                         : ListView.separated(
//                             separatorBuilder: (context, index) {
//                               return Divider(
//                                 color: Colors.black,
//                                 thickness: 0.5,
//                               );
//                             },
//                             itemCount: Alist.length,
//                             itemBuilder: (context, index) {
//                               var item = Alist[index];
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.off(LeaveDetailPage());
//                                     },
//                                     child: ListTile(
//                                       isThreeLine: true,
//                                       title: Text(
//                                         'Leave Type    :   ${item['leaveType']}',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         'Date  : ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                     // Text('Pending3'), // RejectedPage()
//                     Rlist.isEmpty
//                         ? Center(
//                             child: Text('Empty Leave History',
//                                 style: TextStyle(
//                                     fontSize: 25, color: Colors.green)))
//                         : ListView.separated(
//                             separatorBuilder: (context, index) {
//                               return Divider(
//                                 color: Colors.black,
//                                 thickness: 0.5,
//                               );
//                             },
//                             itemCount: Rlist.length,
//                             itemBuilder: (context, index) {
//                               var item = Rlist[index];
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.off(LeaveDetailPage());
//                                     },
//                                     child: ListTile(
//                                       title: Text(
//                                         'Leave Type    :   ${item['leaveType']}',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         'Date : ',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                     // Text('Pending4'), // AllPage()
//                     filteredData.isEmpty
//                         ? Center(
//                             child: Text('Empty Leave History',
//                                 style: TextStyle(
//                                     fontSize: 25, color: Colors.green)))
//                         : ListView.builder(
//                             itemCount: filteredData.length,
//                             itemBuilder: (context, index) {
//                               var item = filteredData[index];
//                               return Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.off(LeaveDetailPage());
//                                     },
//                                     child: ListTile(
//                                       title: Text(
//                                         'Leave Type    :   ${item['leaveType']}',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       subtitle: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Reason              :    ${item['reasons']}',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           Text(
//                                             'From                  :    ${item['from']}',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           Text(
//                                             'To                      :   ${item['to']}',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           floatingActionButton: SpeedDial(
//             child: Icon(Icons.add),
//             activeIcon: Icons.close,
//             children: [
//               SpeedDialChild(
//                   elevation: 0,
//                   child: Icon(
//                     Icons.medication,
//                     color: Colors.pink,
//                   ),
//                   labelWidget: Text('Leave Details'),
//                   onTap: () {
//                     Get.off(LeaveDetailPage(), transition: Transition.fadeIn);
//                   }),
//               SpeedDialChild(
//                   elevation: 0,
//                   child: Icon(
//                     Icons.medication,
//                     color: Colors.pink,
//                   ),
//                   labelWidget: Text('Medical leave'),
//                   onTap: () {
//                     Get.off(MedicalLeave(), transition: Transition.fadeIn);
//                   }),
//               SpeedDialChild(
//                 elevation: 0,
//                 child: Icon(
//                   Icons.access_time,
//                   color: Colors.purpleAccent,
//                 ),
//                 labelWidget: Text('Annual leave'),

//                 onTap: () {
//                   Get.off(AnnualLeave());
//                 },
//               ),
//             ],
//           ),
//           bottomNavigationBar: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   iconSize: 35,
//                   onPressed: () {
//                     Get.off(HomePage(), transition: Transition.fadeIn);
//                   },
//                   icon: Image.asset(
//                     'assets/icons/home.png',
//                     color: Colors.black,
//                     width: 35,
//                   ),
//                 ),
//                 IconButton(
//                   iconSize: 35,
//                   onPressed: () {
//                     Get.off(Leave(), transition: Transition.fadeIn);
//                   },
//                   icon: Image.asset(
//                     'assets/icons/leave.png',
//                     color: Colors.green,
//                     width: 35,
//                   ),
//                 ),
//                 IconButton(
//                   iconSize: 35,
//                   onPressed: () {
//                     Get.off(RequestPage(), transition: Transition.fadeIn);
//                   },
//                   icon: Image.asset(
//                     'assets/icons/attendance_history.png',
//                     color: Colors.black,
//                     width: 35,
//                   ),
//                 ),
//                 IconButton(
//                   iconSize: 35,
//                   onPressed: () {
//                     Get.off(Calender(), transition: Transition.fadeIn);
//                   },
//                   icon: Icon(
//                     Icons.calendar_month,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:Global_TA/pages/sendingrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Controller/leaveController.dart';
import 'annualLeave.dart';
import 'calender.dart';
import 'detailPages/leaveDetailPage.dart';
import 'home.dart';
import 'medicalLeave.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  final String status = 'pending';
  LeaveController controller = Get.put(LeaveController());

  late List<dynamic> filteredData;
  late List<dynamic> Rlist;
  late List<dynamic> Alist;
  late List<dynamic> Plist;

  bool _isLoading = false;
  final ScrollController _scrollControllerPending = ScrollController();
  final ScrollController _scrollControllerAccepted = ScrollController();
  final ScrollController _scrollControllerRejected = ScrollController();
  final ScrollController _scrollControllerAll = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.Leave();
    _loadMoreData('pending');
    _loadMoreData('accepted');
    _loadMoreData('rejected');
    _loadMoreData('all');

    _scrollControllerPending.addListener(() {
      if (_scrollControllerPending.position.pixels ==
              _scrollControllerPending.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreData('pending');
      }
    });

    _scrollControllerAccepted.addListener(() {
      if (_scrollControllerAccepted.position.pixels ==
              _scrollControllerAccepted.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreData('accepted');
      }
    });

    _scrollControllerRejected.addListener(() {
      if (_scrollControllerRejected.position.pixels ==
              _scrollControllerRejected.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreData('rejected');
      }
    });

    _scrollControllerAll.addListener(() {
      if (_scrollControllerAll.position.pixels ==
              _scrollControllerAll.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreData('all');
      }
    });
  }

  IconData getIcon(String status) {
    switch (status) {
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
    switch (status) {
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

  Future<void> _loadMoreData(String listType) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    List<Map<String, String>> newData = List.generate(20, (index) {
      return {
        'leaveType': 'Type ${Plist.length + index}',
        'reasons': 'Reason ${Plist.length + index}',
        'from': '2024-01-01',
        'to': '2024-01-10',
      };
    });

    setState(() {
      switch (listType) {
        case 'pending':
          Plist.addAll(newData);
          break;
        case 'accepted':
          Alist.addAll(newData);
          break;
        case 'rejected':
          Rlist.addAll(newData);
          break;
        case 'all':
          filteredData.addAll(newData);
          break;
      }
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollControllerPending.dispose();
    _scrollControllerAccepted.dispose();
    _scrollControllerRejected.dispose();
    _scrollControllerAll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;

    filteredData = arguments?['filteredData'] ?? [];
    Rlist = arguments?['Rlist'] ?? [];
    Alist = arguments?['Alist'] ?? [];
    Plist = arguments?['Plist'] ?? [];

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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Plist.isEmpty
                        ? Center(
                            child: Text(
                              'Empty Leave History',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                              ),
                            ),
                          )
                        : ListView.separated(
                            controller: _scrollControllerPending,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              );
                            },
                            itemCount: Plist.length + 1,
                            itemBuilder: (context, index) {
                              if (index == Plist.length) {
                                return _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SizedBox.shrink();
                              }
                              var item = Plist[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.off(LeaveDetailPage());
                                      },
                                      child: ListTile(
                                        trailing: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                // Perform edit function
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.lightGreenAccent,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                // perform delete function
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
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    Alist.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.separated(
                            controller: _scrollControllerAccepted,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              );
                            },
                            itemCount: Alist.length + 1,
                            itemBuilder: (context, index) {
                              if (index == Alist.length) {
                                return _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SizedBox.shrink();
                              }
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
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    Rlist.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.separated(
                            controller: _scrollControllerRejected,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              );
                            },
                            itemCount: Rlist.length + 1,
                            itemBuilder: (context, index) {
                              if (index == Rlist.length) {
                                return _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SizedBox.shrink();
                              }
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
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    filteredData.isEmpty
                        ? Center(
                            child: Text('Empty Leave History',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green)))
                        : ListView.builder(
                            controller: _scrollControllerAll,
                            itemCount: filteredData.length + 1,
                            itemBuilder: (context, index) {
                              if (index == filteredData.length) {
                                return _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SizedBox.shrink();
                              }
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
                                      trailing: Icon(
                                        getIcon(status),
                                        color: getColor(status),
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
                },
              ),
              SpeedDialChild(
                elevation: 0,
                child: Icon(
                  Icons.medication,
                  color: Colors.pink,
                ),
                labelWidget: Text('Medical leave'),
                onTap: () {
                  Get.off(MedicalLeave(), transition: Transition.fadeIn);
                },
              ),
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
