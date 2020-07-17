import 'package:flutter/material.dart';
import 'package:glugapp/screens/login.dart';
import 'package:rive/rive.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:custom_splash/custom_splash.dart';
import 'dart:async';
import 'package:glugapp/screens/UserScreen.dart';
import 'package:flare_flutter/flare_actor.dart';


void main() {

    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/WelcomeScreen': (BuildContext context) => new LoginPage(),
      },
    ));
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;
  String _animationName="walk";

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async{

    user = await auth.currentUser();

    if(user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserScreen()));
    }
    else {
      Navigator.of(context).pushReplacementNamed('/WelcomeScreen');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          child:Column(
            children:<Widget>[
              Expanded(

                child:FlareActor(
                    "assets/animations/splash_cool.flr",
                    alignment:Alignment.center,
                    fit:BoxFit.contain,
                    animation:_animationName,
                )
              )
            ]
          )
        )
      )
    );
  }
}







