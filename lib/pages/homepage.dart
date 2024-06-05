import 'dart:async';

import 'package:CheckMate/pages/sendingrequest.dart';
import 'package:CheckMate/pages/testProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../Controller/locationController.dart';
import '../Controller/loginController.dart';
import '../Controller/permissionController.dart';
import '../Controller/timeController.dart';
import 'calender.dart';
import 'leave.dart';
import 'notipage.dart';

class HomePage extends StatefulWidget {
  late final Map<String, dynamic> leaveDetail;

  HomePage({required this.leaveDetail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var check = DateTime.now().hour.obs;
  late DateTime _currentTime;
  late Timer _timer;
  late Stream<DateTime> _timeStream;
  final Completer<GoogleMapController> _controller = Completer();
  final PermissionController permissionController =
      Get.put(PermissionController());
  final LoginController controller = Get.put(LoginController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final LocationController locationController = Get.put(LocationController());
  var disablein = (DateTime.now().hour >= 7 && DateTime.now().hour <= 13).obs;
  var disableout = (DateTime.now().hour >= 14 && DateTime.now().hour <= 17).obs;

  final Set<Marker> _marker = {
    const Marker(
      markerId: MarkerId('Times City'),
      position: LatLng(14.81605205, 96.12887631),
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
    controller.loadProfileData();

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

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
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

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
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
              padding: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.095),
                radius: 20,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Get.off(ProfilePage());
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.095),
              radius: 20,
              child: Center(
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.off(NotiPage());
                      },
                      icon: const Icon(
                        Icons.notifications,
                        size: 25,
                      ),
                    ),
                    Positioned(
                      left: 25,
                      // right: 0,
                      bottom: 20,
                      // top: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.amber,
                        child: Text(
                          '2', // noti count
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
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
                  center: LatLng(14.81605105, 96.12887631),
                )
              },
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
                            'Good ${dateType + ' ' + name}',
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
                              if (snapshot.hasData) {
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
                                              width: screenWidth * 0.21,
                                              child: Text(
                                                DateFormat('h').format(
                                                        snapshot.data!) +
                                                    'h',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.12,
                                                  // Responsive font size
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Epilogue',
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.1),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.29,
                                            // Responsive width
                                            child: Text(
                                              '${snapshot.data!.minute}m',
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Epilogue',
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              snapshot.data!.hour < 12
                                                  ? 'AM'
                                                  : 'PM',
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.1,
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
                                const EdgeInsets.symmetric(horizontal: 90.0),
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  Text(
                                    formattedDateMonth + ', ',
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: 'Epilogue'),
                                  ),
                                  Text(
                                    formattedDateDay + ', ',
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: 'Epilogue'),
                                  ),
                                  Text(
                                    formattedDateYear,
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: 'Epilogue'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.35,
                                  // Responsive width
                                  height: screenHeight * 0.07,

                                  // Responsive height
                                  child: Obx(
                                    () => ElevatedButton(
                                      onPressed: () {
                                        locationController
                                            .sendLocationToServerin(context);
                                      },
                                      child: const Text(
                                        'Check in ',
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
                                            disablein.value == false
                                                ? Colors.black
                                                : Color(0xFFE1FF3C),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.35,
                                  // Responsive width
                                  height: screenHeight * 0.07,
                                  // Responsive height
                                  child: Obx(
                                    () => ElevatedButton(
                                      onPressed: dateTimeController
                                                  .isButtonDisabled.value ==
                                              true
                                          ? null
                                          : () {
                                              print('0');
                                              locationController
                                                  .sendLocationToServerout(
                                                      context);
                                            },
                                      child: Text(
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
                                        backgroundColor: Colors.pinkAccent,
                                        // backgroundColor: Color(0xFFE1FF3C),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Get.off(
                      Calender(
                        leaveDetail: {},
                      ),
                      transition: Transition.fadeIn);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
