import 'package:flutter/material.dart';
import 'package:travel_diary/mapAndMainScreen.dart';

class dynamicList extends StatefulWidget {
  const dynamicList({Key? key}) : super(key: key);

  @override
  _dynamicListState createState() => _dynamicListState();
}


//make a FIFO data structure where we will store all places visited
//every 30 seconds to 1 minute

class _dynamicListState extends State<dynamicList>
    with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: SafeArea(
        child: Text("List"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
