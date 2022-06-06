import 'package:flutter/material.dart';
import 'package:sca_app/match/match.dart';

void navigateToMatch(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MatchPage())
  );
}

enum Pages {
  home,
  teams,
  newTeam,
  player,
  newPlayer,
  newGame
}