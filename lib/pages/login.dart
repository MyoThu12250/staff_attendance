import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ui/pages/homepage.dart';

// add SingleChildScrollView

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isShow = false;
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _globalKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Please sign in to continue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey[500]),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // validator: (str) {
                  //   if (str!.isEmpty) {
                  //     return "abc@gmail.com";
                  //   }
                  //   if (!str.contains('@')) {
                  //     return 'required';
                  //   }
                  //   if (!str.endsWith('.com')) {
                  //     return 'required';
                  //   }
                  //   return null;
                  // },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    hintText: 'Enter username',
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (str) {
                    if (str.toString().length < 6) {
                      return "required";
                    }
                    if (str!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.https_outlined),
                    hintText: '******',
                    labelText: 'Password',
                    suffixIcon: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget',
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  obscureText: !isShow,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Switch(
                        value: isShow,
                        onChanged: (val) {
                          setState(() {
                            isShow = val;
                          });
                        }),
                    const Text("Show password")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        bool isValid = _globalKey.currentState!.validate();
                        if (isValid) {
                          print('success and do login process');
                        }
                        Get.to(HomePage());
                      },
                      label: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
