import 'package:flutter/material.dart';
import 'package:glugapp/Functions/facebook_signin.dart';
import 'package:glugapp/Widgets/social_button.dart';
import 'package:glugapp/screens/email_signin.dart';
import 'package:glugapp/Functions/google_sign_in.dart';
import 'UserScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      if(value != null) {
        print("hrllo");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
      }
    });
  }

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
            padding: EdgeInsets.only(top:10,left: 20,right: 20,bottom: screenHeight*0.1),
            child: Center(
              child: Text(
                "- LINUS TORVALDS",
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),

          SocialButton(
            screenWidth: MediaQuery.of(context).size.width,
            image: Image(
              image: AssetImage("assets/images/google.png"),
              height: 30,
            ),
            function: () {
              signInWithGoogle().whenComplete(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
              });
            },
            text: Text(
              "Sign Up with Google",
              style:TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold

              )
            ),
          ),

          SocialButton(
            screenWidth: MediaQuery.of(context).size.width,
            image: Image(
              image: AssetImage("assets/images/fb.png"),
              height: 30,
            ),
            function: () {
              initiateFacebookLogin();
              setState(() {
                
              });
            },
            text: Text(
              "Sign Up with Facebook",
              style:TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold

              )
            ),
          ),

          SocialButton(
            screenWidth: MediaQuery.of(context).size.width,
            image: Image(
              image: AssetImage("assets/images/github.png"),
              height: 30,
            ),
            function: () {
              
            },
            text: Text(
              "Sign Up with GitHub",
              style:TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold

              )
            ),
          ),

          SocialButton(
            screenWidth: MediaQuery.of(context).size.width,
            image: Image(
              image: AssetImage("assets/images/email.png"),
              height: 30,
            ),
            function: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
            },
            text: Text(
              "Sign Up with Email",
              style:TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold

              )
            ),
          ),
        ],
      )
    );
  }
}