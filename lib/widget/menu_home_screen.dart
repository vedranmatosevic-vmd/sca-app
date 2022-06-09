import 'package:flutter/material.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/widget/button_content_home.dart';

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
                      color: Colors.black,
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
              HomeContentButton(
                value: 'Add Team',
                icon: Icons.group,
                page: Pages.newTeam,
              ),
              HomeContentButton(
                value: 'Add League',
                icon: Icons.person,
                page: Pages.newLeague,
              ),
              HomeContentButton(
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
