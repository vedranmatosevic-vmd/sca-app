import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/models/player.dart';
import 'package:sca_app/widget/input_text_form_field.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../models/team.dart';
import '../services/database_service.dart';

final _nameTEC = TextEditingController();
final _lastNameTEC = TextEditingController();
final _birthDateTEC = TextEditingController();

class NewPlayer extends StatelessWidget {
  const NewPlayer({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {

    return StyledLayout(
      appBarTitle: "Create new player",
      actions: _action(context, team),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 140,
            color: Style.colorGrey,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Style.colorRed,
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Style.getColor(context, StyleColor.white),
                  )
                ),
              ),
            ),
          ),
          InputTextFormField(controller: _nameTEC, value: "Ime"),
          InputTextFormField(controller: _lastNameTEC, value: "Prezime"),
          InputTextFormField(controller: _birthDateTEC, value: "Datum rođenja"),
        ],
      ),
    );
  }
}

_action(BuildContext context, Team team) {
  return [
    const SizedBox(
      width: 10,
    ),
    GestureDetector(
        onTap: () async {
          DatabaseService service = DatabaseService();
          Player newPlayer = Player(
              name: _nameTEC.text,
              lastName: _lastNameTEC.text,
              birthDate: _birthDateTEC.text
          );
          await service.addPlayer(selectedLeague, team.name.toString(), newPlayer);
          Navigator.pop(context);
          _nameTEC.clear();
          _lastNameTEC.clear();
          _birthDateTEC.clear();
        },
        child: const Icon(Icons.save)),
    const SizedBox(
      width: 10,
    )
  ];
}
