import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glugapp/Functions/facebook_signin.dart';
import 'package:glugapp/Functions/github_auth.dart';
import 'package:glugapp/Widgets/social_button.dart';
import 'package:glugapp/screens/email_signin.dart';
import 'package:glugapp/Functions/google_sign_in.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'UserScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StreamSubscription _subs;

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((String link) {
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      loginWithGitHub(code).then((firebaseUser) {
        print("LOGGED IN AS: " + firebaseUser.displayName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UserScreen();
            },
          ),
        );
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  void onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" + "?client_id=" + CLIENT_ID + "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
    FirebaseAuth.instance.currentUser().then((value) {
      if (value != null) {
        print("hello");
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disposeDeepLinkListener();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.yellow])),
            child: ListView(
              children: [
                Image(
                  image: AssetImage("assets/images/glug_logo.png"),
                  height: screenHeight * 0.2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Center(
                    child: Text(
                      "Don't worry if it doesn't work right. If everything did, you'd be out of a job.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: screenHeight * 0.1),
                  child: Center(
                    child: Text(
                      " ",
                      style: TextStyle(color: Colors.blue[700], fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
                    });
                  },
                  text: Text("Sign Up with Google", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                SocialButton(
                  screenWidth: MediaQuery.of(context).size.width,
                  image: Image(
                    image: AssetImage("assets/images/fb.png"),
                    height: 30,
                  ),
                  function: () {
                    initiateFacebookLogin();
                    setState(() {});
                  },
                  text: Text("Sign Up with Facebook", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                SocialButton(
                  screenWidth: MediaQuery.of(context).size.width,
                  image: Image(
                    image: AssetImage("assets/images/github.png"),
                    height: 30,
                  ),
                  function: () async {
                    onClickGitHubLoginButton();
                  },
                  text: Text("Sign Up with GitHub", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                SocialButton(
                  screenWidth: MediaQuery.of(context).size.width,
                  image: Image(
                    image: AssetImage("assets/images/email.png"),
                    height: 30,
                  ),
                  function: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  text: Text("Sign Up with Email", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ));
  }
}
