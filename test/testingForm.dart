import 'package:Global_TA/Controller/testController.dart';
import 'package:Global_TA/Model/testModel.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isedit == true) {
      _type.text = c.leaveList[widget.index!].leaveType;
    }
  }

  TestController c = Get.find();
  TextEditingController _type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 200,
              height: 40,
              child: TextField(
                controller: _type,
                decoration: InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              TestModel model = TestModel(
                leaveType: _type.text,
                date: c.leaveList[widget.index!].date,
                reason: c.leaveList[widget.index!].reason,
                from: c.leaveList[widget.index!].from,
                to: c.leaveList[widget.index!].to,
                status: c.leaveList[widget.index!].status,
                userId: c.leaveList[widget.index!].UserId,
                id: c.leaveList[widget.index!].id,
              );
              widget.isedit
                  ? c.updateData(model, c.leaveList[widget.index!].id)
                  : c.addData(model);
            },
            child: Text(
              widget.isedit ? 'Update' : 'Add',
            ),
          ),
        ],
      ),
    );
  }
}
