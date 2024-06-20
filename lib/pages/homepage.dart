import 'dart:async';
import 'dart:convert';

import 'package:CheckMate/pages/attdanceHistory.dart';
import 'package:CheckMate/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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

  // var disablein = (DateTime.now().hour >= 7 && DateTime.now().hour <= 13).obs;
  // var disableout = (DateTime.now().hour >= 14 && DateTime.now().hour <= 17).obs;

  @override
  void initState() {
    super.initState();
    _timeStream = _getTimeStream();
    controller.loadProfileData();
    rangeController.fetchLocationData();
    permissionController.handleLocationPermission(context);
    //*** stable time ***//
    // _currentTime = DateTime.now();
    // _timeStream =
    //     Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
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

  Stream<DateTime> _getTimeStream() async* {
    while (true) {
      try {
        final response = await http
            .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Yangon'));
        if (response.statusCode == 200) {
          print(response.body);
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
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'assets/icons/appIcon.png',
            ),
          ),
          title: Text('Check Mate'),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: CircleAvatar(
            //     backgroundColor: Colors.black.withOpacity(0.095),
            //     radius: 20,
            //     child: Stack(
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             Get.to(NotiPage(
            //               title: 'hi',
            //               body: 'hi',
            //             ));
            //           },
            //           icon: const Icon(
            //             Icons.notifications,
            //             size: 25,
            //           ),
            //         ),
            //         Positioned(
            //           left: 22,
            //           // right: 0,
            //           bottom: 25,
            //           // top: 0,
            //           child: CircleAvatar(
            //             radius: 10,
            //             backgroundColor: Colors.transparent,
            //             child: Text(
            //               '2', // noti count
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.black,
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
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
                markers: {
                  Marker(
                    markerId: MarkerId('Times City'),
                    position: LatLng(
                        rangeController.lat.value, rangeController.lon.value),
                    infoWindow: InfoWindow(
                      title: 'Times City',
                      snippet: 'Office Tower',
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
                initialCameraPosition: CameraPosition(
                    target: LatLng(16.81669722489963, 96.128601508370990),
                    zoom: 13),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
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
                                // add global time
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 80.0,
                                            ),
                                            child: SizedBox(
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
                                    )
                                  ],
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
                                const EdgeInsets.symmetric(horizontal: 80.0),
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
              // IconButton(
              //   iconSize: 35,
              //   onPressed: () {
              //     Get.off(
              //         Calender(
              //           leaveDetail: {},
              //         ),
              //         transition: Transition.fadeIn);
              //   },
              //   icon: Icon(
              //     Icons.calendar_month,
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
