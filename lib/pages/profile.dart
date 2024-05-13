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
        title: Center(child: Text('Profile')),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight * .7,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(child: Text('User Name'))),
                      Text('Employee id'),
                      Text('Position'),
                      Text('Phone no'),
                      Text('Email'),
                      Text('Address'),
                      Text('Date of Birth'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(child: Text('Ag Ag'))),
                      Text('697830011'),
                      Text('CEO'),
                      Text('09697830011'),
                      Text('agag@gmail.com'),
                      Text('New York'),
                      Text('12/2/89'),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
