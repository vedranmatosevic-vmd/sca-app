import 'package:flutter/material.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/models/competition.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/services/database_service.dart';

import '../common/loaded_data.dart';
import '../common/style.dart';
import '../match/matches.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  DatabaseService service = DatabaseService();

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
              color: Style.colorRed,
            ),
            child: Text(
              username.isNotEmpty ? username : "Username",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration:
            const BoxDecoration(color: Style.colorDarkRed),
            child: competitionsByUser.isNotEmpty ? Row(
              children: <Widget>[
                DropdownButton<String>(
                  dropdownColor: Style.colorDarkRed,
                  iconEnabledColor: Style.colorWhite,
                  underline: Container(),
                  value: selectedLeague.name,
                  items: competitionsByUser.map((Competition item) {
                    return DropdownMenuItem(
                        value: item.name,
                        child: Text(
                          item.name,
                          style: Style.getTextStyle(context, StyleText.subTitle, StyleColor.white),
                        ));
                  }).toList(),
                  onChanged: (String? value) async {
                    selectedLeague = await service.getCompetitionByValue(value!);
                    setState(() {
                      getTeamsByCompetitions(selectedLeague.uuid);
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
                  MaterialPageRoute(builder: (context) => Matches(page: Pages.home,)));
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
              navigateTo(context, Pages.table);
            },
          ),
        ],
      ),
    );
  }
}
