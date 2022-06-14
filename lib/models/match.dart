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
      : uuid = matchMap["uuid"],
        competition = matchMap["competition"],
        homeTeam = matchMap["homeTeam"],
        awayTeam = matchMap["awayTeam"],
        date = matchMap["date"],
        time = matchMap["time"],
        duration = matchMap["duration"],
        round = matchMap["round"],
        homeScore = matchMap["homeScore"],
        awayScore = matchMap["awayScore"];
}
