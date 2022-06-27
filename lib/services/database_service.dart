import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/match/scorers.dart';
import 'package:sca_app/models/goal.dart';
import 'package:sca_app/models/match.dart';

import '../models/competition.dart';
import '../models/player.dart';
import '../models/team.dart';

class DatabaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  addMatch(Match matchData) async {
    await _ref.child("users/vematosevic/matches/${matchData.uuid}").set(matchData.toMap());
  }
  
  updateMatch(Match match) async {
    await _ref.child("users/vematosevic/matches/${match.uuid}").update(match.toMap());
  }
  
  Future<List<Match>> getMatchesByCompetition(int competition) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").orderByChild("round").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("competition").value == competition)  {
          try{
            var json = jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            matches.add(Match.fromMap(json));
          } catch(e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return matches;
    });
  }
  
  addTeam(Team team) async {
    await _ref.child("users/vematosevic/teams/${team.name}").set(team.toMap());
  }

  Future<List<Team>> getTeamsByCompetition(int competitionID) async {
    List<Team> team = List.empty(growable: true);
    Stream<DatabaseEvent> teamsStream = _ref.child("users/vematosevic/teams").orderByChild("name").onValue;
    teamsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("competitionId").value == competitionID){
          try {
            var json =
                jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            team.add(Team.fromMap(json));
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return team;
    });
  }

  Future<Team> getTeamsById(int teamId) async {
    Team team = Team.emptyTeam();
    Stream<DatabaseEvent> teamsStream = _ref.child("users/vematosevic/teams").onValue;
    teamsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("id").value == teamId){
          try {
            var json =
            jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            team = Team.fromMap(json);
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(milliseconds: 300), () {
      return team;
    });
  }

  Future<int> getTeamIdByName(int competitionId, String teamName) async {
    int teamId = 0;
    Stream<DatabaseEvent> teamsStream = _ref.child("users/vematosevic/teams").onValue;
    teamsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("shortName").value.toString() == teamName && child.child("competitionId").value == competitionId){
          try {
            teamId = int.parse(child.child("id").value.toString());
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return teamId;
    });
  }

  Future<List<Match>> getMatchesByTeam(String competition, int teamId) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").orderByChild("date").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("homeTeam").value == teamId || child.child("awayTeam").value == teamId && child.child("competition").value.toString() == competition) {
          try {
            var json =
                jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            matches.add(Match.fromMap(json));
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return matches;
    });
  }

  addGoal(Match match, Goal goal) async {
    await _ref.child("users/vematosevic/goals/${goal.uuid}").set(goal.toMap());
  }

  addPlayer(String team, Player player) async {
    await _ref.child("users/vematosevic/players/${player.name} ${player.lastName}").set(player.toMap());
  }

  Future<List<Player>> getPlayersByTeam(int teamId) async {
    List<Player> players = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/players").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("teamId").value == teamId){
          try {
            var json =
                jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            players.add(Player.fromMap(json));
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(milliseconds: 300), () {
      return players;
    });
  }

  Future<Match> getMatch(int matchId) async {
    Match match = Match.emptyMatch();
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child
            .child("id")
            .value == matchId) {
          try {
            var json = jsonDecode(jsonEncode(child.value))
            as Map<String, dynamic>;
            match = Match.fromMap(json);
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return match;
    });
  }

  Future<int> getScoreByGame(int matchId, int teamId) async {
    int score = 0;
    Stream<DatabaseEvent> goalsStream = _ref.child("users/vematosevic/goals").onValue;
    goalsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("matchId").value == matchId && child.child("teamId").value == teamId) {
          print("score");
          print(score);
          score++;
        }
        // try {
        //   var json =
        //   jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
        //   players.add(Player.fromMap(json));
        // } catch (e) {
        //   print(e);
        // }
      }
    });
    return Future.delayed(const Duration(milliseconds: 300), () {
      return score;
    });
  }

  Future<Competition> getCompetitionByValue(String competitionName) async {
    Competition competition = Competition.emptyCompetition();
    Stream<DatabaseEvent> competitionStream = _ref.child("users/vematosevic/competitions/$competitionName").onValue;
    competitionStream.listen((DatabaseEvent event) {
      print(event.snapshot.value);
      try {
        var json =
        jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        competition = Competition.fromMap(json);
      } catch (e) {
        print(e);
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return competition;
    });
  }

  addCompetition(Competition competition) async {
    await _ref.child("users/vematosevic/competitions/${competition.name}").set(competition.toMap());
  }

}

