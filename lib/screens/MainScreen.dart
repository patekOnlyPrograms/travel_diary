import 'package:flutter/material.dart';
import 'package:travel_diary/screens/Settings.dart';
import '../mapAndMainScreen.dart';
import '../widgets/dynamicList.dart';

class homeScreenNavigation extends StatefulWidget {
  const homeScreenNavigation({Key? key}) : super(key: key);

  @override
  _homeScreenNavigationState createState() => _homeScreenNavigationState();
}

class _homeScreenNavigationState extends State<homeScreenNavigation> {

  int pageSelected = 0;

  List<BottomNavigationBarItem> buildBarItems(){
    return[
      const BottomNavigationBarItem(
          label: "Map",
          icon: Icon(Icons.location_pin)
      ),
      const BottomNavigationBarItem(
          label: "List",
          icon: Icon(Icons.list_sharp)
      ),
      const BottomNavigationBarItem(
          label: "Settings",
          icon: Icon(Icons.settings)
      )
    ];
  }

  PageController pageController = PageController(
      initialPage: 0,
      keepPage: true
  );

  Widget buildPageView(){
    return PageView(
      controller: pageController,
      onPageChanged: (index){
        PageChanger(index);
      },
      children: <Widget>[
        googleMapLocation(),
        dynamicList(),
        settingsPage()
      ],
    );
  }

  @override
  void initState(){
    super.initState();
  }

  void PageChanger(int index){
    setState(() {
      pageSelected = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      pageSelected = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageSelected,
        items: buildBarItems(),
        onTap: (index){
          bottomTapped(index);
        },
      ),
    );
  }
}
