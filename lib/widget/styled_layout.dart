import 'package:flutter/material.dart';

class StyledLayout extends StatelessWidget {
  const StyledLayout({
    Key? key,
    required this.appBarTitle,
    this.backgroundColor = Colors.white,
    this.actions,
    this.body,
    this.willPop = true,
  }) : super(key: key);

  final Color? backgroundColor;
  final String appBarTitle;
  final List<Widget>? actions;
  final Widget? body;
  final bool willPop;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop ? () async => true : () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text(appBarTitle),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              );
            },
          ),
          actions: actions
        ),
        body: body,
      ),
    );
  }
}
