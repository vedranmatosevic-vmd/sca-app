import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../../common/loaded_data.dart';
import '../../common/style.dart';
import '../../models/event.dart';
import '../../models/player.dart';
import '../../models/team.dart';
import '../../services/database_service.dart';
import '../../widget/input_text_form_field.dart';
import 'package:sca_app/models/match.dart';

import '../match_details.dart';

final _periodTEC = TextEditingController();
final _minuteTEC = TextEditingController();

bool _switchValue = false;

class Goal extends StatelessWidget {
  const Goal({
    Key? key,
    required this.event,
    required this.player,
    required this.match,
    required this.team
  }) : super(key: key);

  final Event event;
  final Player player;
  final Match match;
  final Team team;

  @override
  Widget build(BuildContext context) {
    _periodTEC.text = event.period.toString();
    _minuteTEC.text = event.minute.toString();
    _switchValue = false;

    DatabaseService service = DatabaseService();
    return StyledLayout(
      appBarTitle: 'Goal',
      actions: _actions(context, event, match, player, team),
      body: _body(context, event, player)
    );
  }
}

_body(BuildContext context, Event event, Player player) {
  return Column(
    children: <Widget>[
      _titleRow('Details'),
      InputTextFormField(controller: _periodTEC, value: "Period"),
      InputTextFormField(controller: _minuteTEC, value: "Minute"),
      const OwnRow(title: 'Is own goal'),
      _titleRow('Scorer'),
      _scorer(context, player),
    ],
  );
}

class OwnRow extends StatefulWidget {
  const OwnRow({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<OwnRow> createState() => _OwnRowState();
}

class _OwnRowState extends State<OwnRow> {

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: <Widget>[
          Text(
            widget.title,
            style: Style.getTextStyle(context, StyleText.textBold),
          ),
          const Spacer(),
          CupertinoSwitch(
            activeColor: Style.colorRed,
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              }
          )
        ],
      ),
    );
  }
}

_scorer(BuildContext context, Player player) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            color: Style.colorBlack,
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
  );
}

_titleRow(String s) {
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
            s,
            style: const TextStyle(color: Style.colorWhite, fontSize: 16),
          ),
        ]
    ),
  );
}

_actions(BuildContext context, Event event, Match match, Player player, Team team) {
  return <Widget>[
    const SizedBox(
      width: 10,
    ),
    GestureDetector(
        onTap: () async {
          DatabaseService service = DatabaseService();
          event.isOwnGoal = _switchValue;
          event.period = int.parse(_periodTEC.text);
          event.minute = int.parse(_minuteTEC.text);
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
        child: const Icon(Icons.save)
    ),
    const SizedBox(
      width: 10,
    )
  ];
}
