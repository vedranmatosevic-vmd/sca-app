import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/competitions/create_new_competition.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/match/create_new_match.dart';
import 'package:sca_app/match/new_match.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/team/create_new_team.dart';

void navigateTo(BuildContext context, Pages page, {Match? match}) {
  if (page == Pages.newMatch) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewMatch(match: match!))
    );
  } else if (page == Pages.newLeague) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewCompetition()));
  } else if (page == Pages.newTeam) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTeam()));
  } else if (page == Pages.createNewMatch) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CreateNewMatch()));
  } else if (page == Pages.home) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}

enum Pages { home, teams, newTeam, player, newPlayer, newMatch, createNewMatch, newLeague }