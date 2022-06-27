import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:sca_app/models/competition.dart';

import '../router/router.dart';

Competition selectedLeague = Competition.emptyCompetition();
String username = "";
Pages currentPage = Pages.home;
Pages pagesFromToMD = Pages.matches;

List<Competition> competitionsByUser = [];

List<String> teamsByCompetitions = [];

Future<List<String>> getTeamsByCompetitions(int competitionId) async{
  teamsByCompetitions.clear();

  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref().child('users/vematosevic/teams');

  Stream<DatabaseEvent> competitionsStream = databaseRef.onValue;

  competitionsStream.listen((DatabaseEvent event) {
    for (final child in event.snapshot.children) {
      if (child.child("competitionId").value == competitionId){
        teamsByCompetitions.add(child.child("shortName").value.toString());
      }
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
      competitionsByUser.add(Competition.fromMap(jsonDecode(jsonEncode(child.value))));
    }
  });
}

