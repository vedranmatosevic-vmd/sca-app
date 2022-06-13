import 'package:flutter/material.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/router/router.dart';

import '../common/loaded_data.dart';
import '../common/style.dart';
import '../match/matches.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              username.isNotEmpty ? username : "Username",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration:
            const BoxDecoration(color: CustomColors.primaryBlue),
            child: competitionsByUser.isNotEmpty ? Row(
              children: <Widget>[
                DropdownButton<String>(
                  dropdownColor: CustomColors.primaryBlue,
                  iconEnabledColor: Colors.white,
                  underline: Container(),
                  value: selectedLeague,
                  items: competitionsByUser.map((String item) {
                    return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedLeague = value!;
                      getTeamsByCompetitions(selectedLeague);
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ) : const Text("Create league"),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Matches()));
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
    );
  }
}
