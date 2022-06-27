import 'package:flutter/material.dart';
import 'package:sca_app/models/match.dart';

class EventColumn extends StatelessWidget {
  const EventColumn({Key? key, required this.match}) : super(key: key);


  final Match match;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // _getEventCards(events: match.go)
            ],
          )
      ),
    );
  }
}
