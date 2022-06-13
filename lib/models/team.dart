class Team {
  late String name;
  late String shortName;
  late String? email;
  late String? contactPerson;
  late String? phone;

  Team.emptyTeam();

  Team({required this.name, required this.shortName, this.email, this.contactPerson, this.phone});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortName': shortName,
      'email': email,
      'contactPerson': contactPerson,
      'phone': phone,
    };
  }

  Team.fromMap(Map<String, dynamic> teamMap)
      : name = teamMap["name"],
        shortName = teamMap["shortName"],
        email = teamMap["email"],
        contactPerson = teamMap["contactPerson"],
        phone = teamMap["phone"];
}