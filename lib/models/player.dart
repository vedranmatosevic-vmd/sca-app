import 'package:flutter/material.dart';

class Player {
  late int uuid = UniqueKey().hashCode;
  late String name;
  late String lastName;
  late DateTime dateOfBirth;

  Player.emptyTeam();

  Player({required this.name, required this.lastName, required this.dateOfBirth});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'email': dateOfBirth
    };
  }

  Player.fromMap(Map<String, dynamic> playerMap)
      : name = playerMap["name"],
        lastName = playerMap["lastName"],
        dateOfBirth = playerMap["dateOfBirth"];
}