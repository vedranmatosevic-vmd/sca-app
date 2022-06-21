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
              color: Style.colorBlack,
            ),
            child: Text(
              username.isNotEmpty ? username : "Username",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration:
            const BoxDecoration(color: Style.colorGrey),
            child: competitionsByUser.isNotEmpty ? Row(
              children: <Widget>[
                DropdownButton<String>(
                  dropdownColor: Style.colorGrey,
                  iconEnabledColor: Style.colorBlack,
                  underline: Container(),
                  value: selectedLeague,
                  items: competitionsByUser.map((String item) {
                    return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: Style.getTextStyle(context, StyleText.subTitle),
                        ));
                  }).toList(),
                  onChanged: (String? value) async {
                    setState(() {
                      selectedLeague = value!;
                      getTeamsByCompetitions(selectedLeague);
                    });
                    navigateTo(context, Pages.home);
                    // navigateTo(context, Pages.home, title: selectedLeague);
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
            title: Text(
                'Teams',
              style: Style.getTextStyle(context, StyleText.textRegular),
            ),
            onTap: () {
              navigateTo(context, Pages.teams);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.sports_soccer,
              color: Colors.black,
            ),
            title: Text(
                'Matches',
              style: Style.getTextStyle(context, StyleText.textRegular),
            ),
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
            title: Text(
                'Table',
              style: Style.getTextStyle(context, StyleText.textRegular),
            ),
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
