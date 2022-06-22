import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/header_home_screen.dart';
import 'package:sca_app/widget/menu_home_screen.dart';
import 'package:sca_app/widget/sidebar.dart';
import 'package:sca_app/widget/styled_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = selectedLeague;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    title = selectedLeague;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {


    return StyledLayout(
      appBarTitle: title,
      drawer: const SideBar(),
      body: Column(
        children: const <Widget>[
          HeaderCardHomeScreen(),
          MenuCardHomeScreen(),
        ],
      ),
      willPop: false,
    );
  }
}
