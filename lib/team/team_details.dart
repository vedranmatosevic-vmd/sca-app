import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/team/players.dart';
import 'package:sca_app/team/teams.dart';
import 'package:sca_app/widget/leading_icons.dart';
import 'package:sca_app/widget/styled_layout.dart';
import 'package:sca_app/models/match.dart';

import '../common/style.dart';
import '../models/team.dart';
import '../router/router.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  late final Team team;
  DatabaseService service = DatabaseService();

  // updateShirtNumbers() async {
  //   await service.addShirtNumbers(selectedLeague, team.name);
  // }

  // getTeams(Team team) async {
  //   await service.getTeams(selectedLeague, team.name);
  // }

  @override
  void initState() {


    team = widget.team;

    // getTeams(team);
    // updateShirtNumbers();
    currentPage = Pages.teamDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StyledLayout(
      appBarTitle: "Team details",
      leading: LeadingIcons(callback: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Teams()), (route) => false);
      },),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _header(context, team),
          _tabController(context, team)
        ],
      ),
    );
  }
}

_tabController(BuildContext context, Team team) {
  return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Style.getColor(context, StyleColor.white),
                border: Border(
                    bottom: BorderSide(
                        color: Style.getColor(context, StyleColor.grey)
                    )
                )
            ),
            child: TabBar(
              indicator: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Style.getColor(context, StyleColor.red),
                        width: 3,
                      )
                  )
              ),
              labelColor: Style.getColor(context, StyleColor.red),
              unselectedLabelColor: Colors.black,
              labelStyle: Style.getTextStyle(context, StyleText.tabTextRegular),
              tabs: <Widget>[
                Tab(
                  text: 'Rezultati'.toUpperCase(),
                ),
                Tab(
                  text: 'Momčad'.toUpperCase(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 450,
            child: Row(
              children: [
                Expanded(
                    child: TabBarView(
                      children: [
                        _results(context, team),
                        Players(team: team),
                      ],
                    )),
              ],
            ),
          )
        ],
      ));
}

_header(BuildContext context, Team team) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
        color: Style.getColor(context, StyleColor.grey)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              selectedLeague,
              style: Style.getTextStyle(context, StyleText.subTitle),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _imagePlaceHolder(context, team.shortName[0]),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top:  0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team.name,
                        style: Style.getTextStyle(
                            context, StyleText.bigTextBold, StyleColor.black),
                      ),
                      const SizedBox(height: 6,),
                      Row(
                        children: <Widget>[
                          Text(
                              "Contact person: ",
                            style: Style.getTextStyle(context, StyleText.smallTextRegular),
                          ),
                          Text(
                            team.contactPerson!,
                            style: Style.getTextStyle(context, StyleText.smallTextBold),
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: <Widget>[
                          Text(
                            "Email: ",
                            style: Style.getTextStyle(context, StyleText.smallTextRegular),
                          ),
                          Text(
                            team.email!,
                            style: Style.getTextStyle(context, StyleText.smallTextBold),
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: <Widget>[
                          Text(
                            "Phone: ",
                            style: Style.getTextStyle(context, StyleText.smallTextRegular),
                          ),
                          Text(
                            team.phone!,
                            style: Style.getTextStyle(context, StyleText.smallTextBold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}

_imagePlaceHolder(BuildContext context, String title) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Style.getColor(context, StyleColor.white),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Center(
      child: Text(
        title,
        style:
        Style.getTextStyle(context, StyleText.bigTextBold, StyleColor.red),
      ),
    ),
  );
}

_results(BuildContext context, Team team) {
  DatabaseService service = DatabaseService();
  return FutureBuilder<List<Match>>(
      future: service.getMatchesByTeam(selectedLeague, team.shortName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Style.colorRed,
            ),
          );
        }
        if (snapshot.hasData) {
          return _listOfResults(context, snapshot.data!, team);
        }
        return const Text('Something went wrong');
      }
  );
}

_listOfResults(BuildContext context, List<Match> listOfMatches, Team team) {
  return ListView(
    children: _listOfMatches(context, listOfMatches, team),
  );
}

_listOfMatches(BuildContext context, List<Match> listOfMatches, Team team) {
  List<Widget> widgets = [];
  for (final match in listOfMatches) {
    widgets.add(_resultMatchCard(context, match, team));
  }
  return widgets;
}

_resultMatchCard(BuildContext context, Match match, Team team) {
  return GestureDetector(
      onTap: () {
        pagesFromToMD = Pages.teamDetails;
        navigateTo(context, Pages.matchDetails, match: match, team: team);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Style.getColor(context, StyleColor.grey)
            )
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              match.date.substring(0, 6),
              style: Style.getTextStyle(context, StyleText.smallTextBold),
            ),
            const SizedBox(width: 10,),
            _boldWinner(context, team, match),
            const Spacer(),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        "home",
                        // match.homeScore.toString(),
                      style: Style.getTextStyle(context, StyleText.textBold),
                    ),
                  ],
                ),
                const SizedBox(height: 2,),
                Row(
                  children: <Widget>[
                    Text(
                        "away",
                        // match.awayScore.toString(),
                      style: Style.getTextStyle(context, StyleText.textBold),
                    ),
                  ],
                )
              ],
            ),
            _calculateScore(context, team, match)
          ],
        ),
      )
  );
}

_boldWinner(BuildContext context, Team team, Match match) {
  bool isHomeWin = false;
  bool isAwayWin = false;
  // if (match.homeScore > match.awayScore) {
  //   isHomeWin = true;
  // }
  // if (match.awayScore > match.homeScore) {
  //   isAwayWin = true;
  // }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            match.homeTeam,
            style: isHomeWin ? Style.getTextStyle(context, StyleText.textBold) : Style.getTextStyle(context, StyleText.textRegular),
          ),
        ],
      ),
      const SizedBox(height: 2,),
      Row(
        children: <Widget>[
          Text(
            match.awayTeam,
            style: isAwayWin ? Style.getTextStyle(context, StyleText.textBold) : Style.getTextStyle(context, StyleText.textRegular),
          ),
        ],
      )
    ],
  );
}

enum ScoreResult {
  win,
  draw,
  lose
}

_calculateScore(BuildContext context, Team team, Match match) {
  Color backColor = Style.getColor(context, StyleColor.orange);
  String sign = "";
  // if (match.homeTeam.toString() == team.shortName && match.homeScore < match.awayScore) {
  //   backColor = Style.getColor(context, StyleColor.red);
  //   sign = "I";
  // } else if (match.homeTeam.toString() == team.shortName && match.homeScore > match.awayScore) {
  //   backColor = Style.getColor(context, StyleColor.green);
  //   sign = "P";
  // } else if (match.awayTeam.toString() == team.shortName && match.homeScore < match.awayScore) {
  //   backColor = Style.getColor(context, StyleColor.green);
  //   sign = "P";
  // } else if (match.awayTeam.toString() == team.shortName && match.homeScore > match.awayScore) {
  //   backColor = Style.getColor(context, StyleColor.red);
  //   sign = "I";
  // } else {
  //   backColor = Style.getColor(context, StyleColor.orange);
  //   sign = "N";
  // }

  return Container(
    margin: const EdgeInsets.only(left: 20),
    width: 20,
    height: 20 ,
    decoration: BoxDecoration(
      color: backColor,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: Center(
      child: Text(
        sign,
        style: Style.getTextStyle(context, StyleText.tabTextRegular, StyleColor.white),
      ),
    ),
  );
}
