import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/calender.dart';
import 'package:project_ui/pages/leave.dart';
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
  final PermissionController permissionController =
      Get.put(PermissionController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final LocationController locationController = Get.put(LocationController());

  final Set<Marker> _marker = {
    const Marker(
      markerId: MarkerId('Times City'),
      position: LatLng(16.81605105, 96.12887631),
      infoWindow: InfoWindow(
        title: 'Times City',
        snippet: 'Office Tower',
      ),
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _showDialogCheckin(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checking in'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Date : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                Text('Time :${DateTime.now().hour}:${DateTime.now().minute}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checking out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Date : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                Text('Time :${DateTime.now().hour}:${DateTime.now().minute}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
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

    DateTime now = DateTime.now();
    String formattedDateMonth = DateFormat('MMMM').format(now);
    String formattedDateDay = DateFormat('dd').format(now);
    String formattedDateYear = DateFormat('yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // title: Image.asset(
        //   'assets/images/novalink.png',
        //   width: 70,
        //   // color: Color(0xFFE1FF3C),
        //   color: Colors.black,
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.095),
              radius: 25,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Get.toNamed('/profile');
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // padding: EdgeInsets.symmetric()
              SizedBox(
                width: screenWidth, //1.sw // flutter_screenutil
                // height: screenHeight * 0.23,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     // Padding(
                      //     //   padding: EdgeInsets.only(left: 30),
                      //     //   child: Text(
                      //     //     "RIGHT NOW, IT'S",
                      //     //     style: TextStyle(
                      //     //       fontSize:
                      //     //           screenWidth * 0.089, // Responsive font size
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                      // Date
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Text(
                              formattedDateMonth + ', ',
                              style: TextStyle(fontSize: 35),
                            ),
                            Text(
                              formattedDateDay + ', ',
                              style: TextStyle(fontSize: 35),
                            ),
                            Text(
                              formattedDateYear,
                              style: TextStyle(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.21,
                                              child: Text(
                                                DateFormat('h').format(
                                                        snapshot.data!) +
                                                    'h',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.12,
                                                  // Responsive font size
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                  fontSize: screenWidth *
                                                      0.1), // Responsive font size
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.29,
                                              // Responsive width
                                              child: Text(
                                                '${snapshot.data!.minute}m',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.12,
                                                  // Responsive font size
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //   ':',
                                            //   style: TextStyle(
                                            //       fontSize: screenWidth *
                                            //           0.1), // Responsive font size
                                            // ),
                                            // SizedBox(
                                            //   width: screenWidth * 0.23,
                                            //   // Responsive width
                                            //   child: Text(
                                            //     '${snapshot.data!.second}s',
                                            //     style: TextStyle(
                                            //       fontSize: screenWidth * 0.12,
                                            //       // Responsive font size
                                            //       fontWeight: FontWeight.bold,
                                            //     ),
                                            //   ),
                                            // ),
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
                                    child: Center(child: Text('Loading....')),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.4,
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
                  circles: {
                    Circle(
                      circleId: CircleId("1"),
                      radius: 789,
                      strokeColor: Colors.lightBlue,
                      strokeWidth: 1,
                      fillColor: Colors.lightBlue.withOpacity(0.5),
                      center: LatLng(16.81605105, 96.12887631),
                    )
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.35, // Responsive width
                      height: screenHeight * 0.07, // Responsive height
                      child: ElevatedButton(
                        onPressed: DateTime.now().hour > 16
                            ? null
                            : () {
                                locationController
                                    .sendLocationToServer(context);
                              },
                        child: const Text(
                          'Check in  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: Color(0xFFE1FF3C),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.35, // Responsive width
                      height: screenHeight * 0.07, // Responsive height
                      child: ElevatedButton(
                        onPressed: DateTime.now().hour > 16
                            ? null
                            : () {
                                locationController
                                    .sendLocationToServer(context);
                              },
                        child: Text(
                          'Check out',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: Color(0xFFE1FF3C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => HomePage(),
                // ));
                Get.to(
                  HomePage(),
                );
              },
              child: Image.asset(
                'assets/icons/home.png',
                width: 30,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => Leave(),
                // ));
                Get.to(Leave(), transition: Transition.rightToLeftWithFade);
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
                Get.to(RequestPage(),
                    transition: Transition.rightToLeftWithFade);
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
                Get.to(Calender(), transition: Transition.rightToLeftWithFade);
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
      ),
    );
  }
}
