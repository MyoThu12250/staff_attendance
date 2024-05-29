import 'dart:convert';

class TestModel {
  String leaveType;
  int date;
  String reason;
  int from;
  int to;
  String status;
  String userId;
  String id;
  String? name;

  TestModel({
    required this.leaveType,
    required this.date,
    required this.reason,
    required this.from,
    required this.to,
    required this.status,
    required this.userId,
    required this.id,
    this.name,
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
        name: json["name"],
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
        "name": name,
      };
}
