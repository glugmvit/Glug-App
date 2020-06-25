import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {

  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {


  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

  /// For Fingerprint & FaceId Local Auth
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();
  bool _canCheckBiometric = false;

  bool _loading = false;
  String error;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Future<void> checkBiometrics() async{
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ) : SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: null,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Image.asset("assets/images/logo.png",height: 30,
                        width: 30,alignment: Alignment.center,)),
                      SizedBox(height: 13,),
                      Text("GLUG APP", style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 27,color: Colors.white,
                              letterSpacing: 1
                          )
                      ),),
                      SizedBox(height: 30,),
                      Container(
                        width: 180,
                        child: Text("Sir M. Visvesveraya Institute Of Technology", textAlign: TextAlign.center,style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.white54,
                              letterSpacing: 0.6,
                              fontSize: 11
                          ),
                        ),),
                      ),
                      SizedBox(height: 40,),
                      Text("Sign In", textAlign: TextAlign.center,style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 23,
                        ),
                      ),),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Almost Done!! 😋", textAlign: TextAlign.center,style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1,
                              fontSize: 17,
                            ),
                          ),),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: emailcontroller,
                                validator: (val) => val.isEmpty ? "Enter Valid Email":null,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  hintText: "Email",hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15
                                ),
                                ),
                                onSaved: (val){
                                  email = val;
                                },
                              ),
                              SizedBox(height: 16,),
                              TextFormField(
                                controller: passwordcontroller,
                                obscureText: true,
                                validator: (val) => val.isEmpty ? "Enter Password":null,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  hintText: "Password",hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15
                                ),
                                ),
                                onSaved: (val){
                                  password = val;
                                },
                              ),
                              SizedBox(height: 30,),
                              GestureDetector(
                                onTap: () async{

                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text("SUBMIT",textAlign: TextAlign.center,style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 1
                                      )
                                  ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      SizedBox(height: 20,),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

Future<void> cantCheckBiometricsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('No Biometrics Found'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Can not login with Biometrics'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
