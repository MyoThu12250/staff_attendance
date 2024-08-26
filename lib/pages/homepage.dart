import 'dart:async';
import 'dart:convert';

import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:CheckMate/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import '../Controller/circleController.dart';
import '../Controller/locationController.dart';
import '../Controller/loginController.dart';
import '../Controller/permissionController.dart';
import '../Controller/timeController.dart';
import 'leave.dart';

class HomePage extends StatefulWidget {
  late final Map<String, dynamic> leaveDetail;

  HomePage({required this.leaveDetail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var check = DateTime.now().hour.obs;
  late Stream<DateTime> _timeStream;
  final Completer<GoogleMapController> _controller = Completer();
  final PermissionController permissionController =
      Get.put(PermissionController());
  final LoginController controller = Get.put(LoginController());
  final RangeController rangeController = Get.put(RangeController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final LocationController locationController = Get.put(LocationController());

  late StreamSubscription<InternetConnectionStatus> _subscription;
  List<LatLng> polygonPoint = [
    LatLng(16.740585, 95.649322),
    LatLng(16.740744, 95.648861),
    LatLng(16.741541, 95.649061),
    LatLng(16.741458, 95.649376),
    LatLng(16.742169, 95.649621),
    LatLng(16.742106, 95.649847),
    // LatLng(16.740585, 95.649322),
  ];

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          // Internet is connected
          break;
        case InternetConnectionStatus.disconnected:
          // Internet is disconnected
          _showNoInternetDialog();
          break;
      }
    });

    _timeStream = _getTimeStream();
    controller.loadProfileData();
    rangeController.fetchLocationData();
    permissionController.handleLocationPermission(context);
  }

  void _showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("No Internet Connection"),
        content: Text(
            "This app requires an internet connection. Please check your settings."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              SystemNavigator.pop(); // Exit the app
            },
          ),
        ],
      ),
      barrierDismissible: false, // Make dialog non-dismissible
    );
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  //
  // final Set<Marker> _marker = {
  //   const Marker(
  //     markerId: MarkerId('Times City'),
  //     position: LatLng(14.81605205, 96.12887631),
  //     infoWindow: InfoWindow(
  //       title: 'Times City',
  //       snippet: 'Office Tower',
  //     ),
  //   )
  // };

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            elevation: 20,
            shadowColor: Colors.red,
            title: Text(
              'Confirm Exit',
              style: TextStyle(
                fontFamily: 'Epilogue',
              ),
            ),
            content: Text(
              'Do you really want to exit the app?',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Epilogue',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool _isWithinTimeRange() {
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 8, 30); // 8:30 AM
    final endTime = DateTime(now.year, now.month, now.day, 16, 0); // 4:00 PM

    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  Stream<DateTime> _getTimeStream() async* {
    while (true) {
      try {
        final response = await http
            .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Yangon'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final dateTimeString = data['datetime'];
          final dateTime = DateTime.parse(dateTimeString)
              .toUtc()
              .add(Duration(hours: 6, minutes: 30)); // Adjust to UTC +6:30
          yield dateTime;
        } else {
          throw Exception('Failed to load time');
        }
      } catch (e) {
        yield DateTime.now().toUtc().add(Duration(
            hours: 6, minutes: 30)); // Default to UTC +6:30 if there's an error
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQuery = MediaQuery.of(context);
    // Size size = mediaQuery.size;
    // double screenWidth = size.width;
    // double screenHeight = size.height;

    DateTime now = DateTime.now();
    String formattedDateMonth = DateFormat('MMMM').format(now);
    String formattedDateDay = DateFormat('dd').format(now);
    String formattedDateYear = DateFormat('yyyy').format(now);

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 90,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'assets/icons/appIcon.png',
            ),
          ),
          title: Text('Staff Attendance'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.095),
                radius: 20,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Get.to(ProfilePage());
                      // Get.off(ProfilePage());
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Obx(
              () => GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                mapType: MapType.satellite,
                markers: {
                  Marker(
                    markerId: MarkerId('ကွန်ပျူတာတက္ကသိုလ်(မအူပင်)'),
                    // position: LatLng(
                    //     rangeController.lat.value, rangeController.lon.value),
                    position: LatLng(16.741362193064305, 95.64942387940448),
                    infoWindow: InfoWindow(
                      title: 'ကွန်ပျူတာတက္ကသိုလ်(မအူပင်)',
                      snippet: 'Main Building',
                    ),
                  ),
                },
                circles: {
                  Circle(
                    circleId: CircleId("1"),
                    radius: rangeController.range.value,
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 1,
                    fillColor: Colors.lightBlue.withOpacity(0.5),
                    center: LatLng(
                        rangeController.lat.value, rangeController.lon.value),
                  ),
                },
                polygons: {
                  Polygon(
                      polygonId: PolygonId("1"),
                      points: polygonPoint,
                      fillColor: Colors.lightBlue.withOpacity(0.3),
                      strokeWidth: 1,
                      strokeColor: Colors.lightBlue),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(16.74136203283806, 95.64941205411448),
                    zoom: 17),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.17,
              // Initial size of the sheet (fraction of parent height)
              minChildSize: 0.15,
              // Minimum size of the sheet (fraction of parent height)
              maxChildSize: 0.55,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.amber[200],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      String name = controller.userInfo['username'].toString();
                      String displayName =
                          name.length > 5 ? name.substring(0, 5) + '...' : name;
                      String firstName = displayName.split(' ')[0];
                      // Assuming the first name is the first word in displayName
                      String nameToDisplay =
                          displayName.length > 5 ? firstName : displayName;
                      String dateType =
                          DateTime.now().hour < 12 ? 'Morning' : 'Afternoon';
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(child: Icon(Icons.keyboard_arrow_up)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Good ${dateType + ' ' + nameToDisplay},',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Epilogue',
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          StreamBuilder<DateTime>(
                            stream: _timeStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final dateTime = snapshot.data!;
                                int hour = dateTime.hour;

                                hour = hour % 12;
                                hour = hour == 0
                                    ? 12
                                    : hour; // Convert '0' hour to '12' for 12 AM and 12 PM
                                final hourString =
                                    hour.toString().padLeft(2, '0');

                                final minute =
                                    dateTime.minute.toString().padLeft(2, '0');
                                final second =
                                    dateTime.second.toString().padLeft(2, '0');
                                // add global time
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0, // padding left
                                        ),
                                        child: Container(
                                          child: Text(
                                            hourString + 'h',
                                            style: TextStyle(
                                              fontSize: 50,
                                              // Responsive font size
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Epilogue',
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          ':',
                                          style: TextStyle(fontSize: 40),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          minute + 'm',
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Epilogue',
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          ':',
                                          style: TextStyle(fontSize: 40),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          second + 's',
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Epilogue',
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10),
                                        child: Text(
                                          snapshot.data!.hour < 12
                                              ? 'AM'
                                              : 'PM',
                                          style: TextStyle(
                                            fontSize: 40,
                                            // Responsive font size
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Epilogue',
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error : ${snapshot.error}');
                              } else {
                                return SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Center(
                                    child: Text(
                                      'Loading....',
                                      style: TextStyle(
                                        fontFamily: 'Epilogue',
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 90.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 400,
                                child: Row(
                                  children: [
                                    Text(
                                      formattedDateMonth + ', ',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Epilogue'),
                                    ),
                                    Text(
                                      formattedDateDay + ', ',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Epilogue'),
                                    ),
                                    Text(
                                      formattedDateYear,
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Epilogue'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => locationController.isLoading.value == true
                                ? Center(
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                        strokeWidth: 6,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 40.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          height: 60,
                                          child: ElevatedButton(
                                            onPressed: locationController
                                                    .isLoading.value
                                                ? null
                                                : () {
                                                    locationController
                                                        .sendLocationToServerin(
                                                            context);
                                                  },
                                            child: const Text(
                                              'Check in',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Epilogue',
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 8,
                                              backgroundColor:
                                                  Color(0xFFE1FF3C),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 60,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              locationController
                                                  .sendLocationToServerout(
                                                      context);
                                            },
                                            child: const Text(
                                              'Check out',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Epilogue',
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 8,
                                              backgroundColor: Colors.pink,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(
                      HomePage(
                        leaveDetail: {},
                      ),
                      transition: Transition.fadeIn);
                },
                icon: Image.asset(
                  'assets/icons/home.png',
                  color: Colors.green,
                  width: 35,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(
                      Leave(
                        leaveDetail: widget.leaveDetail,
                      ),
                      transition: Transition.fadeIn);
                },
                icon: Image.asset(
                  'assets/icons/leave.png',
                  color: Colors.black,
                  width: 35,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(
                      RequestPage(
                        attendanceDetail: {},
                      ),
                      transition: Transition.fadeIn);
                },
                icon: Image.asset(
                  'assets/icons/attendance_history.png',
                  color: Colors.black,
                  width: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
