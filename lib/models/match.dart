import 'package:flutter/material.dart';

class Match {
  late int uuid = UniqueKey().hashCode;
  late String competition;
  late String homeTeam;
  late String awayTeam;
  late String date;
  late String time;
  late int homeScore;
  late int awayScore;
  late int duration;
  late int round;

  Match.emptyMatch();

  Match({
    required this.competition,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
    required this.duration,
    required this.round,
    this.homeScore = 0,
    this.awayScore = 0
  });

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'competition': competition,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'date': date,
      'time': time,
      'duration': duration,
      'round': round,
      'homeScore': homeScore = 0,
      'awayScore': awayScore = 0,
    };
  }

  Match.fromMap(Map<String, dynamic> matchMap)
      : uuid = matchMap["id"] as int,
        competition = matchMap["competition"],
        homeTeam = matchMap["homeTeam"] as String,
        awayTeam = matchMap["awayTeam"] as String,
        date = matchMap["date"] as String,
        time = matchMap["time"] as String,
        duration = matchMap["duration"] as int,
        round = matchMap["round"] as int,
        homeScore = matchMap["homeScore"] as int,
        awayScore = matchMap["awayScore"] as int;
}
