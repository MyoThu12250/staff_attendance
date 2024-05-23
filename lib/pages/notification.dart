import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/home.dart';

import 'detailPages/notiDetailPage.dart';

class NotiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(HomePage());
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: false,
          title: Text('Notification'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(NotiDetailPage());
                          },
                          child: ListTile(
                            trailing: Icon(Icons.warning),
                            // change icon accoriding to status
                            title: Text(
                              'Request pending',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'May, 12, 2024',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Your Request Pending blah blah',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
