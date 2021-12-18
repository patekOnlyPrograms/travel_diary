import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Column(
        children: const <Widget>[
          Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your Email Address'
            ),
          ),
        ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Password' 
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your First Name'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Last Name'
              ),
            ),
          ),
          //BIRTHDAY SELECTOR HERE
          //https://pub.dev/packages/syncfusion_flutter_datepicker/install
        ],
      ),
    );
  }
}