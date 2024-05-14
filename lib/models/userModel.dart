import 'dart:convert';

class User {
  String token;
  UserData userData;

  User({
    required this.token,
    required this.userData,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userData": userData.toJson(),
      };
}

class UserData {
  int userId;
  String username;
  String email;
  String employeeId;
  int phoneNumber;
  String address;
  String dob;
  String profileImage;
  int annualLeave;
  int medicalLeave;
  int attendanceLeave;
  String nrc;

  UserData({
    required this.userId,
    required this.username,
    required this.email,
    required this.employeeId,
    required this.phoneNumber,
    required this.address,
    required this.dob,
    required this.profileImage,
    required this.annualLeave,
    required this.medicalLeave,
    required this.attendanceLeave,
    required this.nrc,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        username: json["username"],
        email: json["email"],
        employeeId: json["employeeId"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        dob: json["DOB"],
        profileImage: json["profileImage"],
        annualLeave: json["annualLeave"],
        medicalLeave: json["medicalLeave"],
        attendanceLeave: json["attendanceLeave"],
        nrc: json["NRC"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "email": email,
        "employeeId": employeeId,
        "phoneNumber": phoneNumber,
        "address": address,
        "DOB": dob,
        "profileImage": profileImage,
        "annualLeave": annualLeave,
        "medicalLeave": medicalLeave,
        "attendanceLeave": attendanceLeave,
        "NRC": nrc,
      };
}
