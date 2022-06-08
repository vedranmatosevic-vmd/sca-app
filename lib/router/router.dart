import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/match/create_new_match.dart';
import 'package:sca_app/match/new_match.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/team/new_team.dart';

void navigateTo(BuildContext context, Pages page, {Match? match}) {
  if (page == Pages.newMatch) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewMatch(match: match!))
    );
  } else if (page == Pages.newPlayer) {
  } else if (page == Pages.newTeam) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTeam()));
  } else if (page == Pages.createNewMatch) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CreateNewMatch()));
  }
}

enum Pages { home, teams, newTeam, player, newPlayer, newMatch, createNewMatch }