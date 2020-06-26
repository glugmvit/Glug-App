import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:glugapp/Constants/api_keys.dart';
import 'package:glugapp/Functions/custom_webview.dart';

bool isLoggedIn = false;
final FirebaseAuth _auth = FirebaseAuth.instance;

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
  isLoggedIn = isLoggedIn;
}


loginWithFacebook(BuildContext context) async{
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