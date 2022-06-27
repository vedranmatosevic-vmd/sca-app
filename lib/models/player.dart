import 'package:flutter/material.dart';

class Player {
  late int uuid = UniqueKey().hashCode;
  late String name;
  late String lastName;
  late String? birthDate;
  late String? shirtNumber = "";
  late int teamId;

  Player.emptyPlayer();

  Player({required this.name, required this.lastName, required this.birthDate, required this.teamId, this.shirtNumber});
  // Player({required this.name, required this.lastName, required this.birthDate});

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'name': name,
      'lastName': lastName,
      'birthDate': birthDate,
      'shirtNumber': shirtNumber,
      'teamId': teamId
    };
  }

  Player.fromMap(Map<String, dynamic> playerMap)
      : uuid = playerMap["id"] as int,
        name = playerMap["name"] as String,
        lastName = playerMap["lastName"] as String,
        birthDate = playerMap["birthDate"] as String,
        shirtNumber = playerMap["shirtNumber"] as String,
        teamId = playerMap["teamId"];

}