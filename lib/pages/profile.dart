import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text('Profile'),
        ),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Container(
          // color: Colors.amberAccent.withOpacity(.7),
          width: screenWidth,
          height: screenHeight * .7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('User Name'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Employee id'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Position'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Phone no'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Email'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Address'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Date of Birth'),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Ag Ag'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('697830011'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('CEO'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('09697830011'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('agag@gmail.com'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('New York'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('12/2/89'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
