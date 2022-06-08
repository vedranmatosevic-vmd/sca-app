import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/match/matches.dart';
import 'package:sca_app/widget/header_home_screen.dart';
import 'package:sca_app/widget/menu_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedValue;


  @override
  void initState() {
    super.initState();
    selectedValue = competitions[0];
  }

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
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Vedran Matošević',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: CustomColors.primaryBlue
                  ),
                  child: Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        dropdownColor: CustomColors.primaryBlue,
                        iconEnabledColor: Colors.white,
                        underline: Container(),
                          value: selectedValue,
                          items: competitions.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                                child: Text(
                                    item,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                            );
                          }).toList(),
                        onChanged: (String? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                        },
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.group,
                    color: Colors.black,
                  ),
                  title: const Text('Teams'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.sports_soccer,
                    color: Colors.black,
                  ),
                  title: const Text('Matches'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Matches()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.table_rows_rounded,
                    color: Colors.black,
                  ),
                  title: const Text('Table'),
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

List<String> competitions = [
  'Futsalito U7',
  'Futsalito U8',
  'Futsalito U9',
  'Futsalito U10',
  'Futsalito U11',
  'Futsalito U12',
  'Futsalito U13',
];


