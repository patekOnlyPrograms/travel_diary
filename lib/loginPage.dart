import 'package:flutter/material.dart';

//rewriting to allow verfication
//uses keys to keep track of the state and verification
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate() && _formKey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing'))
                    );
                  }
                }, 
                // ignore: prefer_const_constructors
                child: Text('Submit'),
              ),
            ),
        ],
      )
    );
  }
}