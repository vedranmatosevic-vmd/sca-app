import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/router/router.dart';

class NewMatch extends StatefulWidget {
  const NewMatch({
    Key? key,
    required this.match
  }) : super(key: key);

  final Match match;

  @override
  State<NewMatch> createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match details"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              // onPressed: () {navigateTo(context, Pages.home, title: selectedLeague);},
              onPressed: () {navigateTo(context, Pages.home);},
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
        children: <Widget>[
          _newMatchHeader(widget.match)
        ],
      ),
    );
  }
}

/// New team header - upload photo of team on click placeholder
Container _newMatchHeader(Match match) {
  return Container(
    height: 130,
    padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: const BoxDecoration(
        color: Colors.black87
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${match.date} at ${match.time} - ${match.duration} min',
          style: const TextStyle(
            color: CustomColors.textGreyLight,
            fontSize: 14
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                match.homeTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '0 - 0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                match.awayTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Futsalito, ${match.round}' 'st round',
              style: const TextStyle(
                  color: CustomColors.textGreyLight,
                  fontSize: 14
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
