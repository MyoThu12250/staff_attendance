import 'dart:convert';

class TestModel {
  String leaveType;
  String date;
  String reason;
  int from;
  int to;
  String status;
  String userId;
  int id;

  TestModel({
    required this.leaveType,
    required this.date,
    required this.reason,
    required this.from,
    required this.to,
    required this.status,
    required this.userId,
    required this.id,
  });

  factory TestModel.fromRawJson(String str) =>
      TestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        leaveType: json["leaveType"],
        date: json["date"],
        reason: json["reason"],
        from: json["from"],
        to: json["to"],
        status: json["status"],
        userId: json["UserId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "leaveType": leaveType,
        "date": date,
        "reason": reason,
        "from": from,
        "to": to,
        "status": status,
        "UserId": userId,
        "id": id,
      };
}
