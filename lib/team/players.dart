import 'package:flutter/material.dart';

import '../common/style.dart';
import '../models/team.dart';

class Players extends StatelessWidget {
  const Players({Key? key, required this.team}) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        GestureDetector(
          onTap: () {},
          child: Container(
            width: 200,
            height: 24,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Style.getColor(context, StyleColor.red),
            ),
            child: Center(
              child: Text(
                'ADD PLAYER',
                style: Style.getTextStyle(context, StyleText.smallTextBold, StyleColor.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
