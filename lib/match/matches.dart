import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/leading_icons.dart';
import 'package:sca_app/widget/styled_layout.dart';
import 'package:sca_app/models/match.dart';

import '../services/database_service.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key, this.page}) : super(key: key);

  final Pages? page;

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    currentPage = Pages.matches;

    DatabaseService service = DatabaseService();
    return StyledLayout(
      appBarTitle: 'Matches',
      leading: LeadingIcons(callback: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
      },),
      actions: _actions(context),
      body: FutureBuilder<List<Match>>(
        future: service.getMatchesByCompetition(selectedLeague),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Style.colorRed,
                ),
              );
            }
            if (snapshot.hasData) {
              return _body(context, snapshot.data!);
            }
            return const Text('Something went wrong');
          }),
    );
  }
}

_body(BuildContext context, List<Match> listOfMatches) {
  return ListView(
    children: _matchesByRound(context, listOfMatches),
  );
}

_matchesByRound(BuildContext context, List<Match> listOfMatches) {
  List<Widget> widgets = [];
  int currentRounds = 1;
  bool newRound = true;
  for (final match in listOfMatches) {
    if (match.round > currentRounds) {
      newRound = true;
      currentRounds++;
    }
    if (newRound) {
      widgets.add(_roundTitle(currentRounds.toString()));
      newRound = false;
    }
    widgets.add(_matchCard(context, match));
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
      color: Style.colorGrey,
    ),
    child: Row(
      children: <Widget>[
        Text(
          '$round round',
          style: const TextStyle(color: Style.colorDarkBlue, fontSize: 16),
        ),
      ]
    ),
  );
}

_matchCard(BuildContext context, Match match) {
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
          _scoreRow(context, match),
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
        color: Style.colorDarkBlue, shape: BoxShape.circle),
    child: Text(
      match.time,
      style: Style.getTextStyle(context, StyleText.smallTextRegular, StyleColor.white),
    ),
  );
}

_scoreRow(BuildContext context, Match match) {
  return Container(
    padding: const EdgeInsets.only(left: 14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${match.homeTeam} 0 - 0 ${match.awayTeam}',
          // '${match.homeTeam} ${match.homeScore} - ${match.awayScore} ${match.awayTeam}',
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
