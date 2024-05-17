import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/annualLeave.dart';
import 'package:project_ui/pages/medicalLeave.dart';

import 'exitApp.dart';

void main() {
  runApp(MaterialApp(
    home: BetaLeave(),
  ));
}

class BetaLeave extends StatefulWidget {
  const BetaLeave({super.key});

  @override
  State<BetaLeave> createState() => _BetaLeaveState();
}

class _BetaLeaveState extends State<BetaLeave> {
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
      ),
    );
  }
}
