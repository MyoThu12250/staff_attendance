import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  final String title;
  final String body;

  NotiPage({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              body,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: NotificationHandler(navigatorKey: navigatorKey),
    );
  }
}

class NotificationHandler extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationHandler({required this.navigatorKey});

  @override
  _NotificationHandlerState createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  late FirebaseMessaging _firebaseMessaging;
  String _title = "Handling notifications...";
  String _body = "";

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      print("Firebase Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: ${message.messageId}");
      // Update UI when app is in foreground
      setState(() {
        _title = message.notification?.title ?? "No Title";
        _body = message.notification?.body ?? "No Body";
      });
      _showNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: ${message.messageId}");
      _navigateToNotiPage(message.notification?.title ?? "No Title",
          message.notification?.body ?? "No Body");
    });
  }

  Future<void> _showNotification(Map<String, dynamic> message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_title ?? 'No Title'),
          content: Text(_body ?? 'No Body'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToNotiPage(String title, String body) {
    widget.navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => NotiPage(title: title, body: body),
    ));
  }

  // detail
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Handler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _body,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
