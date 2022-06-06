import 'package:flutter/material.dart';
import 'package:sca_app/router/router.dart';

class HomeContentButton extends StatelessWidget {
  const HomeContentButton({Key? key, required this.value, required this.page}) : super(key: key);

  final String value;
  final Pages page;

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
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              navigateTo(context, page);
            },
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
