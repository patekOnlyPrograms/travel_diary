import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registration Page'),
        ),
        body: registerPageForm(),
      ),
    );
  }
}

class registerPageForm extends StatefulWidget {

  @override
  _registerPageForm createState() => _registerPageForm();
}

class _registerPageForm extends State<registerPageForm> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _registerFormKey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter a Username'
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter a Username';
                    }
                    return null;
                  },
                ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter your First Name'
                  ),
                  validator: (value){
                    if(value == null|| value.isEmpty){
                      return 'Please enter your First Name';
                    }
                    return null;
                  },
                ),
            ),
          ],
        )
    );
  }
}



