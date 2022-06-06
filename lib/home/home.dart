import 'package:flutter/material.dart';
import 'package:sca_app/team/team_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const TeamPage()));
    return WillPopScope(
      onWillPop: () async => false,
      child: const MaterialApp(
        title: 'Sport Club Admin',
        home: Scaffold(
          body: Center(child: Text("Main")),
        ),
      ),
    );
  }
}

