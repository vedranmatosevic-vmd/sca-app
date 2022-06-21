import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/models/match.dart';

class SquaredButton extends StatelessWidget {
  const SquaredButton({Key? key, required this.value, required this.icon, required this.page, this.match}) : super(key: key);

  final String value;
  final IconData? icon;
  final Pages page;
  final Match? match;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(1, 1))
                  ]),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(100, 100),
            child: InkWell(
              onTap: () {navigateTo(context, page, match: match);},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 34,
                    color: Style.colorBlack,
                  ),
                  Text(
                      value,
                      style: Style.getTextStyle(context, StyleText.buttonText),
                    ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
