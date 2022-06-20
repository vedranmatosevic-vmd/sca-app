import 'package:sca_app/models/player.dart';

class Team {
  late String name;
  late String shortName;
  late String? email;
  late String? contactPerson;
  late String? phone;
  late List<Player>? players = [];

  Team.emptyTeam();

  Team({required this.name, required this.shortName, this.email, this.contactPerson, this.phone, this.players});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortName': shortName,
      'email': email,
      'contactPerson': contactPerson,
      'phone': phone,
      'players': players
    };
  }

  Team.fromMap(Map<String, dynamic> teamMap)
      : name = teamMap["name"],
        shortName = teamMap["shortName"],
        email = teamMap["email"],
        contactPerson = teamMap["contactPerson"],
        phone = teamMap["phone"],
        players = teamMap["players"];
}