import 'package:Global_TA/Controller/testController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'testing.dart';

class TestingDetail extends StatefulWidget {
  bool onTap;
  int? index;

  TestingDetail({
    Key? key,
    required this.onTap,
    this.index,
  }) : super(key: key);

  @override
  State<TestingDetail> createState() => _TestingDetailState();
}

class _TestingDetailState extends State<TestingDetail> {
  TestController c = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.onTap == true) {
      type = c.leaveList[widget.index!].leaveType;
      from = c.leaveList[widget.index!].from.toString();
      to = c.leaveList[widget.index!].to.toString();
    }
  }

  var type;
  var from;
  var to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.off(Test());
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Tap View Data : ${type}'),
                  subtitle: Text('Tab view data : ${from}'),
                  trailing: Text(to),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
