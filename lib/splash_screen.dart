import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/loaded_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String name = "";
  String lastname = "";

  void getData() async {
    setState(() {
      DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref().child('users/vematosevic');

      Stream<DatabaseEvent> competitionsStream = databaseRef.child('competitions').onValue;
      Stream<DatabaseEvent> nameStream = databaseRef.child('name').onValue;
      Stream<DatabaseEvent> lastNameStream = databaseRef.child('lastname').onValue;


      nameStream.listen((DatabaseEvent event) {
        name = event.snapshot.value.toString();
        username = name;
      });

      lastNameStream.listen((DatabaseEvent event) {
        lastname = event.snapshot.value.toString();
        username += ' $lastname';
      });

      competitionsStream.listen((DatabaseEvent event) {
        competitionsByUser.clear();
        for (final child in event.snapshot.children) {
          competitionsByUser.add(child.key!);
        }
        selectedLeague = competitionsByUser.first;
        getTeamsByCompetitions(selectedLeague);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    getData();
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
