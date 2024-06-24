import 'package:flutter/material.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

void main() =>
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              switch (OpenSettingsPlus.shared {
                OpenSettingsPlusAndroid settings => settings.wifi(),
                OpenSettingsPlusIOS settings => settings.wifi(),
                _ => throw Exception('Platform not supported'),
              }
            },
            child: Text('Wi-Fi Settings'),
          ),
        ),
      ),
    )
    );

// import 'dart:async';
//
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late StreamSubscription<InternetConnectionStatus> _subscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
//       switch (status) {
//         case InternetConnectionStatus.connected:
//           // Internet is connected
//           break;
//         case InternetConnectionStatus.disconnected:
//           // Internet is disconnected
//           _showNoInternetDialog();
//           break;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   void _showNoInternetDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Make dialog non-dismissible
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("No Internet Connection"),
//           content: Text(
//               "This app requires an internet connection. Please check your settings."),
//           actions: <Widget>[
//             TextButton(
//               child: Text("OK"),
//               onPressed: () {
//                 AppSettings.openAppSettings(type: AppSettingsType.wifi);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _openSettings() async {
//     const url = 'app-settings:';
//     if (!await launchUrl(Uri.parse(url))) {
//       throw 'Could not launch settings';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Internet Connectivity Check"),
//       ),
//       body: Center(
//         child: Text("Home Screen"),
//       ),
//     );
//   }
// }
