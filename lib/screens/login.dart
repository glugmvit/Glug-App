import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Image(
            image: AssetImage("assets/images/glug_logo.png"),
            height: screenHeight*0.2,
          ),

          Padding(
            padding: EdgeInsets.only(top:10,left: 20,right: 20),
            child: Center(
              child: Text(
                "In real open source, you have the right to control your own destiny.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:10,left: 20,right: 20),
            child: Center(
              child: Text(
                "- LINUS TORVALDS",
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          
        ],
      )
    );
  }
}