import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/match/match_details.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../common/style.dart';
import '../models/event.dart';
import '../models/team.dart';
import '../router/router.dart';

class Events extends StatelessWidget {
  const Events({Key? key, required this.match, required this.eventType}) : super(key: key);

  final Match match;
  final EventType eventType;

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    String title = "";

    List<Player> _homePlayers = [];
    List<Player> _awayPlayers = [];
    Team _homeTeam = Team.emptyTeam();
    Team _awayTeam = Team.emptyTeam();

    Future<void> getPlayers() async {
      _homePlayers = await service.getPlayersByTeam(match.homeTeam);
      _awayPlayers = await service.getPlayersByTeam(match.awayTeam);
      _homeTeam = await service.getTeamsById(match.homeTeam);
      _awayTeam = await service.getTeamsById(match.awayTeam);
    }

    if (eventType == EventType.goal) {
      title = "Goals";
    } else if (eventType == EventType.yellowCard) {
      title = "Yellow card";
    } else if (eventType == EventType.redCard) {
      title = "Red card";
    }

    return StyledLayout(
        appBarTitle: title,
        body: FutureBuilder(
          future: getPlayers(),
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
            if (!snapshot.hasError) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _playersListView(context, match, _homeTeam, _homePlayers, eventType),
                    _playersListView(context, match, _awayTeam, _awayPlayers, eventType),
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

_playersListView(BuildContext context, Match match, Team team, List<Player> listOfPlayers, EventType eventType) {
  return Column(
    children: _listOfPlayers(context, match, team, listOfPlayers, eventType),
  );
}

_listOfPlayers(BuildContext context, Match match, Team team, List<Player> listOfPlayers, EventType eventType) {

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
            team.name,
            style: Style.getTextStyle(context, StyleText.textBold),
          ),
        ],
      ),
    )
  );
  for (final player in listOfPlayers) {
    widgets.add(_playerCard(context, match, player, team, eventType));
  }
  return widgets;
}

Widget _playerCard(BuildContext context, Match match, Player player, Team team, EventType eventType) {
  return GestureDetector(
    onTap: () async {
      Event event = Event(playerId: player.uuid, matchId: match.uuid, teamId: team.uuid, eventType: eventType.name);

      DatabaseService service = DatabaseService();
      await service.addEvent(match, event);
      if (event.eventType == EventType.goal.name) {
        if (match.homeTeam == player.teamId) {
          match.homeScore++;
        } else if (match.awayTeam == player.teamId) {
          match.awayScore++;
        }
      }
      await service.updateMatch(match);
      // await service.updateMatch(match);
      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MatchDetails(match: match, team: team, pageBack: pagesFromToMD,)), (route) => false);
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

