// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: MyDialog(),
//   ));
// }
//
// class MyDialog extends StatelessWidget {
//   const MyDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dialog'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   shadowColor: Colors.red,
//                   elevation: 30,
//                   title: Text(
//                     "dismissable ",
//                     style: TextStyle(
//                       color: Colors.red[800],
//                     ),
//                   ),
//                   content: Text(
//                     " dismissable ",
//                     style: TextStyle(
//                       color: Colors.red[400],
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   actions: [
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         elevation: 8,
//                       ),
//                       child: Text(
//                         "OK",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Text('Dialog'),
//         ),
//       ),
//     );
//   }
// }
