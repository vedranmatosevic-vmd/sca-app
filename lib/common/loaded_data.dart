import 'package:firebase_database/firebase_database.dart';

String selectedLeague = "";
String username = "";

List<String> competitionsByUser = [];

List<String> teamsByCompetitions = [];

void getTeamsByCompetitions(String name) {
  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref().child('users/vematosevic/competitions');

  Stream<DatabaseEvent> competitionsStream = databaseRef.child(name).onValue;

  competitionsStream.listen((DatabaseEvent event) {
    for (final child in event.snapshot.children) {
      print("child: $child");
      teamsByCompetitions.add(child.key!);
    }
  });
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

