import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
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
                      style: Style.getTextStyle(context, StyleText.formFieldTextNormal),
                      controller: usernameController,
                      cursorColor: Style.getColor(context, StyleColor.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Style.getColor(context, StyleColor.grey)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Style.getColor(context, StyleColor.black)
                              )
                          ),
                          hintText: 'Username'
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      style: Style.getTextStyle(context, StyleText.formFieldTextNormal),
                      controller: passwordController,
                      cursorColor: Style.getColor(context, StyleColor.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Style.getColor(context, StyleColor.grey)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Style.getColor(context, StyleColor.black)
                              )
                          ),
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
                            color: Style.colorWhite,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          primary: Style.getColor(context, StyleColor.red),
                          backgroundColor: Style.getColor(context, StyleColor.red),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: _login,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Prijava',
                              style: Style.getTextStyle(context, StyleText.buttonTextWhite),
                            ),
                          ],
                        ),
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
