import 'package:flutter/material.dart';

class LeadingIcons extends StatelessWidget {
  const LeadingIcons({Key? key, this.callback}) : super(key: key);

  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            if(callback != null) {
              callback!();
            } else {
              Navigator.pop(context);
            }

          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        );
      },
    );
  }
}
