import 'package:flutter/material.dart';

class dynamicList extends StatefulWidget {
  const dynamicList({Key? key}) : super(key: key);

  @override
  _dynamicListState createState() => _dynamicListState();
}

class _dynamicListState extends State<dynamicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text("location1"),
          Text("location2"),
          Text("location2")
        ],
      ),
    );
  }
}
