import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/squared_button.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../services/database_service.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({
    Key? key,
    required this.match
  }) : super(key: key);

  final Match match;

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {

  @override
  void initState() {

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return StyledLayout(
        appBarTitle: "Match details",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MatchDetailHeader(match: widget.match),
          ActionRow(match: widget.match)
        ],
      ),
      actions: _actions(widget.match),
    );
  }
}

class MatchDetailHeader extends StatefulWidget {
  const MatchDetailHeader({Key? key, required this.match}) : super(key: key);

  final Match match;

  @override
  State<MatchDetailHeader> createState() => _MatchDetailHeaderState();
}

class _MatchDetailHeaderState extends State<MatchDetailHeader> {

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          color: Style.colorGrey
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${widget.match.date} at ${widget.match.time} - ${widget.match.duration} min',
            style: const TextStyle(
                color: Style.colorBlack,
                fontSize: 14
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.match.homeTeam,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Style.colorBlack,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.match.homeScore} - 0',
                      style: const TextStyle(
                          fontSize: 26,
                          color: Style.colorBlack,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.match.awayTeam,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Style.colorBlack,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Futsalito, ${widget.match.round}' 'st round',
                style: const TextStyle(
                    color: Style.colorBlack,
                    fontSize: 14
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionRow extends StatefulWidget {
  const ActionRow({Key? key, required this.match}) : super(key: key);

  final Match match;

  @override
  State<ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<ActionRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SquaredButton(
              value: "Goal",
              icon: Icons.sports_soccer,
              page: Pages.scorers,
            match: widget.match,
          ),
          SquaredButton(
            value: "Card",
            icon: Icons.crop_square,
            page: Pages.addCard,
          )
        ],
      ),
    );
  }
}

_actions(Match match) {
  return <Widget>[
    const SizedBox(
      width: 10,
    ),
    GestureDetector(
      onTap: () async {
        DatabaseService service = DatabaseService();
        await service.updateMatch(match);
      },
        child: Icon(Icons.save)
    ),
    const SizedBox(
      width: 10,
    )
  ];
}
