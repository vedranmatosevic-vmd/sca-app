import 'package:flutter/material.dart';

class StyledLayout extends StatefulWidget {
  const StyledLayout({
    Key? key,
    required this.appBarTitle,
    this.backgroundColor = Colors.white,
    this.actions,
    this.body,
    this.willPop = true,
    this.drawer
  }) : super(key: key);

  final Color? backgroundColor;
  final String appBarTitle;
  final List<Widget>? actions;
  final Widget? body;
  final bool willPop;
  final Widget? drawer;

  @override
  State<StyledLayout> createState() => _StyledLayoutState();
}

class _StyledLayoutState extends State<StyledLayout> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.willPop ? () async => true : () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: widget.backgroundColor,
        appBar: _appBar(widget.appBarTitle, widget.actions, willPop: widget.willPop),
        body: widget.body,
        drawer: widget.drawer,
      ),
    );
  }
}

AppBar _appBar(String appBarTitle, List<Widget>? actions, {bool? willPop = true}) {
  return AppBar(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: Text(appBarTitle),
      leading: willPop! ? Builder(
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
      ) : null,
      actions: actions,
  );
}
