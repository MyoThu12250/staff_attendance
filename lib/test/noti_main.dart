import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground!');
      // Handle foreground messages
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened a message in the background!');
      // Handle background messages
    });

    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("Firebase Messaging Token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FCM Demo'),
        ),
        body: Center(
          child: Text('Push Notifications with FCM'),
        ),
      ),
    );
  }
}
