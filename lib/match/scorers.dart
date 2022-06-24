import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/match/match_details.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../common/style.dart';
import '../models/goal.dart';
import '../models/team.dart';

Player player1 = Player(name: "Maro", lastName: "Globan", birthDate: "13.03.2014");

class Scorers extends StatelessWidget {
  const Scorers({Key? key, required this.match}) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();

    return StyledLayout(
        appBarTitle: "Scorers",
        body: FutureBuilder<List<Team>>(
          future: service.getTeamsByMatch(selectedLeague, match),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Style.colorRed,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {

              Team _homeTeam = Team.emptyTeam();
              Team _awayTeam = Team.emptyTeam();

              for (final team in snapshot.data! as List<Team>) {
                if (team.shortName == match.homeTeam) {
                  _homeTeam = team;
                } else if (team.shortName == match.awayTeam) {
                  _awayTeam = team;

                }
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _playersListView(context, match, _homeTeam),
                    _playersListView(context, match, _awayTeam),
                  ],
                ),
              );
            }
            return const Text('Something went wrong');
          },
        ),
    );
  }
}

_playersListView(BuildContext context, Match match, Team team) {
  return Column(
    children: _listOfPlayers(context, match, team),
  );
}

_listOfPlayers(BuildContext context, Match match, Team team) {

  List<Widget> widgets = [];
  widgets.add(
    Container(
      decoration: BoxDecoration(
        color: Style.getColor(context, StyleColor.grey)
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            team.name.toString(),
            style: Style.getTextStyle(context, StyleText.textBold),
          ),
        ],
      ),
    )
  );
  for (final player in team.players!) {
    widgets.add(_playerCard(context, match, player, team));
  }
  return widgets;
}

Widget _playerCard(BuildContext context, Match match, Player player, Team team) {
  return GestureDetector(
    onTap: () async {
      Goal goal = Goal(player: player, match: match);

      if (team.shortName == match.homeTeam) {
        match.homeScore++;
      } else if (team.shortName == match.awayTeam) {
        match.awayScore++;
      }

      DatabaseService service = DatabaseService();
      await service.addGoal(match, goal);
      await service.updateMatch(match);
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MatchDetails(matchId: match.uuid.toString())), (route) => false);
      Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Style.getColor(context, StyleColor.grey),
              )
          )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Style.colorDarkBlue,
              borderRadius: BorderRadius.all(Radius.circular(19)),
            ),
            child: Center(
              child: Text(
                "${player.name[0]}${player.lastName[0]}",
                style: Style.getTextStyle(context, StyleText.bigTextRegular, StyleColor.white),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Text(
            "${player.name} ${player.lastName}",
            style: Style.getTextStyle(context, StyleText.textBold),
          ),
          const Spacer(),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ic_shirt.png')
                )
            ),
            child: Center(
              child: Text(
                player.shirtNumber.toString(),
                style: Style.getTextStyle(context, StyleText.ultraSmallTextRegular, StyleColor.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

