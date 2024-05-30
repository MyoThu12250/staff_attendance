import 'package:flutter/material.dart';

class LeaveForm extends StatefulWidget {
  final Map<String, dynamic> leaveDetail;
  bool isedit;
  int? index;

  LeaveForm({
    Key? key,
    required this.isedit,
    required this.leaveDetail,
    this.index,
  }) : super(key: key);

  //
  // LeaveForm({required this.leaveDetail});

  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  late TextEditingController _reasonController;
  late TextEditingController _leaveTypeController;

  @override
  void initState() {
    super.initState();
    _reasonController =
        TextEditingController(text: widget.leaveDetail['reasons']);
    _leaveTypeController =
        TextEditingController(text: widget.leaveDetail['leaveType']);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _leaveTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _leaveTypeController,
              decoration: InputDecoration(labelText: 'Leave Type'),
            ),
            // Add other fields as necessary
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the save operation
                // For example, you can update the leave details in the backend or local storage
                Map<String, dynamic> updatedLeaveDetail = {
                  'reasons': _reasonController.text,
                  'leaveType': _leaveTypeController.text,
                  // Add other fields as necessary
                };

                // Update the backend or local storage with updatedLeaveDetail

                // Navigate back or show a success message
                Navigator.pop(context, updatedLeaveDetail);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LeaveDetailPage extends StatelessWidget {
//   final Map<String, dynamic> leaveDetail;
//
//   LeaveDetailPage({required this.leaveDetail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave Detail'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () async {
//               var result = await Get.to(LeaveForm(leaveDetail: leaveDetail));
//               if (result != null) {
//                 // Handle the updated leave detail if necessary
//               }
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Reason: ${leaveDetail['reasons']}', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 10),
//             Text('Status: ${leaveDetail['status']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('Leave Type: ${leaveDetail['leaveType']}', style: TextStyle(fontSize: 16)),
//             // Add more details as necessary
//           ],
//         ),
//       ),
//     );
//   }
// }
