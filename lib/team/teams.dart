import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/widget/leading_icons.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../common/style.dart';
import '../models/team.dart';
import '../router/router.dart';
import '../services/database_service.dart';

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    return StyledLayout(
      appBarTitle: "Teams",
      leading: LeadingIcons(callback: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
      },),
      body: FutureBuilder<List<Team>>(
        future: service.getTeamsByCompetition(selectedLeague.uuid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Style.colorRed,
              ),
            );
          }
          if (snapshot.hasData) {
            return TeamList(teams: snapshot.data);
          }
          return const Text('Something went wrong');
        },
      ),
      actions: _actions(context),
    );
  }
}

class TeamList extends StatelessWidget {
  const TeamList({Key? key, required this.teams}) : super(key: key);

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: _listOfTeams(context, teams),
    );
  }
}

_listOfTeams(BuildContext context, List<Team> teams) {
  List<Widget> widgets = [];
  for(final team in teams) {
    widgets.add(_teamRow(context, team));
  }
  return widgets;
}

_teamRow(BuildContext context, Team team) {
  return GestureDetector(
    onTap: () {
      navigateTo(context, Pages.teamDetails, team: team);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Style.colorBlack),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            team.name,
            style: Style.getTextStyle(context, StyleText.textBold),
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: Style.getColor(context, StyleColor.red),
          )
        ],
      ),
    ),
  );
}

_actions(BuildContext context) {
  return <Widget>[
    const SizedBox(
      width: 10,
    ),
    GestureDetector(
      onTap: () {
        navigateTo(context, Pages.newTeam);
      },
      child: const Icon(Icons.add),
    ),
    const SizedBox(
      width: 10,
    )
  ];
}

