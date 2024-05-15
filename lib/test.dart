// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LeavePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Retrieve the filteredData from arguments
//     List<dynamic> filteredData = Get.arguments as List<dynamic>;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave Page'),
//       ),
//       body: ListView.builder(
//         itemCount: filteredData.length,
//         itemBuilder: (context, index) {
//           var item = filteredData[index];
//           return ListTile(
//             title: Text(item['reasons']),
//             subtitle: Text(item['leaveType']),
//             // Add more widgets to display other data
//           );
//         },
//       ),
//     );
//   }
// }
