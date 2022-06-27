import 'package:flutter/material.dart';

class Competition {
  late int uuid = UniqueKey().hashCode;
  late String name;

  Competition.emptyCompetition();

  Competition({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uuid;
    data['name'] = name;
    return data;
  }

  Competition.fromMap(Map<String, dynamic> competitionMap) {
    uuid = competitionMap["id"];
    name = competitionMap["name"];
  }
}