import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/models/player.dart';

class Goal {
  late int uuid = UniqueKey().hashCode;
  late Player player;
  late Match match;
  late bool? isOwnGoal = false;

  Goal.emptyMatch();

  Goal({
    required this.player,
    required this.match,
    this.isOwnGoal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'player': player.toMap(),
      'match': match.toMap(),
      'isOwnGoal': isOwnGoal,
    };
  }

  Goal.fromMap(Map<String, dynamic> goalMap)
      : uuid = goalMap["id"] as int,
        player = goalMap["player"] as Player,
        match = goalMap["match"] as Match,
        isOwnGoal = goalMap["isOwnGoal"] as bool;
}