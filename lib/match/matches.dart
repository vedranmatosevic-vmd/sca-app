import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/styled_layout.dart';
import 'package:sca_app/models/match.dart';

import '../services/database_service.dart';

Match newMatch = Match(
    competition: selectedLeague,
    homeTeam: 'FŠ Zagi',
    awayTeam: 'Gimka Malešnica',
    date: '16.6.2022',
    time: '11:20',
    duration: 30,
    round: 1,
    homeScore: 2,
    awayScore: 1);

Match newMatch2 = Match(
    competition: selectedLeague,
    homeTeam: 'OŠ Savski Gaj',
    awayTeam: 'Gimka Keglić',
    date: '16.6.2022',
    time: '11:55',
    duration: 30,
    round: 1,
    homeScore: 5,
    awayScore: 2);

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    return FutureBuilder(
      future: service.getMatchesByCompetition(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print('You have an error! ${snapshot.error.toString()}');
          }
          return const Text('Something went wrong');
        } else if (snapshot.hasData) {
          return StyledLayout(
            appBarTitle: 'Matches',
            actions: _actions(context),
            body: _body(context),
          );;
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

_body(BuildContext context) {
  return ListView(
    children: <Widget>[
      _roundTitle(newMatch.round.toString()),
      _matchCard(newMatch),
      _matchCard(newMatch2),
      _matchCard(newMatch),
      _roundTitle(newMatch.round.toString()),
      _matchCard(newMatch),
      _matchCard(newMatch),
      _matchCard(newMatch)
    ],
  );
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
      color: CustomColors.greyBack,
    ),
    child: Expanded(
      child: Text(
        '$round round',
        style: const TextStyle(color: CustomColors.textGreyDark, fontSize: 16),
      ),
    ),
  );
}

_matchCard(Match match) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 60,
    decoration: const BoxDecoration(
        border: Border(
      top: BorderSide(width: 0.3, color: CustomColors.textGreyLight),
      bottom: BorderSide(width: 1.0, color: CustomColors.textGreyLight),
    )),
    child: Row(
      children: <Widget>[
        _circleHours(match),
        _scoreRow(match),
      ],
    ),
  );
}

_circleHours(Match match) {
  return Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: CustomColors.primaryBlue, shape: BoxShape.circle),
    child: Text(
      match.time,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}

_scoreRow(Match match) {
  return Container(
    padding: const EdgeInsets.only(left: 14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${match.homeTeam} ${match.homeScore} - ${match.awayScore} ${match.awayTeam}',
          style: const TextStyle(
              color: CustomColors.textGreyDark, fontWeight: FontWeight.w500),
        ),
        Text(match.date,
            style: const TextStyle(
                color: CustomColors.textGreyLight,
                fontWeight: FontWeight.w400,
                fontSize: 12))
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
