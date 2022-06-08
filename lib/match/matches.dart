import 'package:flutter/material.dart';
import 'package:sca_app/match/create_new_match.dart';
import 'package:sca_app/router/router.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Matches"),
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
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              navigateTo(context, Pages.createNewMatch);
            },
            child: const Icon(
                Icons.add
            ),
          ),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }
}
