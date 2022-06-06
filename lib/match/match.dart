import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match"),
        leading: Icon(Icons.arrow_back),
        actions: [
          Icon(
            Icons.edit
          ),
          SizedBox(width: 10,),
          Icon(
            Icons.save
          ),
          SizedBox(width: 10,),
          Icon(
              Icons.add_box
          ),
          SizedBox(width: 10,)
          
        ],
      ),
    );
  }
}
