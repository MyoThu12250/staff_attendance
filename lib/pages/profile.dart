import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import '../Controller/leaveController.dart';
// import '../Controller/loginController.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // LeaveController lontroller = Get.put(LeaveController());
// final LoginController controller = Get.find();
  final box = GetStorage();

  // ProfilePage() {
  //   // controller.loadProfileData();
  // }

  // void _logout() {
  //   box.erase();
  //   Get.offAllNamed('/');
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // _userController.getData();
  // }

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
                                  icon: IconButton(
                                    color: Colors.black,
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Profile());
}
