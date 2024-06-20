import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:CheckMate/config_route.dart';
import 'package:CheckMate/pages/leave.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;
  var isLogin = false.obs;
  var deviceid = ''.obs;
  var username = ''.obs;
  var id = ''.obs;
  var password = ''.obs;
  var userInfo = {}.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  final boxx = GetStorage();
  final _storage = FlutterSecureStorage();
  final _accessToken = ''.obs;
  final authorization = ''.obs;
  final _refreshToken = ''.obs;
  final _accessTokenExpiryTime = DateTime.now().obs;
  final _refreshTokenExpiryTime = DateTime.now().obs;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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
      final response = await _makePostRequest(
        Config.loginRoute,
        {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        {
          'employeeId': username.value,
          'password': password.value,
        },
      );

      if (response.statusCode == 200) {
        authorization.value = json.decode(response.body)['accessToken'];

        print('hi');
        Get.off(Leave(
          leaveDetail: {},
        ));
        userInfo.value = jsonDecode(response.body)['userData'];
        isLogin.value = true;
        boxx.write('isLogin', isLogin.value);
        box.write('userInfo', userInfo.value);

        final accessToken = json.decode(response.body)['accessToken'];
        final refreshToken = json.decode(response.body)['refreshToken'];
        await _saveTokens(accessToken, refreshToken);
        _startTokenRefreshTimer();

        _setupFirebaseMessaging();
      } else if (response.statusCode == 401) {
        Get.snackbar('Login Error', 'User name or Password Wrong',
            backgroundColor: Color(0xF44336FF));
      }
    } catch (e) {
      Get.snackbar('Login Error', 'Check Your Connection',
          backgroundColor: Color(0xF44336FF));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> post() async {
    final response = await _makePostRequest(
      Config.fcmSendRoute,
      {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      {
        'userId': userInfo['userId'].toString(),
        'token': deviceid.value,
      },
    );
    print(DateTime.now());
    print(response.statusCode);
    print('this is sending token');
  }

  Future<http.Response> _makePostRequest(String url,
      Map<String, String> headers, Map<String, dynamic> body) async {
    headers['Authorization'] = 'Bearer ${authorization.value}';
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  void loadProfileData() {
    userInfo.value = box.read('userInfo') ?? {};
  }

  void loadloginData() {
    isLogin.value = boxx.read('isLogin') ?? false;
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    _accessToken.value = accessToken;
    authorization.value = accessToken;
    _refreshToken.value = refreshToken;
    _accessTokenExpiryTime.value = JwtDecoder.getExpirationDate(accessToken);
    _refreshTokenExpiryTime.value = JwtDecoder.getExpirationDate(refreshToken);
  }

  Future<void> _loadTokens() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (accessToken != null && refreshToken != null) {
      _accessToken.value = accessToken;
      authorization.value = accessToken;
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
      final response = await _makePostRequest(
        Config.refreshRoute,
        {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        {
          'refreshTokenFromUser': _refreshToken.value,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final newAccessToken = responseData['accessToken'];
        authorization.value = newAccessToken;
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

  Future<void> logout() async {
    try {
      final response = await _makeGetRequest(
          '${Config.logoutByIdRoute}/${userInfo['userId'].toString()}');

      if (response.statusCode == 200 || response.statusCode == 404) {
        await _storage.deleteAll();
        boxx.write('isLogin', false);
        box.erase();
        _accessToken.value = '';
        _refreshToken.value = '';
        _accessTokenExpiryTime.value = DateTime.now();
        _refreshTokenExpiryTime.value = DateTime.now();
        _refreshTimer?.cancel();

        Get.offAllNamed('/');
      } else {
        print('Failed to logout: ${response.statusCode}');
        Get.snackbar('Logout Failed', 'Unable to logout. Please try again.');
      }
    } catch (e) {
      print('Error logging out: $e');
      Get.snackbar('Logout Error', 'An error occurred. Please try again.');
    }
  }

  Future<http.Response> _makeGetRequest(String url) async {
    final headers = {
      'Authorization': 'Bearer ${authorization.value}',
    };
    return await http.get(Uri.parse(url), headers: headers);
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened a message in the background!');
    });

    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      deviceid.value = token.toString();
      print("Firebase Messaging Token: $token");

      if (token != null && userInfo['userId'] != null) {
        post();
      } else {
        print('Token or userId is null');
      }
    });
  }
}
