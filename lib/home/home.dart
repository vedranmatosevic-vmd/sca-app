import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sport Club Admin',
      home: Scaffold(
        body: Text("Second"),
      ),
    );
  }
}

