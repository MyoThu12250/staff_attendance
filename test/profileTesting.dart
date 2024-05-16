import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(Icons.notifications),
              ),
            ],
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              background: Image.asset(
                'assets/images/agb.png',
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_listenToScroll);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_listenToScroll);
//     super.dispose();
//   }
//
//   void _listenToScroll() {
//     if (_scrollController.offset > 200) {
//       // adjust the values as needed
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             expandedHeight: 200,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.network(
//                 'https://via.placeholder.com/800x400',
//                 // replace with your image
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 _buildProfileHeader(),
//                 // add your other widgets here
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     return Stack(
//       alignment: Alignment.topLeft,
//       children: [
//         AnimatedOpacity(
//           opacity: _scrollController.offset > 200 ? 0 : 1,
//           duration: Duration(milliseconds: 300),
//           child: Image.network(
//             'https://via.placeholder.com/150x150', // replace with your image
//             fit: BoxFit.cover,
//           ),
//         ),
//         AnimatedPadding(
//           padding: EdgeInsets.only(
//             top: _scrollController.offset > 200 ? 16 : 64,
//           ),
//           duration: Duration(milliseconds: 300),
//           child: Text(
//             'John Doe',
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// //
// // class ProfilePage extends StatefulWidget {
// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }
// //
// // class _ProfilePageState extends State<ProfilePage> {
// //   final ScrollController _scrollController = ScrollController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollController.addListener(_listenToScroll);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.removeListener(_listenToScroll);
// //     _scrollController.dispose();
// //     super.dispose();
// //   }
// //
// //   void _listenToScroll() {
// //     setState(() {});
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: CustomScrollView(
// //         controller: _scrollController,
// //         slivers: [
// //           SliverAppBar(
// //             pinned: true,
// //             expandedHeight: 200,
// //             flexibleSpace: FlexibleSpaceBar(
// //               background: Image.network(
// //                 'https://via.placeholder.com/800x400',
// //                 // replace with your image
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: Column(
// //               children: [
// //                 _buildProfileHeader(),
// //                 // Add your other widgets here
// //                 _buildContent(), // Example method for additional content
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProfileHeader() {
// //     return Stack(
// //       alignment: Alignment.topLeft,
// //       children: [
// //         AnimatedOpacity(
// //           opacity:
// //               _scrollController.hasClients && _scrollController.offset > 200
// //                   ? 0
// //                   : 1,
// //           duration: Duration(milliseconds: 300),
// //           child: Image.network(
// //             'https://via.placeholder.com/150x150', // replace with your image
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //         AnimatedPadding(
// //           padding: EdgeInsets.only(
// //             top: _scrollController.hasClients && _scrollController.offset > 200
// //                 ? 16
// //                 : 64,
// //           ),
// //           duration: Duration(milliseconds: 300),
// //           child: Text(
// //             'John Doe',
// //             style: TextStyle(fontSize: 24),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildContent() {
// //     // Example method for additional content
// //     return Column(
// //       children: [
// //         ListTile(
// //           leading: Icon(Icons.email),
// //           title: Text('Email: johndoe@example.com'),
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.phone),
// //           title: Text('Phone: (123) 456-7890'),
// //         ),
// //         // Add more content widgets as needed
// //       ],
// //     );
// //   }
// // }
// //
// void main() {
//   runApp(MaterialApp(
//     home: ProfilePage(),
//   ));
// }
