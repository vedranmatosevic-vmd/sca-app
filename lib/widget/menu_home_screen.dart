import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/squared_button.dart';

class MenuCardHomeScreen extends StatelessWidget {
  const MenuCardHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Content",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SquaredButton(
                value: 'Add Team',
                icon: Icons.group,
                page: Pages.newTeam,
              ),
              SquaredButton(
                value: 'Add League',
                icon: Icons.person,
                page: Pages.newLeague,
              ),
              SquaredButton(
                value: 'Add Match',
                icon: Icons.sports_soccer,
                page: Pages.createNewMatch,
              ),
            ],
          )
        ],
      ),
    );
  }
}
