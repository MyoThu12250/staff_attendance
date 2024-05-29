import 'package:Global_TA/Controller/testController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'testingDetail.dart';
import 'testingForm.dart';

void main() {
  Get.put(TestController());
  runApp(
    GetMaterialApp(
      home: Test(),
      builder: EasyLoading.init(),
    ),
  );
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  TestController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('something'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              c.getData();
            },
            child: Text('get'),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: c.leaveList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.off(TestingDetail(
                        onTap: true,
                      ));
                    },
                    child: ListTile(
                      title: Text(c.leaveList[index].leaveType),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(
                                TestingForm(
                                  isedit: true,
                                  index: index,
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),

                          // done
                          IconButton(
                            onPressed: () async {
                              await c.deleteData(c.leaveList[index].id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            TestingForm(
              isedit: false,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
