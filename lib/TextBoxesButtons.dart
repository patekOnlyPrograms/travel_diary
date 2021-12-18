import 'package:flutter/material.dart';

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
            onPressed: (){}, 
            child: const Text('Log in'),
            ),
          ElevatedButton(
            onPressed: (){}, 
            child: const Text('Register')
            ),
        ],
      ),
    );
  }
}