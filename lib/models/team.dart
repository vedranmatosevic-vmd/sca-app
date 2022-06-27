import 'dart:convert';

import 'package:sca_app/models/player.dart';

class Team {
  late String name;
  late String shortName;
  late String? email;
  late String? contactPerson;
  late String? phone;
  late List<Player>? players;

  Team.emptyTeam();

  Team(
      {required this.name,
      required this.shortName,
      this.email,
      this.contactPerson,
      this.phone,
      this.players
      });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['shortName'] = shortName;
    data['email'] = email;
    data['contactPerson'] = contactPerson;
    data['phone'] = phone;
    if (players != null) {
      data['players'] = players!.map((v) => v.toMap());
    }
    return data;
  }

  Team.fromMap(Map<String, dynamic> teamMap) {
    name = teamMap["name"];
    shortName = teamMap["shortName"];
    email = teamMap["email"];
    contactPerson = teamMap["contactPerson"];
    phone = teamMap["phone"];

    if (teamMap['players'] != null) {
      players = <Player>[];
      Map<String, dynamic> parsedList = jsonDecode(jsonEncode(teamMap["players"]));
      parsedList.forEach((key, value) {
        players?.add(Player.fromMap(value));
      });
    }
  }
}
