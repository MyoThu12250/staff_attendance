import 'package:Global_TA/Controller/testController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestingForm extends StatefulWidget {
  bool isedit;
  int? index;

  TestingForm({
    Key? key,
    required this.isedit,
    this.index,
  }) : super(key: key);

  @override
  State<TestingForm> createState() => _TestingFormState();
}

class _TestingFormState extends State<TestingForm> {
  TestController c = Get.find();
  TextEditingController typecontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController tocontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isedit == true) {
      typecontroller.text = c.leaveList[widget.index!].leaveType.toString();
      reasoncontroller.text = c.leaveList[widget.index!].reason.toString();
      fromcontroller.text = c.leaveList[widget.index!].from;
      tocontroller.text = c.leaveList[widget.index!].to;
      datecontroller.text = c.leaveList[widget.index!].date.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: typecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'type'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: datecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'date',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: reasoncontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'reason'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: fromcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'from'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: tocontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'to'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: tocontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'status'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  controller: tocontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'userId'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TestModel model = TestModel(
                //     leaveType: typecontroller.text.toString(),
                //     date: datecontroller.text.toString(),
                //     reason: reasoncontroller.text.toString(),
                //     from: fromcontroller.text.toString(),
                //     to: tocontroller.text.toString(),
                //     status: c.leaveList[widget.index!].status.toString(),
                //     userId: c.leaveList[widget.index!].UserId.toString(),
                //     id: c.leaveList[widget.index!].id.toString());

                // widget.isedit
                //     ? c.editData(
                //         model, c.leaveList[widget.index!].id.toString())
                //     : c.addData();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
