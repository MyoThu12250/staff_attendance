import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/leave.dart';
import 'package:project_ui/pages/profile.dart';
import 'package:project_ui/pages/sendingrequest.dart';

import '../Controller/locationController.dart';
import '../Controller/permissionController.dart';
import '../Controller/timeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _currentTime;
  late Timer _timer;
  late Stream<DateTime> _timeStream;
  final Completer<GoogleMapController> _controller = Completer();
  final PermissionController permissionController=Get.put(PermissionController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final LocationController locationController = Get.put(LocationController());

  final Set<Marker> _marker = {
    const Marker(
        markerId: MarkerId('Times City'),
        position: LatLng(16.81605105, 96.12887631),
        infoWindow: InfoWindow(
          title: 'Times City',
          snippet: 'Office Tower',
        )
    )
  };
  static const CameraPosition kGoogle = CameraPosition(
    target: LatLng(16.81605105, 96.12887631),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    permissionController.handleLocationPermission(context);
    _currentTime = DateTime.now();
    _timeStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition kGoogle = CameraPosition(
    target: LatLng(16.81605105, 96.12887631),
    zoom: 14.4746,
  );

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
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Hi, Miracle James',
        //   style: TextStyle(fontSize: 20),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.095),
              radius: 30,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Get.to(const Profile());
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * .2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "RIGHT NOW, IT'S",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: StreamBuilder<DateTime>(
                          stream: _timeStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          // color: Colors.red,
                                          width: 85,
                                          child: Text(
                                            DateFormat('h')
                                                    .format(snapshot.data!) +
                                                'h',
                                            style: TextStyle(
                                              // color: Colors.purpleAccent,
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(fontSize: 50),
                                        ),
                                        SizedBox(
                                          // color: Colors.greenAccent,
                                          width: 120,
                                          child: Text(
                                            '${snapshot.data!.minute}m',
                                            style: TextStyle(
                                              // color: Colors.red,
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: TextStyle(fontSize: 50),
                                        ),
                                        SizedBox(
                                          // color: Colors.green,
                                          width: 90,
                                          child: Text(
                                            '${snapshot.data!.second}s',
                                            style: TextStyle(
                                              // color: Colors.red,
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          (DateTime.now().hour < 12)
                                              ? 'AM'
                                              : 'PM',
                                          style: TextStyle(
                                            // color: Colors.lightGreen,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error : ${snapshot.error}');
                            } else {
                              return SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Center(child: Text('Loading....')));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight * .4,
              width: screenWidth,
              color: Colors.greenAccent.withOpacity(0.6),
              child: GoogleMap(

                initialCameraPosition: kGoogle,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },

                markers: _marker,

                circles:{
                  Circle(
                    circleId: CircleId("1"),
                    radius: 789,
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 1,
                    fillColor: Colors.lightBlue.withOpacity(0.5), center:LatLng(16.81605105, 96.12887631),

                  )},

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:DateTime.now().hour>16 ? null :  () {

                      locationController.sendLocationToServer(context);
                    },
                      child: const Text(
                        'Check in  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE1FF3C),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:DateTime.now().hour>16 ? null :  () {

    locationController.sendLocationToServer(context);
    },

                      child: Text(
                        'Check out',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE1FF3C),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(HomePage());
              },
              icon: Icon(Icons.home),
              color: Colors.lightGreenAccent,
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
                Get.to(RequestPage());
              },
              icon: Icon(Icons.request_page),
              color: Colors.black,
            ),
            label: 'Attendance',
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
