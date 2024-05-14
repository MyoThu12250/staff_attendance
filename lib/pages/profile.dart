import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_ui/Controller/userController.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  UserController _userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController.getData();
  }

  @override
  Widget build(BuildContext context) {
    // final users = _userController.users[Widget.index]['userId'];
    // _nameController.text = _userController.users[];
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    double _radius = 70;
    return Scaffold(
      appBar: AppBar(),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.243,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.purpleAccent,
                        Colors.green,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: CircleAvatar(
                                radius: _radius,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    "https://loremflickr.com/640/480"),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    // Get.to(EditPage());
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
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
                Center(
                  child: Text(
                    'Mg Mg',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      Text('Jamedafar'),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Name'),
                      Text('Jamedafar'),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Name'),
                      Text('Jamedafar'),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Name'),
                      Text('Jamedafar'),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Name'),
                      Text('Jamedafar'),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(
                //             width: 100,
                //             height: 40,
                //             child: Center(child: Text('User Name'))),
                //         Text('Employee id'),
                //         Text('Position'),
                //         Text('Phone no'),
                //         Text('Email'),
                //         Text('Address'),
                //         Text('Date of Birth'),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(
                //             width: 100,
                //             height: 40,
                //             child: Center(child: Text('Ag Ag'))),
                //         Text('697830011'),
                //         Text('CEO'),
                //         Text('09697830011'),
                //         Text('agag@gmail.com'),
                //         Text('New York'),
                //         Text('12/2/89'),
                //       ],
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
