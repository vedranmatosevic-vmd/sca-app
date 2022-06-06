import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/widget/input_text_form_field.dart';

class NewTeam extends StatefulWidget {
  const NewTeam({Key? key}) : super(key: key);

  @override
  State<NewTeam> createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add a new team"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            );
          },
        ),
        actions: const [
          SizedBox(
            width: 10,
          ),
          Icon(Icons.save),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New team header
          _newTeamHeader(),
          // Team name TextFormField
          const InputTextFormField(value: 'Team name'),
          // Short team name
          const InputTextFormField(value: 'Short team name'),
          // Team email
          const InputTextFormField(value: 'Email'),
          // Contact person
          const InputTextFormField(value: 'Contact person'),
          // Phone number
          const InputTextFormField(value: 'Phone number', isPhoneNumber: true),
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
              color: Colors.deepOrangeAccent, shape: BoxShape.circle
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