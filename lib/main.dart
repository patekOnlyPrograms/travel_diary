// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Travel Diary'),
        ),
        body: Column(
          children: [
            LoginPage(),
        ],
        ),
      ),
    );
  }
}

