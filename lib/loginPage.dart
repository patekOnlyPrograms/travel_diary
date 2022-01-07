// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:travel_diary/mapAndMainScreen.dart';
import 'package:travel_diary/registerPage.dart';

//rewriting to allow verfication
//uses keys to keep track of the state and verification
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //create a boolean for obsureText because stupid TEXTFIELDFORM DOESN'T FUCKING HAVE OBSURE TEXT :(
  
  bool obsureFuckingText = true;
  //creating a key to allow validation and is created globably
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email address',
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter some text';
                }
                return null;
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter some text';
                }
                return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate() && _formKey.currentState!.validate()){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) =>  MainScreen())
                    );
                  }
                }, 
                // ignore: prefer_const_constructors
                child: Text('Submit'),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => registerPage()
                      ),
                    );
                  },
                  child: Text('Register'),
                )
            ),
        ],
      )
    );
  }
}