import 'package:flutter/material.dart';
import 'package:travel_diary/mapAndMainScreen.dart';
import 'registerPage.dart';

class loginButtons extends StatefulWidget {
  const loginButtons({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _login_ButtonsState();
  }
}

class _login_ButtonsState extends State<loginButtons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => registerPage())
                );
            }, 
            child: const Text('Register')
            ),
        ],
      ),
    );
  }
}