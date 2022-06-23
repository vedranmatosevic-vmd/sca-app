import 'package:flutter/material.dart';

class Player {
  late int uuid = UniqueKey().hashCode;
  late String name;
  late String lastName;
  late String? birthDate;

  Player.emptyPlayer();

  Player({required this.name, required this.lastName, required this.birthDate});

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'name': name,
      'lastName': lastName,
      'birthDate': birthDate
    };
  }

  Player.fromMap(Map<String, dynamic> playerMap)
      : uuid = playerMap["id"] as int,
        name = playerMap["name"] as String,
        lastName = playerMap["lastName"] as String,
        birthDate = playerMap["birthDate"] as String;

}