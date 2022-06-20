import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../common/style.dart';
import '../models/team.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  late final Team team;

  @override
  void initState() {
    team = widget.team;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StyledLayout(
      appBarTitle: "Team details",
      body: Column(
        children: <Widget>[
          _header(context)
        ],
      ),
    );
  }
}

_header(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
                selectedLeague,
              style: Style.getTextStyle(context, StyleText.subTitle),
            )
          ],
        )
      ],
    ),
  );
}
