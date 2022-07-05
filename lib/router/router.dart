import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/competitions/create_new_competition.dart';
import 'package:sca_app/home/home.dart';
import 'package:sca_app/match/create_new_match.dart';
import 'package:sca_app/match/events/goal.dart';
import 'package:sca_app/match/match_details.dart';
import 'package:sca_app/match/matches.dart';
import 'package:sca_app/match/events.dart';
import 'package:sca_app/models/event.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/players/create_new_player.dart';
import 'package:sca_app/team/create_new_team.dart';
import 'package:sca_app/team/team_details.dart';
import 'package:sca_app/team/teams.dart';
import 'package:sca_app/table/table_screen.dart';
import '../models/player.dart';
import '../models/team.dart';

void navigateTo(BuildContext context, Pages page,
    {Match? match, String? title, Team? team, Pages? pageBack, EventType? eventType, Event? event, Player? player}) {

  if (page == Pages.matchDetails) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MatchDetails(
                  match: match!,
                  pageBack: currentPage,
                  team: team,
                )));
  } else if (page == Pages.newLeague) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NewCompetition()));
  } else if (page == Pages.newTeam) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTeam()));
  } else if (page == Pages.createNewMatch) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateNewMatch()));
  } else if (page == Pages.home) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  } else if (page == Pages.teams) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Teams()));
  } else if (page == Pages.teamDetails) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TeamDetails(team: team!)));
  } else if (page == Pages.events) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Events(
                  match: match!,
              eventType: eventType!,
                )));
  } else if (page == Pages.newPlayer) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NewPlayer(team: team!)));
  } else if (page == Pages.goal) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Goal(event: event!, player: player!, match: match!, team: team!,)));
  } else if (page == Pages.table) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TableScreen()));
  }
}

enum Pages {
  home,
  teams,
  newTeam,
  player,
  newPlayer,
  matchDetails,
  createNewMatch,
  newLeague,
  addGoal,
  addCard,
  teamDetails,
  events,
  matches,
  goal,
  table
}
