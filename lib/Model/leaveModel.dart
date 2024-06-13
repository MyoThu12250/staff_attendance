// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class Department {
//   final String deptName;
//
//   Department({required this.deptName});
//
//   factory Department.fromJson(Map<String, dynamic> json) {
//     return Department(
//       deptName: json['deptName'],
//     );
//   }
// }
//
// class User {
//   final String username;
//   final int departmentId;
//   final String position;
//   final Department department;
//
//   User({
//     required this.username,
//     required this.departmentId,
//     required this.position,
//     required this.department,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       username: json['username'],
//       departmentId: json['DepartmentId'],
//       position: json['Position'],
//       department: Department.fromJson(json['Department']),
//     );
//   }
// }
//
// class LeaveRequest {
//   final int id;
//   final String reasons;
//   final String leaveType;
//   final String status;
//   final String from;
//   final String to;
//   final String? attachmentUrl;
//   final String createdAt;
//   final String updatedAt;
//   final int userId;
//   final User user;
//
//   LeaveRequest({
//     required this.id,
//     required this.reasons,
//     required this.leaveType,
//     required this.status,
//     required this.from,
//     required this.to,
//     this.attachmentUrl,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.userId,
//     required this.user,
//   });
//
//   factory LeaveRequest.fromJson(Map<String, dynamic> json) {
//     return LeaveRequest(
//       id: json['id'],
//       reasons: json['reasons'],
//       leaveType: json['leaveType'],
//       status: json['status'],
//       from: json['from'],
//       to: json['to'],
//       attachmentUrl: json['attachmentUrl'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       userId: json['UserId'],
//       user: User.fromJson(json['User']),
//     );
//   }
// }
//
// class LeaveRequestService {
//   static const String baseUrl =
//       'http://10.103.0.142:8000/api/v1/leaveRecord'; // Replace with your API base URL
//
//   Future<List<LeaveRequest>> fetchLeaveRequests(int userId) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/leave_requests?userId=$userId'));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       List<dynamic> body = json.decode(response.body);
//       return body.map((json) => LeaveRequest.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load leave requests');
//     }
//   }
// }
