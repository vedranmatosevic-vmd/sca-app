import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/models/match.dart';

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
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/competitions/$competition").orderByChild("name").onValue;
    matchesStream.listen((DatabaseEvent event) {
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

}

