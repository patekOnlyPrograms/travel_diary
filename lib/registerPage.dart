import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mapAndMainScreen.dart';

class registerPage extends StatelessWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registration Page'),
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
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
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter your Last Name'
                ),
                validator: (value){
                  if(value == null|| value.isEmpty){
                    return 'Please enter your Last Name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter your Email'
                ),
                validator: (value){
                  if(value == null|| value.isEmpty){
                    return 'Please enter your Email';
                  }
                  //rewrite the regex
                  if(!RegExp("^([a-z0-9]+(?:[._-][a-z0-9]+)*)@([a-z0-9]+(?:[.-][a-z0-9]+)*\.[a-z]{2,})").hasMatch(value)){
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter your Password'
                ),
                validator: (value){
                  if(value == null|| value.isEmpty){
                    return 'Please enter your Password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: (){
                    if(_registerFormKey.currentState!.validate() &&
                        _registerFormKey.currentState!.validate()){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen())
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
            )
          ],
        )
    );
  }
}