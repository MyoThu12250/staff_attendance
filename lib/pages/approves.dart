import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({super.key});

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Approves'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Leave'),
                Text('Status'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                                height: 100,
                                width: double.maxFinite,
                                child: ListTile(title: Text('ListView '))),
                            SizedBox(
                              height: 100,
                              width: 200,
                              child: ListTile(
                                title: Text('Status'),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
