import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/models/match.dart';

import '../models/team.dart';

class DatabaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  addMatch(Match matchData) async {
    await _ref.child("users/vematosevic/matches/${matchData.uuid}").set(matchData.toMap());
  }
  
  Future<List<Match>> getMatchesByCompetition() async {
    List<Match> matches = [];
    print("get: ${_ref.child("users/vematosevic/matches").get()}");
    // TODO VEDRAN
    // Stream<DatabaseEvent> matchesStream = _ref.child("users/vematosevic/matches").onValue;
    // matchesStream.listen((DatabaseEvent event) {
    //   for (final child in event.snapshot.children) {
    //     if (child.child("competition").value.toString() == competition) {
    //       print("for petlja: child: ${child.value}");
    //       matches.add(jsonEncode(child.value) as Match);
    //     }
    //   }
    // });
    return matches;
  }
  
  addTeam(String competition, Team team) async {
    await _ref.child("users/vematosevic/competitions/$competition/${team.name}").set(team.toMap());
  }

}

