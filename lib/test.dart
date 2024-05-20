import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: MapSample(),
  ));
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late Stream<DateTime> _timeStream;
  late DateTime _currentTime;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTime = DateTime.now();
    _timeStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    return MediaQuery(
      data: MediaQuery.of(context),
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
              // Initial size of the sheet (fraction of parent height)
              minChildSize: 0.15,
              // Minimum size of the sheet (fraction of parent height)
              maxChildSize: 0.6,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.red,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      String dateType =
                          DateTime.now().hour < 12 ? 'Morning' : 'Afternoon';
                      return Column(
                        children: [
                          Center(child: Icon(Icons.keyboard_arrow_up)),
                          Text(
                            'Good ${dateType}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          StreamBuilder<DateTime>(
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
                                              DateFormat('h')
                                                      .format(snapshot.data!) +
                                                  'h',
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.12,
                                                // Responsive font size
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Epilogue',
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
                                                fontFamily: 'Epilogue',
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
                          )
                        ],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
