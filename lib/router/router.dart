import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/competitions/create_new_competition.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/match/create_new_match.dart';
import 'package:sca_app/match/match_details.dart';
import 'package:sca_app/match/scorers.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/team/create_new_team.dart';
import 'package:sca_app/team/team_details.dart';
import 'package:sca_app/team/teams.dart';
import '../models/team.dart';

void navigateTo(BuildContext context, Pages page, {Match? match, String? title, Team? team}) {
  if (page == Pages.newMatch) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MatchDetails(match: match!))
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
  } else if (page == Pages.teams) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Teams()));
  } else if (page == Pages.teamDetails) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TeamDetails(team: team!)));
  } else if (page == Pages.scorers) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Scorers(match: match!,)));
  }
}

enum Pages {
  home,
  teams,
  newTeam,
  player,
  newPlayer,
  newMatch,
  createNewMatch,
  newLeague,
  addGoal,
  addCard,
  teamDetails,
  scorers
}