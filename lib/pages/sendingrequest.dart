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
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                // child: _countLeft != 0
                //     ?
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
                // : Text(
                //     'You have nothing attempt',
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.red,
                //     ),
                //   ),
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
                  height: 470,
                  // color: Colors.lightGreen,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 8,
                            child: SizedBox(
                              height: 130,
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
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
      ),
    );
  }
}
