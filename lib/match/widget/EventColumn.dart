import 'package:flutter/material.dart';
import 'package:sca_app/models/event.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/services/database_service.dart';

import '../../common/style.dart';

DatabaseService service = DatabaseService();

class EventColumn extends StatefulWidget {
  const EventColumn({Key? key, required this.events, required this.players, required this.match}) : super(key: key);

  final List<Event> events;
  final List<Player> players;
  final Match match;

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
          child: event.teamId == widget.match.homeTeam ? _homeEventCard(event, _playerName) : _awayEventCard(event, _playerName)
        )
    );
  }

  _homeEventCard(Event event, String playerName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Style.getColor(context, StyleColor.darkBlue),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            alignment: Alignment.bottomRight,
            child: _eventIcon(event.eventType)
        ),
        const SizedBox(width: 10,),
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
                  playerName,
                  style: Style.getTextStyle(context, StyleText.textRegular),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10,),
      ],
    );
  }

  _awayEventCard(Event event, String playerName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Spacer(),
        const SizedBox(width: 10,),
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
                  playerName,
                  style: Style.getTextStyle(context, StyleText.textRegular),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10,),
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Style.getColor(context, StyleColor.darkBlue),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            alignment: Alignment.bottomLeft,
            child: _eventIcon(event.eventType)
        ),
      ],
    );
  }

  _eventIcon(String eventType) {
    IconData? iconData;
    Color? cardColor;

    if (eventType == EventType.goal.name) {
      iconData = Icons.sports_soccer;
    } else if (eventType == EventType.yellowCard.name) {
      cardColor = Style.getColor(context, StyleColor.yellow);
    } else if (eventType == EventType.redCard.name) {
      cardColor = Style.getColor(context, StyleColor.red);
    }

    return Container(
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
      child: eventType == EventType.goal.name ? Icon(
        iconData,
        size: 16,
      ) : Center(
            child: Container(
              width: 10,
              height: 14,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
            ),
      ),
    );
  }
}


