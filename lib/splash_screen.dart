import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: CustomColors.primaryBlue
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    if (status) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          )
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          )
      );
    }
  }
}
