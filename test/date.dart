import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenToScrollChange);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenToScrollChange);
    super.dispose();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset > 50) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: _scrollController.offset > 50
            ? Container()
            : CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg'),
                radius: 20,
              ),
        title: _scrollController.offset > 50
            ? Text('Profile')
            : Center(
                child: Text('John Doe'),
              ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            height: 200,
            color: Colors.blue,
          ),
          Container(
            height: 500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
