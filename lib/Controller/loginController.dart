import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project_ui/pages/homepage.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var userInfo = {}.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  final _storage = FlutterSecureStorage();
  final _accessToken = ''.obs;
  final _refreshToken = ''.obs;
  final _accessTokenExpiryTime = DateTime.now().obs;
  final _refreshTokenExpiryTime = DateTime.now().obs;
  Timer? _refreshTimer;
  var profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTokens();
  }

  Future<void> login() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://10.103.0.226:8000/api/v1/users/loginUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        userInfo.value = jsonDecode(response.body)['userData'];
        box.write('userInfo', userInfo.value);
        final accessToken = json.decode(response.body)['accessToken'];
        final refreshToken = json.decode(response.body)['refreshToken'];
        await _saveTokens(accessToken, refreshToken);
        _startTokenRefreshTimer();
        Get.off(HomePage());
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadProfileData() {
    userInfo.value = box.read('userInfo') ?? {};
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    _accessToken.value = accessToken;
    _refreshToken.value = refreshToken;
    _accessTokenExpiryTime.value = JwtDecoder.getExpirationDate(accessToken);
    _refreshTokenExpiryTime.value = JwtDecoder.getExpirationDate(refreshToken);
  }

  Future<void> _loadTokens() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (accessToken != null && refreshToken != null) {
      _accessToken.value = accessToken;
      _refreshToken.value = refreshToken;
      _accessTokenExpiryTime.value = JwtDecoder.getExpirationDate(accessToken);
      _refreshTokenExpiryTime.value =
          JwtDecoder.getExpirationDate(refreshToken);
      _startTokenRefreshTimer();
    }
  }

  void _startTokenRefreshTimer() {
    final timeToAccessTokenExpiry =
        _accessTokenExpiryTime.value.difference(DateTime.now()).inSeconds;
    final timeToRefreshTokenExpiry =
        _refreshTokenExpiryTime.value.difference(DateTime.now()).inSeconds;

    if (timeToAccessTokenExpiry > 0 && timeToRefreshTokenExpiry > 0) {
      _refreshTimer?.cancel();
      final refreshTime =
          timeToAccessTokenExpiry > 9 ? timeToAccessTokenExpiry - 5 : 0;
      _refreshTimer = Timer(Duration(seconds: refreshTime), refreshToken);
    } else {
      logout();
    }
  }

  Future<void> refreshToken() async {
    final timeToRefreshTokenExpiry =
        _refreshTokenExpiryTime.value.difference(DateTime.now()).inSeconds;

    if (timeToRefreshTokenExpiry > 0) {
      final response = await http.post(
        Uri.parse('http://10.103.0.142:8000/api/v1/refresh/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'refreshTokenFromUser': _refreshToken.value,
        }),
      );

      if (response.statusCode == 200) {
        print('hitherre');
        final responseData = json.decode(response.body);
        final newAccessToken = responseData['accessToken'];
        print(newAccessToken);
        await _saveTokens(newAccessToken, _refreshToken.value);
        _startTokenRefreshTimer();
      } else {
        logout();
      }
    } else {
      logout();
    }
  }

  void logout() {
    _storage.deleteAll();
    _accessToken.value = '';
    _refreshToken.value = '';
    _accessTokenExpiryTime.value = DateTime.now();
    _refreshTokenExpiryTime.value = DateTime.now();
    _refreshTimer?.cancel();
  }
}

// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:project_ui/pages/homepage.dart';
//
// class LoginController extends GetxController {
//   var username = ''.obs;
//   var password = ''.obs;
//   var userInfo = {}.obs;
//   var isLoading = false.obs;
//   final box = GetStorage();
//   final _storage = FlutterSecureStorage();
//   final _accessToken = ''.obs;
//   final _refreshToken = ''.obs;
//   final _expiryTime = DateTime.now().obs;
//   Timer? _refreshTimer;
//   var profileImage = ''.obs;
//
//   // Path to the profile image
//   @override
//   void onInit() {
//     super.onInit();
//     _loadTokens();
//   }
//
//   Future<void> login() async {
//     isLoading.value = true;
//     try {
//       final response = await http.post(
//         Uri.parse('http://10.103.0.142:8000/api/v1/users/loginUser'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'username': username.value,
//           'password': password.value,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         userInfo.value = jsonDecode(response.body)['userData'];
//         box.write('userInfo', userInfo.value);
//         print(userInfo.value);
//         final accessToken = json.decode(response.body)['accessToken'];
//         final refreshToken = json.decode(response.body)['refreshToken'];
//         print(accessToken);
//         print(refreshToken);
//         await _saveTokens(accessToken, refreshToken!);
//         _startTokenRefreshTimer();
//
//         Get.off(HomePage());
//       } else {
//         throw Exception('Failed to login');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Network error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void loadProfileData() {
//     userInfo.value = box.read('userInfo') ?? {};
//     // profileImage.value = box.read('profileImage') ?? '';
//   }
//
//   Future<void> _saveTokens(String accessToken, String refreshToken) async {
//     await _storage.write(key: 'access_token', value: accessToken);
//     await _storage.write(key: 'refresh_token', value: refreshToken);
//     _accessToken.value = accessToken;
//     _expiryTime.value = JwtDecoder.getExpirationDate(accessToken);
//   }
//
//   Future<void> _loadTokens() async {
//     final accessToken = await _storage.read(key: 'access_token');
//     final refreshToken = await _storage.read(key: 'refresh_token');
//     if (accessToken != null && refreshToken != null) {
//       _accessToken.value = accessToken;
//       _refreshToken.value = refreshToken;
//       _expiryTime.value = JwtDecoder.getExpirationDate(accessToken);
//       _startTokenRefreshTimer();
//     }
//   }
//
//   void _startTokenRefreshTimer() {
//     final timeToExpiry = _expiryTime.value.difference(DateTime.now()).inSeconds;
//     if (timeToExpiry > 0) {
//       _refreshTimer?.cancel();
//       _refreshTimer = Timer(Duration(seconds: timeToExpiry - 2), refreshToken);
//
//       // Refresh 1 minute before expiry
//     }
//   }
//
//   Future<void> refreshToken() async {
//     final response = await http.post(
//       Uri.parse('http://10.103.0.142:8000/api/v1/refresh/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'refreshTokenFromUser': _refreshToken.value,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print('hi');
//       final responseData = json.decode(response.body);
//       final newAccessToken = responseData['accessToken'];
//       final newExpiryTime = JwtDecoder.getExpirationDate(newAccessToken);
//
//       await _saveTokens(newAccessToken, _refreshToken.value);
//       _expiryTime.value = newExpiryTime;
//       _startTokenRefreshTimer();
//     } else {
//       logout();
//     }
//   }
//
//   void logout() {
//     _storage.deleteAll();
//     _accessToken.value = '';
//     _refreshTimer?.cancel();
//   }
// }
