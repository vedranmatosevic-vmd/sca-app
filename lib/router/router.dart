import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/match/new_match.dart';
import 'package:sca_app/team/new_team.dart';
import 'package:sca_app/widget/dialog_new_match.dart';

void navigateTo(BuildContext context, Pages page) {
  if (page == Pages.newMatch) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const DialogNewMatch();
        });
  } else if (page == Pages.newPlayer) {
  } else if (page == Pages.newTeam) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTeam()));
  }
}

enum Pages { home, teams, newTeam, player, newPlayer, newMatch }