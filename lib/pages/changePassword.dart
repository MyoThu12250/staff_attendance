import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_ui/pages/home.dart';
import 'package:project_ui/pages/testProfile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _reNewPassword = TextEditingController();

  bool _obscureText = false;

  void validate() {
    String password = _password.text.toString();
    String newPassword = _newPassword.text.toString();
    String reNewPassword = _reNewPassword.text.toString();
    if (password.isNotEmpty &&
        newPassword.isNotEmpty &&
        reNewPassword.isNotEmpty) {
      // current password check
      if (newPassword != reNewPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('New password and confirm password must be same')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successful change password')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Missing data or check password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(ProfilePage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(ProfilePage());
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: true,
          title: Text('Reset Password'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Card(
                    margin: EdgeInsets.only(top: 120),
                    elevation: 8,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: SizedBox(
                              width: 280,
                              child: TextField(
                                obscureText: !_obscureText,
                                controller: _password,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.https),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 280,
                            child: TextField(
                              obscureText: !_obscureText,
                              controller: _newPassword,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                prefixIcon: Icon(Icons.https),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: SizedBox(
                              width: 280,
                              child: TextField(
                                obscureText: !_obscureText,
                                controller: _reNewPassword,
                                decoration: InputDecoration(
                                  labelText: 'Comfirm Password',
                                  prefixIcon: Icon(Icons.https),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _obscureText,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _obscureText = value ?? false;
                                  });
                                },
                              ),
                              Text('Show Password'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                validate();
                              },
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
