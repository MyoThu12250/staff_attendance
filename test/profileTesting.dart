import 'package:flutter/material.dart';

void main() {
  runApp(TestProfile());
}

class TestProfile extends StatefulWidget {
  const TestProfile({super.key});

  @override
  State<TestProfile> createState() => _TestProfileState();
}

class _TestProfileState extends State<TestProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Test'),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage("https://loremflickr.com/640/480"),
                  ),
                ),
                Positioned(
                  left: 80,
                  right: 0,
                  bottom: 20,
                  child: CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      onPressed: () {
                        // Get.to(EditPage());
                      },
                      icon: IconButton(
                        color: Colors.black,
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
