import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/match/new_match.dart';
import 'package:sca_app/team/new_team.dart';

void navigateTo(BuildContext context, Pages page) {
  if (page == Pages.newMatch) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('New match'),
            children: <Widget>[
              SimpleDialogOption(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Text('Home: '),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        HomeTeamsDropDown(items: teams,)
                      ],
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                child: Column(
                  children: [
                    Row(
                      children: const [Text('Away: ')],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        AwayTeamsDropDown(items: teams,)
                      ],
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        const Text('Round: '),
                        const SizedBox(width: 10,),
                        RoundDropDown(items: rounds,)
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewMatch(homeTeam: homeDropDownValue, awayTeam: awayDropDownValue, round: roundDropDownValue,))
                  );
                },
                child: const SimpleDialogOption(
                  child: Text(
                    'Create',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: CustomColors.primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  } else if (page == Pages.newPlayer) {
  } else if (page == Pages.newTeam) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTeam()));
  }
}

enum Pages { home, teams, newTeam, player, newPlayer, newMatch }

List<String> teams = [
  'FŠ Zagi',
  'MNK Gimka',
  'Gimka Malešnica',
  'Gimka Keglić',
  'Futsal Dinamo'
];

List<String> rounds = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8'
];

late String homeDropDownValue;
late String awayDropDownValue;
late String roundDropDownValue;


class HomeTeamsDropDown extends StatefulWidget {
  const HomeTeamsDropDown({Key? key, required this.items}) : super(key: key);

  final List<String> items;

  @override
  State<HomeTeamsDropDown> createState() => _HomeTeamsDropDownState();
}

class _HomeTeamsDropDownState extends State<HomeTeamsDropDown> {


  @override
  void initState() {
    super.initState();
    homeDropDownValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: homeDropDownValue,
      items: widget.items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          homeDropDownValue = newValue!;
        });
      }
    );
  }
}

class AwayTeamsDropDown extends StatefulWidget {
  const AwayTeamsDropDown({Key? key, required this.items}) : super(key: key);

  final List<String> items;

  @override
  State<AwayTeamsDropDown> createState() => _AwayTeamsDropDownState();
}

class _AwayTeamsDropDownState extends State<AwayTeamsDropDown> {


  @override
  void initState() {
    super.initState();
    awayDropDownValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: awayDropDownValue,
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            awayDropDownValue = newValue!;
          });
        }
    );
  }
}

class RoundDropDown extends StatefulWidget {
  const RoundDropDown({Key? key, required this.items}) : super(key: key);

  final List<String> items;

  @override
  State<RoundDropDown> createState() => _RoundDropDownState();
}

class _RoundDropDownState extends State<RoundDropDown> {


  @override
  void initState() {
    super.initState();
    roundDropDownValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: roundDropDownValue,
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            roundDropDownValue = newValue!;
          });
        }
    );
  }
}


