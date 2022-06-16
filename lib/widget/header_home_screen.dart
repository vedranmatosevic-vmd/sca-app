import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';

class HeaderCardHomeScreen extends StatefulWidget {
  const HeaderCardHomeScreen({Key? key}) : super(key: key);

  @override
  State<HeaderCardHomeScreen> createState() => _HeaderCardHomeScreenState();
}

class _HeaderCardHomeScreenState extends State<HeaderCardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: CustomColors.grey,
      ),
      child: const Center(
        child: Icon(
          Icons.sports_soccer,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
