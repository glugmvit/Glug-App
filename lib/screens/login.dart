import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:glugapp/screens/email_signin.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:glugapp/screens/google_sign_in.dart';
import 'UserScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UserScreen.dart';
import 'custom_webview.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String your_client_id = "<YOUR-APP-ID>";
  String your_redirect_url = "<YOUR-REDIRECT-URL>";
  loginWithFacebook() async{
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CustomWebView(
                selectedUrl:'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
          ),
          maintainState: true),);
    if (result != null) {
      try {
        final facebookAuthCred =
            FacebookAuthProvider.getCredential(accessToken: result);
        final user =
            await _auth.signInWithCredential(facebookAuthCred);
      } catch (e) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
    var screenWidth = MediaQuery.of(context).size.width;

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

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/google.png"),
                      height: 30,
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Sign Up with Google",
                          style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      )
                    )
                  ],
                ),
                onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));
                    }
                  );
                },
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/fb.png"),
                      height: 30,
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Sign Up with Facebook",
                          style:TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold

                          )
                        ),
                      )
                    )
                  ],
                ),
                onPressed: () {
                  initiateFacebookLogin();
                },
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/images/github.png"),
                      height: 30,
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "Sign Up with GitHub",
                          style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold

                          )
                        ),
                      )
                    )
                  ],
                ),
                onPressed: () {

                },
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
          child: SizedBox(
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Row(
                children: [
                  Image(
                    image: AssetImage("assets/images/email.png"),
                    height: 30,
                  ),

                  Expanded(
                     child: Center(
                          child: Text("Sign Up with Email",
                             style:TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold

                            )
                          ),
                      )
                  )
                ],
             ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));

                },
            ),
          ),
        ),



          Container(
            padding: EdgeInsets.only(top:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a Member?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  " Sign In",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[700],
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        onLoginStatusChanged(true);
        break;
    }
  }
  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }
}