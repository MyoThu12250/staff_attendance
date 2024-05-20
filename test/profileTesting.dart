// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(TestProfile());
// }
//
// class TestProfile extends StatefulWidget {
//   const TestProfile({super.key});
//
//   @override
//   State<TestProfile> createState() => _TestProfileState();
// }
//
// class _TestProfileState extends State<TestProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Profile Test'),
//         ),
//         body: Column(
//           children: [
//             Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.transparent,
//                     backgroundImage:
//                         NetworkImage("https://loremflickr.com/640/480"),
//                   ),
//                 ),
//                 Positioned(
//                   left: 80,
//                   right: 0,
//                   bottom: 20,
//                   child: CircleAvatar(
//                     radius: 20,
//                     child: IconButton(
//                       onPressed: () {
//                         // Get.to(EditPage());
//                       },
//                       icon: IconButton(
//                         color: Colors.black,
//                         onPressed: () {},
//                         icon: Icon(Icons.edit),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: NotificationIcon(),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              color: Colors.red,
              height: 150,
            ),
            Positioned(
              right: 120,
              top: 70,
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 75,
                    child: Image.asset(
                      'assets/images/agb.png',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 120,
              top: 165,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.edit),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name : ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Email  :  ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Employee Id  :  ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date of Birth  :  ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Address  :  ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Aung Aung',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'aung1234@gmail.com',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '15461656',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '10/10/2020',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      children: [
                        Text(
                          'Yangon',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Sign out'),
        ),
      ],
    );
  }
}
