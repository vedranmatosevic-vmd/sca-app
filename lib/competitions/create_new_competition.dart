import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/models/competition.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/input_text_form_field.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../router/router.dart';

class NewCompetition extends StatefulWidget {
  const NewCompetition({Key? key}) : super(key: key);

  @override
  State<NewCompetition> createState() => _NewCompetitionState();
}

class _NewCompetitionState extends State<NewCompetition> {
  final nameController = TextEditingController();

  DatabaseService service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StyledLayout(
      appBarTitle: 'Create new competition',
      actions: [
        const SizedBox(width: 10,),
        GestureDetector(
          onTap: () async {
            Competition competition = Competition(name: nameController.text);
            await service.addCompetition(competition);
            Navigator.pop(context);
          },
          child: const Icon(
              Icons.save
          ),
        ),
        const SizedBox(width: 10,)
      ],
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: InputTextFormField(
                  controller: nameController,
                  isPhoneNumber: false,
                  padding: const EdgeInsets.all(0),
                  value: 'Name',
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
