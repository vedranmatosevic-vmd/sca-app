import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';

class NewMatch extends StatefulWidget {
  const NewMatch({
    Key? key,
    required this.homeTeam,
    required this.awayTeam,
    required this.round
  }) : super(key: key);

  final String homeTeam;
  final String awayTeam;
  final String round;

  @override
  State<NewMatch> createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new match"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {Navigator.pop(context);},
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
          _newMatchHeader(widget.homeTeam, widget.awayTeam, widget.round)
        ],
      ),
    );
  }
}

/// New team header - upload photo of team
Container _newMatchHeader(String homeTeam, String awayTeam, String round) {
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
        const Text(
          'Jun 3, 2022 at 11:00 - 30 min',
          style: TextStyle(
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
                homeTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
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
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                awayTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
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
              'Futsalito, $round' 'st round',
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
