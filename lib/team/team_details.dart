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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _header(context, team),
            _tabController()
          ],
        ),
      ),
    );
  }
}

_tabController() {
  return DefaultTabController(
      length: 3,
      // TODO Vedran
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Rezultati",),
              Tab(text: "Raspored",),
              Tab(text: "Momčad",),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      )
  );
}

_header(BuildContext context, Team team) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              selectedLeague,
              style: Style.getTextStyle(context, StyleText.subTitle),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imagePlaceHolder(context, team.shortName[0]),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                team.name,
                style: Style.getTextStyle(context, StyleText.bigTextBold, StyleColor.black),
              ),
            )
          ],
        )
      ],
    ),
  );
}

_imagePlaceHolder(BuildContext context, String title) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Style.getColor(context, StyleColor.grey),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Center(
      child: Text(
        title,
        style: Style.getTextStyle(context, StyleText.bigTextBold, StyleColor.red),
      ),
    ),
  );
}
