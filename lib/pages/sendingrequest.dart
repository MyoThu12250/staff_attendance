import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    int _selectedIndex = 2;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE1FF3C), elevation: 8),
              onPressed: () {
                Get.to(RequestPageForm());
              },
              child: Text(
                'Attendance Form',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Attendance History',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              // color: Colors.lightGreen,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 8,
                        child: SizedBox(
                          height: 100,
                          child: ListTile(
                            title: Text('h1'),
                            subtitle: Text('h3'),
                            isThreeLine: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
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
    );
  }
}
