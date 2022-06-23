import 'package:flutter/material.dart';
import 'package:sca_app/models/goal.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/styled_layout.dart';

import 'match_details.dart';

Player player1 = Player(name: "Maro", lastName: "Globan", birthDate: "13.03.2014");

class Scorers extends StatelessWidget {
  const Scorers({Key? key, required this.match}) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    Goal goal = Goal(player: player1, match: match);
    return StyledLayout(
        appBarTitle: "Scorers",
        body: GestureDetector(
          onTap: () async {
            match.homeScore++;
            //TODO Vedran
            DatabaseService service = DatabaseService();
            await service.addGoal(goal);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return MatchDetails(match: match);
            }));
          },
          child: const Center(child: Text("HHHH"),
        )
      ),
    );
  }
}
