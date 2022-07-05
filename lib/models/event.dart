import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sca_app/common/constants.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/models/player.dart';

class Event {
  late int uuid = UniqueKey().hashCode;
  late int playerId;
  late int matchId;
  late int teamId;
  late String eventType;
  late int? period;
  late int? minute;
  late bool? isOwnGoal = false;
  late String createdTime = returnDateTimeNow();

  Event.emptyGoal();

  Event({
    required this.playerId,
    required this.matchId,
    required this.teamId,
    required this.eventType,
    this.isOwnGoal,
    this.period = 1,
    this.minute = 10
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uuid;
    data['playerId'] = playerId;
    data['matchId'] = matchId;
    data['teamId'] = teamId;
    data['period'] = period;
    data['minute'] = minute;
    data['eventType'] = eventType;
    data['isOwnGoal'] = isOwnGoal;
    data['createdTime'] = createdTime;
    return data;
  }

  Event.fromMap(Map<String, dynamic> goalMap) {
    uuid = goalMap["id"];
    playerId = goalMap["playerId"];
    matchId = goalMap["matchId"];
    teamId = goalMap["teamId"];
    period = goalMap["period"];
    minute = goalMap["minute"];
    eventType = goalMap["eventType"];
    isOwnGoal = goalMap["isOwnGoal"];
    createdTime = goalMap["createdTime"];
  }
}

enum EventType {
  goal,
  yellowCard,
  redCard
}