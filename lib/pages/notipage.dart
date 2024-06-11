// // import 'package:flutter/material.dart';
// //
// // class NotiPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: false,
// //         title: Text('Notification'),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: 1,
// //               itemBuilder: (context, index) {
// //                 return const Column(
// //                   children: [
// //                     Padding(
// //                       padding: EdgeInsets.symmetric(
// //                         vertical: 15.0,
// //                         horizontal: 5,
// //                       ),
// //                       child: ListTile(
// //                         title: Text(
// //                           'Request Rejected',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 17,
// //                           ),
// //                         ),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               'May, 12, 2024',
// //                               style: TextStyle(
// //                                 fontSize: 14,
// //                               ),
// //                             ),
// //                             Text(
// //                               'Your Request Rejected blah blah',
// //                               style: TextStyle(
// //                                 fontSize: 15,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class NotiPage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<NotiPage> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(message.data);
//       // Handle foreground messages
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Opened a message in the background!');
//       // Handle background messages
//     });
//
//     _firebaseMessaging.requestPermission();
//     _firebaseMessaging.getToken().then((String? token) {
//       assert(token != null);
//       print("Firebase Messaging Token: $token");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('FCM Demo'),
//         ),
//         body: Center(
//           child: Text('Push Notifications with FCM'),
//         ),
//       ),
//     );
//   }
// }
import 'package:CheckMate/Controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'homepage.dart';
import 'notiDetailPage.dart';

final String status = 'rejected';

IconData getIcon(String status) {
  switch (status) {
    case 'pending':
      return Icons.pending;
    case 'accepted':
      return Icons.check_circle;
    case 'rejected':
      return Icons.cancel;
    default:
      return Icons.error;
  }
}

Color getColor(String status) {
  switch (status) {
    case 'pending':
      return Colors.grey;
    case 'accepted':
      return Colors.green;
    case 'rejected':
      return Colors.red;
    default:
      return Colors.transparent;
  }
}

class NotiPage extends StatefulWidget {
  @override
  State<NotiPage> createState() => _NotiPageState();
}

LoginController c = Get.put(LoginController());
final box = GetStorage();

final String id = c.userInfo['userId'];

class _NotiPageState extends State<NotiPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage(
          leaveDetail: {},
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.off(HomePage(
              //   leaveDetail: {},
              // ));
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: false,
          title: Text('Notification'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(NotiDetailPage());
                          },
                          child: ListTile(
                            trailing: Icon(
                              getIcon(status),
                              color: getColor(status),
                            ),
                            // change icon accoriding to status
                            title: Text(
                              'Request Rejected',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'May, 12, 2024',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Your Request Pending blah blah',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
