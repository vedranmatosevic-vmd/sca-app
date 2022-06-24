import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/models/player.dart';

import '../common/style.dart';
import '../models/team.dart';
import '../router/router.dart';
import '../services/database_service.dart';

class Players extends StatelessWidget {
  const Players({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    return FutureBuilder<List<Player>>(
        future: service.getPlayersByTeam(selectedLeague, team.name),
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
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _playersListView(context, snapshot.data!, team)
                ],
              ),
            );
          }
          return const Text('Something went wrong');
        }
    );
  }
}

_playersListView(BuildContext context, List<Player> players, Team team) {
  return Column(
    children: _listOfPlayers(context, players, team),
  );
}

_listOfPlayers(BuildContext context, List<Player> players, Team team) {
  List<Widget> widgets = [];
  for (final player in players) {
    widgets.add(_playerCard(context, player));
  }
  widgets.add(
      GestureDetector(
        onTap: () {
          navigateTo(context, Pages.newPlayer, team: team);
        },
        child: Container(
          width: 200,
          height: 24,
          margin: const EdgeInsets.only(top: 40, bottom: 40),
          decoration: BoxDecoration(
            color: Style.getColor(context, StyleColor.red),
          ),
          child: Center(
            child: Text(
              'ADD PLAYER',
              style: Style.getTextStyle(context, StyleText.smallTextBold, StyleColor.white),
            ),
          ),
        ),
      )
  );
  return widgets;
}

Widget _playerCard(BuildContext context, Player player) {
  return GestureDetector(
    onTap: () {

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
