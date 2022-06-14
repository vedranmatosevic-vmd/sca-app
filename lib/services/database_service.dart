import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/models/match.dart';

import '../models/team.dart';

class DatabaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  addMatch(Match matchData) async {
    await _ref.child("users/vematosevic/matches/${matchData.uuid}").set(matchData.toMap());
  }
  
  Future<List<Match>> getMatchesByCompetition(String competition) async {
    List<Match> matches = List.empty(growable: true);
    Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").orderByChild("round").onValue;
    matchesStream.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        if (child.child("competition").value.toString() == competition) {
          try{
            var json = jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>;
            matches.add(Match.fromMap(json));
          } catch(e) {
            print(e);
          }
          // matches.add(jsonDecode(child.value.toString()));
          // var match = Match(
          //     competition: child.child("competition").value.toString(),
          //     homeTeam: child.child("homeTeam").value.toString(),
          //     awayTeam: child.child("awayTeam").value.toString(),
          //     date: child.child("date").value.toString(),
          //     time: child.child("time").value.toString(),
          //     duration: int.parse(child.child("duration").value.toString()),
          //     round: int.parse(child.child("round").value.toString()),
          //     awayScore: int.parse(child.child("awayScore").value.toString()),
          //     homeScore: int.parse(child.child("homeScore").value.toString())
          // );
          // matches.add(match);
          // print("Home team: ${match.homeTeam}");
          // print("Duration: ${match.duration}");
        }
      }
    });
    return matches;
  }
  
  addTeam(String competition, Team team) async {
    await _ref.child("users/vematosevic/competitions/$competition/${team.name}").set(team.toMap());
  }

}

