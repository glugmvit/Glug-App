import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glugapp/screens/UserScreen.dart';


  String error;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<String> signUp(String email, String password,BuildContext context,var _scaffoldKey) async {
  _showSnackBar(context,_scaffoldKey);
  AuthResult result;
  try {
    result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
  } catch (error) {
    print(error);
    result = null;
  }
  if (result != null) {
    FirebaseUser user = result.user;
    Navigator.push(context, MaterialPageRoute(builder: (context)=> UserScreen()));
  }
  else {
    print("error");
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }
}

_showSnackBar(BuildContext context,var _scaffoldKey) {
  var snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Signing into GLUG"
        ),

        CircularProgressIndicator()
      ],
    )
  );

  _scaffoldKey.currentState.showSnackBar(snackBar);
}