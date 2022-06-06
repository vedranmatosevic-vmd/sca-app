import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = {
  'vematosevic': '1234'
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Duration get loginTime => const Duration(milliseconds: 1250);

  Future<void> _login() {
    return Future.delayed(loginTime).then((value) => {
      users.forEach((key, value) {
        if (usernameController.text == key && passwordController.text == value) {
          saveSharedPrefs();
          log("Uspješna prijava");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              )
          );
        }
      })
    });
  }

  void saveSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Username'
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password'
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: CustomColors.primaryBlue,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(60, 16, 60, 16),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: _login,
                        child: const Text('Prijava'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
