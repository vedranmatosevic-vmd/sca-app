import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/widget/input_text_form_field.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../models/team.dart';
import '../services/database_service.dart';

class NewTeam extends StatefulWidget {
  const NewTeam({Key? key}) : super(key: key);

  @override
  State<NewTeam> createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
  late Team newTeam = Team.emptyTeam();

  final _nameTEC = TextEditingController();
  final _shortNameTEC = TextEditingController();
  final _emailTEC = TextEditingController();
  final _contactPersonTEC = TextEditingController();
  final _phoneTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return StyledLayout(
      appBarTitle: "Add a new team",
      actions: <Widget>[
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () async {
              DatabaseService service = DatabaseService();
              newTeam = Team(name: _nameTEC.text, shortName: _shortNameTEC.text, email: _emailTEC.text, contactPerson: _contactPersonTEC.text, phone: _phoneTEC.text);
              service.addTeam(selectedLeague, newTeam);
              Navigator.pop(context);
            },
            child: const Icon(Icons.save)
        ),
        const SizedBox(
          width: 10,
        )
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New team header
          _newTeamHeader(),
          // Team name TextFormField
          InputTextFormField(controller: _nameTEC, value: 'Team name'),
          // Short team name
          InputTextFormField(controller: _shortNameTEC, value: 'Short team name'),
          // Team email
          InputTextFormField(controller: _emailTEC, value: 'Email'),
          // Contact person
          InputTextFormField(controller: _contactPersonTEC, value: 'Contact person'),
          // Phone number
          InputTextFormField(controller: _phoneTEC, value: 'Phone number', isPhoneNumber: true),
        ],
      ),
    );
  }
}

/// New team header - upload photo of team
Container _newTeamHeader() {
  return Container(
    decoration: const BoxDecoration(
      color: CustomColors.greyBack
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(
              color: CustomColors.buttonGrey, shape: BoxShape.circle
          ),
          child: const Center(
            child: Text(
              'NT',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 42,
                  fontWeight:
                  FontWeight.bold,
                  color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}