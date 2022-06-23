import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
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
    return Future.delayed(const Duration(seconds: 2), () {
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
    return Future.delayed(const Duration(seconds: 2), () {
      return team;
    });
  }

  Future<List<Match>> getMatchesByTeam(String team) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("homeTeam").value.toString() == team || child.child("awayTeam").value.toString() == team) {
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
    return Future.delayed(const Duration(seconds: 2), () {
      return matches;
    });
  }

  addGoal(Goal goal) async {
    await _ref.child("users/vematosevic/goals/${goal.uuid}").set(goal.toMap());
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
    return Future.delayed(const Duration(seconds: 2), () {
      return players;
    });
  }

}

