import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/selected_competition.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/widget/input_text_form_field.dart';

class NewTeam extends StatefulWidget {
  const NewTeam({Key? key}) : super(key: key);


  @override
  State<NewTeam> createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
  final _nameTEC = TextEditingController();
  final _shortNameTEC = TextEditingController();
  final _emailTEC = TextEditingController();
  final _contactPersonTEC = TextEditingController();
  final _phoneTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('users/vematosevic/competitions/$selectedLeague');

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        actions: <Widget>[
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              _testRef.child(_nameTEC.text).child('name').set(_nameTEC.text);
              _testRef.child(_nameTEC.text).child('shortName').set(_shortNameTEC.text);
              _testRef.child(_nameTEC.text).child('email').set(_emailTEC.text);
              _testRef.child(_nameTEC.text).child('contactPerson').set(_contactPersonTEC.text);
              _testRef.child(_nameTEC.text).child('phone').set(_phoneTEC.text);
            },
              child: const Icon(Icons.save)
          ),
          const SizedBox(
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