import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/approves.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/homepage.dart';
import 'package:project_ui/pages/medicalLeave.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text('Leaving Page'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.to(MedicalLeave());
                    },
                    child: Text('Medical Leave')),
                ElevatedButton(
                    onPressed: () {
                      Get.to(AnnualLeave());
                    },
                    child: Text('Annual Leave')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'Allowed Leave',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Medical leave'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Annual leave'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Allowed leave'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('5'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('2'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('8'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
