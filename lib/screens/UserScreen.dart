

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Functions/google_sign_in.dart';

// class UserScreen extends StatelessWidget {
  



class UserScreen extends StatefulWidget {
  UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome $name"
            ),
          ),

          RaisedButton(
            onPressed: () {
              signOutGoogle();
            },
            child: Text("Sign Out"),
          )
        ],
      )
    );
  }
  void signOutGoogle() async{
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pop(context);
    });
  }
}