import 'package:flutter/material.dart';
import 'package:sca_app/widget/header_home_screen.dart';
import 'package:sca_app/widget/menu_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Sport Club Admin',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Column(
            children: const <Widget>[
              HeaderCardHomeScreen(),
              MenuCardHomeScreen(),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Futsalito'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


