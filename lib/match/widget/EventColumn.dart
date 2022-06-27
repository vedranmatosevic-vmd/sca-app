import 'package:flutter/material.dart';
import 'package:sca_app/models/event.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/services/database_service.dart';

import '../../common/style.dart';

DatabaseService service = DatabaseService();

class EventColumn extends StatefulWidget {
  const EventColumn({Key? key, required this.events, required this.players}) : super(key: key);

  final List<Event> events;
  final List<Player> players;

  @override
  State<EventColumn> createState() => _EventColumnState();
}

class _EventColumnState extends State<EventColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _listOfEvents(context)
    );
  }

  _listOfEvents(BuildContext context) {
    List<Widget> widgets = [];
    for (final event in widget.events) {
      widgets.add(_eventCard(context, event));
    }
    return widgets;
  }

  _eventCard(BuildContext context, Event event) {
    String _playerName = "";

    for (final player in widget.players) {
      if (player.uuid == event.playerId) {
        _playerName = "${player.name} ${player.lastName}";
      }
    }

    return GestureDetector(
        onTap: () {

        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Style.getColor(context, StyleColor.grey)
                  )
              )
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Style.getColor(context, StyleColor.darkBlue),
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Style.getColor(context, StyleColor.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Style.getColor(context, StyleColor.grey),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 16,
                  ),
                ),
              ),
              // TODO VEDRAN - dodati box za gol gosta
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        event.eventType == EventType.goal.name ? "Scored goal!" : event.eventType == EventType.yellowCard.name ? "Yellow card!" : "Red card!",
                        style: Style.getTextStyle(context, StyleText.textBold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        _playerName,
                        style: Style.getTextStyle(context, StyleText.textRegular),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10,),
              const Spacer(),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "home",
                        // match.homeScore.toString(),
                        style: Style.getTextStyle(context, StyleText.textBold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2,),
                  Row(
                    children: <Widget>[
                      Text(
                        "away",
                        // match.awayScore.toString(),
                        style: Style.getTextStyle(context, StyleText.textBold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
