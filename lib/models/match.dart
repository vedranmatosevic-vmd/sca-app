import 'dart:convert';

import 'package:flutter/material.dart';

import 'goal.dart';

class Match {
  late int uuid = UniqueKey().hashCode;
  late String competition;
  late String homeTeam;
  late String awayTeam;
  late String date;
  late String time;
  late int duration;
  late int round;
  late bool isPlayed;

  Match.emptyMatch();

  Match({
    required this.competition,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
    required this.duration,
    required this.round,
    this.isPlayed = false
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uuid;
    data['competition'] = competition;
    data['homeTeam'] = homeTeam;
    data['awayTeam'] = awayTeam;
    data['date'] = date;
    data['time'] = time;
    data['duration'] = duration;
    data['round'] = round;
    data['isPlayed'] = isPlayed;
    return data;
  }

  Match.fromMap(Map<String, dynamic> matchMap) {
    uuid = matchMap["id"];
    competition = matchMap["competition"];
    homeTeam = matchMap["homeTeam"];
    awayTeam = matchMap["awayTeam"];
    date = matchMap["date"];
    time = matchMap["time"];
    duration = matchMap["duration"];
    round = matchMap["round"];
    isPlayed = matchMap["isPlayed"];
  }
}
