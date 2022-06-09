import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/widget/input_text_form_field.dart';
import 'package:sca_app/widget/styled_layout.dart';

import '../router/router.dart';

class NewCompetition extends StatefulWidget {
  const NewCompetition({Key? key}) : super(key: key);

  @override
  State<NewCompetition> createState() => _NewCompetitionState();
}

class _NewCompetitionState extends State<NewCompetition> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('users/vematosevic/competitions');

    return StyledLayout(
      appBarTitle: 'Create new competition',
      actions: [
        const SizedBox(width: 10,),
        GestureDetector(
          onTap: () {
            _testRef.child(myController.text).set("");
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
              Expanded(
                child: InputTextFormField(
                  controller: myController,
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
