import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/match/scorers.dart';
import 'package:sca_app/models/goal.dart';
import 'package:sca_app/models/match.dart';

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

  // getTeams(String competition) async {
  //   Stream<DatabaseEvent> playersStream = _ref.child("users/vematosevic/competitions").onValue;
  //   playersStream.listen((DatabaseEvent event) {
  //     for (final child in event.snapshot.children) {
  //       for (final team in child.children) {
  //         for (final player in team.child("players").children) {
  //           updatePlayer(competition, team.child("name").value.toString(), player.child("id").value.toString());
  //         }
  //       }
  //     }
  //   });
  // }
  //
  // updatePlayer(String competition, String team, String playerId) async {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     _ref.child("users/vematosevic/competitions/$competition/$team/players/$playerId/shirtNumber").set("");
  //   });
  // }
  
  Future<List<Match>> getMatchesByCompetition(String competition) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").orderByChild("round").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("competition").value.toString() == competition)  {
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
  
  addTeam(String competition, Team team) async {
    await _ref.child("users/vematosevic/competitions/$competition/${team.name}").set(team.toMap());
  }

  Future<List<Team>> getTeamsByCompetition(String competition) async {
    List<Team> team = List.empty(growable: true);
    Stream<DatabaseEvent> teamsStream = _ref.child("users/vematosevic/competitions/$competition").orderByChild("name").onValue;
    teamsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        try{
          var json = jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
          team.add(Team.fromMap(json));
        } catch(e) {
          print(e);
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return team;
    });
  }

  Future<List<Match>> getMatchesByTeam(String competition, String team) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("homeTeam").value.toString() == team || child.child("awayTeam").value.toString() == team && child.child("competition").value.toString() == competition) {
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
    await _ref.child("users/vematosevic/matches/${match.uuid}/goals/${goal.uuid}").set(goal.toMap());
  }

  addPlayer(String competition, String team, Player player) async {
    await _ref.child("users/vematosevic/competitions/$competition/$team/players/${player.uuid}").set(player.toMap());
  }

  Future<List<Player>> getPlayersByTeam(String competition, String team) async {
    List<Player> players = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/competitions/$competition/$team/players").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        try {
          var json =
          jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
          players.add(Player.fromMap(json));
        } catch (e) {
          print(e);
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return players;
    });
  }

  Future<List<Team>> getTeamsByMatch(String competition, Match match) async {
    List<Team> teams = List.empty(growable: true);
    Stream<DatabaseEvent> teamsStream = _ref.child("users/vematosevic/competitions/$competition").onValue;
    teamsStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("shortName").value.toString() == match.homeTeam.toString() || child.child("shortName").value.toString() == match.awayTeam.toString()) {
          try {
            var json = jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            teams.add(Team.fromMap(json));
          } catch (e) {
            print(e);
          }
        }
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return teams;
    });
  }

  Future<Match> getMatch(String matchId) async {
    Match match = Match.emptyMatch();
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches/$matchId").onValue;
    matchesStream.listen((DatabaseEvent event) {
      try {
        var json = jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        match = Match.fromMap(json);
      } catch (e) {
        print(e);
      }
    });
    return Future.delayed(const Duration(seconds: 1), () {
      return match;
    });
  }

}

