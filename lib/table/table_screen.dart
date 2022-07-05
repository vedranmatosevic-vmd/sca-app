import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../common/style.dart';
import '../models/team.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    late List<Team> listOfTeam;

    Future<List<Match>> getData() async {
      listOfTeam = await service.getTeamsByCompetition(selectedLeague.uuid);
      return await service.getMatchesByCompetition(selectedLeague.uuid);
    }

    return StyledLayout(
      appBarTitle: 'Table',
      body: FutureBuilder<List<Match>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Style.colorRed,
              ),
            );
          }
          if (snapshot.hasData) {
            return _body(snapshot.data!, listOfTeam);
          }
          return const Text('Something went wrong');
        },
      )
    );
  }

  _body(matches, List<Team> teams) {
    return Column(
      children: <Widget>[
        _header(),
      ],
    );
  }

  _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Style.colorDarkRed,
      ),
      child: Row(
        children: <Widget>[
          Text("#")
        ],
      ),
    );
  }
}
