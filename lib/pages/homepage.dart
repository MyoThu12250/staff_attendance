import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/approves.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/leave.dart';
import 'package:project_ui/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _currentTime;
  late Timer _timer;
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timeStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    // EasyLoading.show(status: 'loading...');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _showDialogCheckin(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // Dialog is dismissible with a tap on the barrier.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checking in'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Date : ${DateTime.now().day}' +
                    '/' +
                    '${DateTime.now().month}' +
                    '/' +
                    '${DateTime.now().year}'),
                Text('Time :' +
                    '${DateTime.now().hour}' +
                    ':' +
                    '${DateTime.now().minute}'),
                // Text('Location :'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogCheckout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // Dialog is dismissible with a tap on the barrier.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checking out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Date : ${DateTime.now().day}' +
                    '/' +
                    '${DateTime.now().month}' +
                    '/' +
                    '${DateTime.now().year}'),
                Text('Time :' +
                    '${DateTime.now().hour}' +
                    ':' +
                    '${DateTime.now().minute}'),
                // Text('Location :'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Text(
            'Hi, Miracle James',
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const Profile());
            },
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
          )
        ],
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "RIGHT NOW, IT'S",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Container(
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.5,
                      child: StreamBuilder<DateTime>(
                        stream: _timeStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Text(
                                  DateFormat('h').format(snapshot.data!),
                                  style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Text(
                                    ':',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.minute}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Text(
                                    ':',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.second}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    (DateTime.now().hour < 12) ? 'AM' : 'PM',
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error : ${snapshot.error}');
                          } else {
                            return const Text('Loading....');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: screenHeight * .4,
                width: screenWidth,
                color: Colors.amberAccent,
                child: Text('Map Container'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // EasyLoading.show(status: 'Checking in...');
                        // Future.delayed(Duration(seconds: 2), () {
                        //   EasyLoading.dismiss();
                        // });
                        setState(() {
                          _showDialogCheckin(context);
                        });
                        // getTime();   // get time and send to api
                        // getLoc();    // get location and send to api
                      },
                      child: const Text(
                        'Check in  ',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // EasyLoading.show(status: 'Checking out...');
                        // // Simulate a check-out process
                        // Future.delayed(Duration(seconds: 2), () {
                        //   EasyLoading.dismiss();
                        //
                        //   _showDialogCheckout(context);
                        //   // Do something after check-out is complete
                        //   // getTime();   // get time and send to api
                        //   // getLoc();    // get location and send to api
                        // });
                        setState(() {
                          _showDialogCheckout(context);
                        });
                      },
                      child: Text(
                        'Check out',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purpleAccent.withOpacity(0.5),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(HomePage());
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Leave());
              },
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
            ),
            label: "Leave",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(Calender());
              },
              icon: Icon(Icons.calendar_month),
              color: Colors.white,
            ),
            label: "Calender",
          ),
          // BottomNavigationBarItem(
          //   icon: IconButton(
          //     onPressed: () {
          //       Get.to(ApprovePage());
          //     },
          //     icon: Icon(Icons.history),
          //     color: Colors.white,
          //   ),
          //   label: "History",
          // ),
        ],
      ),
    );
  }
}
