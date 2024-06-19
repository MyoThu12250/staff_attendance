class Config {
  static const String baseUrl = 'http://10.103.0.142:8000/api/v1';

  static const String createAttendanceRoute = '$baseUrl/attendance/click';

  static const String getAttendanceRouteById = '$baseUrl/attendance';

  static const String createAttendanceRequestRoute =
      '$baseUrl/attendanceRequest/createRequest';

  static const String getAttendanceRequestByIdRoute =
      '$baseUrl/attendanceRequest';

  static const String fcmSendRoute = '$baseUrl/fcm/send';

  static const String createLeaveRecordRoute =
      '$baseUrl/leaveRecord/createLeave';

  static const String getLeaveRecordByIdRoute = '$baseUrl/leaveRecord';

  static const String deleteLeaveRecordByIdRoute =
      '$baseUrl/leaveRecord/delete';

  static const String updateLeaveRecordByIdRoute =
      '$baseUrl/leaveRecord/update';

  static const String loginRoute = '$baseUrl/login/loginUser';

  static const String logoutByIdRoute = '$baseUrl/login/logoutUser';

  static const String resetPasswordRoute = '$baseUrl/users/resetPassword/';

  static const String mapCheckRoute = '$baseUrl/mapCheck';

  static const String refreshRoute = '$baseUrl/refresh';

  static const String updateProfileRoute = '$baseUrl/updateProfileImage';

  static const String getUpdateProfileRoute =
      '$baseUrl/updateProfileImage/getUpdatedImage';

  static const String getAttdanceRequestHistoryRoute =
      '$baseUrl/attendanceRequest';
  static const String getAttdanceRequestHistoryByIdRoute =
      '$baseUrl/attendanceRequest/getAttendance';

  static const String RangeRoute = '$baseUrl/location/getLoc';

  static const String testRoute = '$baseUrl//test/'; // testing route
}
