class Match {
  late final String homeTeam;
  late String awayTeam;
  late String date;
  late String time;
  late int homeScore;
  late int awayScore;
  late int duration;
  late int round;

  Match.emptyMatch();

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
    required this.duration,
    required this.round,
    this.homeScore = 0,
    this.awayScore = 0
  });
}
