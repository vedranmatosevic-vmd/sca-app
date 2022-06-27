import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sca_app/common/constants.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/models/player.dart';

class Goal {
  late int uuid = UniqueKey().hashCode;
  late int playerId;
  late int matchId;
  late int teamId;
  late bool? isOwnGoal = false;
  late String createdTime = returnDateTimeNow();

  Goal.emptyGoal();

  Goal({
    required this.playerId,
    required this.matchId,
    required this.teamId,
    this.isOwnGoal,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uuid;
    data['playerId'] = playerId;
    data['matchId'] = matchId;
    data['teamId'] = teamId;
    data['isOwnGoal'] = isOwnGoal;
    data['createdTime'] = createdTime;
    return data;
  }

  Goal.fromMap(Map<String, dynamic> goalMap) {
    uuid = goalMap["id"];
    playerId = goalMap["playerId"];
    matchId = goalMap["matchId"];
    teamId = goalMap["teamId"];
    isOwnGoal = goalMap["isOwnGoal"];
    createdTime = goalMap["createdTime"];
  }
}