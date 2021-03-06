import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/leading_icons.dart';
import 'package:sca_app/widget/styled_layout.dart';
import 'package:sca_app/models/match.dart';

import '../models/team.dart';
import '../services/database_service.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key, this.page}) : super(key: key);

  final Pages? page;

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  DatabaseService service = DatabaseService();
  late List<Team> listOfTeam;

  Future<List<Match>> getData() async {
    listOfTeam = await service.getTeamsByCompetition(selectedLeague.uuid);
    return await service.getMatchesByCompetition(selectedLeague.uuid);
  }

  @override
  Widget build(BuildContext context) {
    currentPage = Pages.matches;

    return StyledLayout(
      appBarTitle: 'Matches',
      leading: LeadingIcons(callback: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
      },),
      actions: _actions(context),
      body: FutureBuilder<List<Match>>(
        future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Style.colorRed,
                ),
              );
            }
            if (snapshot.hasData) {
              return _body(context, snapshot.data!, listOfTeam);
            }
            return const Text('Something went wrong');
          }),
    );
  }
}

_body(BuildContext context, List<Match> listOfMatches, List<Team> listOfTeams) {
  return ListView(
    children: _matchesByRound(context, listOfMatches, listOfTeams),
  );
}

_matchesByRound(BuildContext context, List<Match> listOfMatches, List<Team> listOfTeams) {
  List<Widget> widgets = [];
  int currentRounds = listOfMatches[0].round;
  bool newRound = true;
  for (final match in listOfMatches) {
    if (match.round > currentRounds) {
      newRound = true;
      currentRounds = match.round;
    }
    if (newRound) {
      widgets.add(_roundTitle(currentRounds.toString()));
      newRound = false;
    }
    widgets.add(_matchCard(context, match, listOfTeams));
  }
  return widgets;
}

_roundTitle(String s) {
  String round;
  if (s == "1") {
    round = "1st";
  } else {
    round = "${s}nd";
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 50,
    alignment: Alignment.centerLeft,
    decoration: const BoxDecoration(
      color: Style.colorDarkRed,
    ),
    child: Row(
      children: <Widget>[
        Text(
          '$round round',
          style: const TextStyle(color: Style.colorWhite, fontSize: 16),
        ),
      ]
    ),
  );
}

_matchCard(BuildContext context, Match match, List<Team> listOfTeams) {
  return GestureDetector(
    onTap: () {
      pagesFromToMD = Pages.matches;
      navigateTo(context, Pages.matchDetails, match: match);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 0.3, color: Style.colorBlack),
        bottom: BorderSide(width: 1.0, color: Style.colorBlack),
      )),
      child: Row(
        children: <Widget>[
          _circleHours(context,match),
          _scoreRow(context, match, listOfTeams),
        ],
      ),
    ),
  );
}

_circleHours(BuildContext context, Match match) {
  return Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Style.colorBlack, shape: BoxShape.circle),
    child: Text(
      match.time,
      style: Style.getTextStyle(context, StyleText.smallTextRegular, StyleColor.white),
    ),
  );
}

_scoreRow(BuildContext context, Match match, List<Team> listOfTeams) {

  late Team _homeTeam;
  late Team _awayTeam;

  for (final team in listOfTeams) {
    if (team.uuid == match.homeTeam) _homeTeam = team;
    if (team.uuid == match.awayTeam) _awayTeam = team;
  }

  return Container(
    padding: const EdgeInsets.only(left: 14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_homeTeam.shortName} ${match.homeScore} - ${match.awayScore} ${_awayTeam.shortName}',
          style: Style.getTextStyle(context, StyleText.textBold),
        ),
        Text(match.date,
            style: Style.getTextStyle(context, StyleText.smallTextRegular),
        )
      ],
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
        navigateTo(context, Pages.createNewMatch);
      },
      child: const Icon(Icons.add),
    ),
    const SizedBox(
      width: 10,
    )
  ];
}
