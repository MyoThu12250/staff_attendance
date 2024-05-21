import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/homepage.dart';
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
    // int _countLeft = 0; // attendance count
    int _selectedIndex = 2;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

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
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'In time : {controller.userInfo[in-time]}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Out time : {controller.userInfo[out-time]}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Date : {controller.userInfo[date]}'),
                              ],
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
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // label: 'Home',
              // icon: IconButton(
              //   onPressed: () {
              //     Get.off(HomePage(), transition: Transition.fadeIn);
              //   },
              //   icon: Image.asset(
              //     'assets/icons/home.png',
              //     color: Colors.black,
              //     width: 30,
              //   ),
              // ),
              icon: InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                  Get.off(HomePage(), transition: Transition.fadeIn);
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
              // label: 'Leave',
              // icon: IconButton(
              //   onPressed: () {},
              //   icon: Image.asset(
              //     'assets/icons/leave.png',
              //     width: 30,
              //     color: Colors.black,
              //   ),
              // )
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
              // label: 'Attendance',
              // icon: IconButton(
              //     onPressed: () {},
              //     icon: Image.asset(
              //       'assets/icons/attendance_history.png',
              //       width: 30,
              //       color: Colors.green,
              //     ))
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
              // label: 'Calendar',
              // icon: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.calendar_month,
              //     color: Colors.black,
              //   ),
              // ),
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
      ),
    );
  }
}
