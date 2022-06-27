import 'package:firebase_database/firebase_database.dart';

import '../router/router.dart';

String selectedLeague = "";
String username = "";
Pages currentPage = Pages.home;
Pages pagesFromToMD = Pages.matches;

List<String> competitionsByUser = [];

List<String> teamsByCompetitions = [];

Future<List<String>> getTeamsByCompetitions(String name) async{
  teamsByCompetitions.clear();

  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref().child('users/vematosevic/competitions');

  Stream<DatabaseEvent> competitionsStream = databaseRef.child(name).onValue;

  competitionsStream.listen((DatabaseEvent event) {
    for (final child in event.snapshot.children) {
      teamsByCompetitions.add(child.child("shortName").value.toString());
    }
  });

  return teamsByCompetitions;
}

void updateCompetitionsList() {
  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref().child('users/vematosevic');

  Stream<DatabaseEvent> competitionsStream = databaseRef.child('competitions').onValue;

  competitionsStream.listen((DatabaseEvent event) {
    for (final child in event.snapshot.children) {
      competitionsByUser.add(child.key!);
    }
  });
}

