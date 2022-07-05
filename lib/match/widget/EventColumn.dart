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
  void initState() {
    widget.events.sort((a, b) {
      int cmp = b.minute!.compareTo(a.minute!);
      if (cmp != 0) return cmp;
      return b.period!.compareTo(a.period!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Style.getColor(context, StyleColor.greyBorder),
          )
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _listOfEvents(context)
      ),
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
        _playerName = "${player.name[0]}. ${player.lastName}";
      }
    }

    return GestureDetector(
        onTap: () {

        },
        child: Container(
          child: event.teamId == widget.match.homeTeam ? _homeEventCard(event, _playerName) : _awayEventCard(event, _playerName)
        )
    );
  }

  _homeEventCard(Event event, String playerName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Style.colorGreyBorder,
                          width: 1
                      )
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2 - 21),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "$playerName  ${event.minute}'",
                        style: Style.getTextStyle(context, StyleText.textRegular),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  _eventIcon(event.eventType),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  _awayEventCard(Event event, String playerName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2 + 1,
              height: 60,
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          color: Style.colorGreyBorder,
                          width: 1
                      )
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _eventIcon(event.eventType),
                  const SizedBox(width: 10,),
                  Row(
                    children: [
                      Text(
                        "${event.minute}'  $playerName",
                        style: Style.getTextStyle(context, StyleText.textRegular),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
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
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Style.getColor(context, StyleColor.white),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Style.getColor(context, StyleColor.grey),
          width: 1,
        ),
      ),
      child: eventType == EventType.goal.name ? Icon(
        iconData,
        size: 28,
      ) : Center(
            child: Container(
              width: 16,
              height: 20,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
            ),
      ),
    );
  }
}


