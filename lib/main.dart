import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Sport Club Admin',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black
          ),
        ),
        home: FutureBuilder(
          future: widget._fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print('You have an error! ${snapshot.error.toString()}');
              }
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              return const SplashScreen();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        // const SplashScreen()
      ),
    );
  }
}
