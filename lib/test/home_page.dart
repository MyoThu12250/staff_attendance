// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
//
// import 'noti_ddetail.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late FirebaseMessaging messaging;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     var initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         if (response.payload != null) {
//           print(response.payload);
//           Get.to(() => NotiPage(notificationData: response.payload!));
//         }
//       },
//     );
//
//     messaging = FirebaseMessaging.instance;
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               'your_channel_id',
//               'your_channel_name',
//               channelDescription: 'your_channel_description',
//               icon: android.smallIcon,
//             ),
//           ),
//           payload: message.data['route'],
//         );
//       }
//     });
//
//     messaging.getToken().then((token) {
//       print("Firebase Messaging Token: $token");
//       // Send this token to your server
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("FCM Demo"),
//       ),
//       body: Center(
//         child: Text("Flutter Firebase Messaging"),
//       ),
//     );
//   }
// }
