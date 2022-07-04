import 'package:flutter/material.dart';
import 'package:sca_app/common/style.dart';

class StyledLayout extends StatefulWidget {
  const StyledLayout({
    Key? key,
    required this.appBarTitle,
    this.backgroundColor = Colors.white,
    this.actions,
    this.body,
    this.willPop = true,
    this.drawer,
    this.leading
  }) : super(key: key);

  final Color? backgroundColor;
  final String appBarTitle;
  final List<Widget>? actions;
  final Widget? body;
  final bool willPop;
  final Widget? drawer;
  final Widget? leading;

  @override
  State<StyledLayout> createState() => _StyledLayoutState();
}

class _StyledLayoutState extends State<StyledLayout> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.willPop ? () async => true : () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.backgroundColor,
        appBar: _appBar(widget.appBarTitle, widget.actions, willPop: widget.willPop, leading: widget.leading),
        body: widget.body,
        drawer: widget.drawer,
      ),
    );
  }
}

AppBar _appBar(String appBarTitle, List<Widget>? actions, {bool? willPop = true, Widget? leading}) {
  return AppBar(
      backgroundColor: Style.colorRed,
      foregroundColor: Colors.white,
      title: Text(appBarTitle),
      leading: willPop! ? leading : null,
      actions: actions,
  );
}
