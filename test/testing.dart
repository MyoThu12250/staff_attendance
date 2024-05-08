// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:firebase_core/firebase_core.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyImageUploadScreen());
// // }
// //
// // class MyImageUploadScreen extends StatelessWidget {
// //   // Future<void> _uploadImage() async {
// //   //   final picker = ImagePicker();
// //   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
// //   //
// //   //   if (pickedFile != null) {
// //   //     final file = File(pickedFile.path);
// //   //     final Reference storageRef = FirebaseStorage.instance
// //   //         .ref()
// //   //         .child('images/${DateTime.now().toString()}');
// //   //     await storageRef.putFile(file);
// //   //     print('Image uploaded to Firebase Storage');
// //   //   } else {
// //   //     print('No image selected.');
// //   //   }
// //   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Upload Image to Firebase'),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () {},
// //           child: Text('Select Image'),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dropdown Example'),
//         ),
//         body: ElevatedButton(
//           onPressed: () {
//             _showDialog(context);
//           },
//           child: Text('Dialog'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _showDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       // Dialog is dismissible with a tap on the barrier.
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Dialog Title'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('This is a Flutter dialog box.'),
//                 Text('You can add any content here.'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog.
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap your app with MaterialApp
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

Future<void> _showDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    // Dialog is dismissible with a tap on the barrier.
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Dialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a Flutter dialog box.'),
              Text('You can add any content here.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog.
            },
          ),
        ],
      );
    },
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show dialog box here

            _showDialog(context);
          },
          child: Text('Show Dialog'),
        ),
      ),
    );
  }
}
