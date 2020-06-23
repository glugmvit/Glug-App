import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:glugapp/screens/google_sign_in.dart';
import 'UserScreen.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoggedIn = false;
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context){
                            return UserScreen();
                          }
                        )
                      );
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