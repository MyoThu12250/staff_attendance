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
                  backgroundColor: Colors.lightGreen, elevation: 8),
              onPressed: () {
                Get.to(RequestPageForm());
              },
              child: Text('Attendance Form'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('Attendance History'),
          SizedBox(
            height: 40,
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
              color: Colors.black,
            ),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                // Get.to();
              },
              icon: Icon(Icons.request_page),
              color: Colors.lightGreenAccent,
            ),
            label: 'Request',
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
    );
  }
}
