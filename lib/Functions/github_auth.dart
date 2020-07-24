import 'package:firebase_auth/firebase_auth.dart';
import 'package:glugapp/user.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ...
Future<FirebaseUser> loginWithGitHub(String code) async {
  //ACCESS TOKEN REQUEST
  final response = await http.post(
    "https://github.com/login/oauth/access_token",
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    body: jsonEncode(GitHubLoginRequest(
      clientId: CLIENT_ID,
      clientSecret: CLIENT_SECRET,
      code: code,
    )),
  );

  GitHubLoginResponse loginResponse = GitHubLoginResponse.fromJson(json.decode(response.body));

  //FIREBASE STUFF
  final AuthCredential credential = GithubAuthProvider.getCredential(
    token: loginResponse.accessToken,
  );

  final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

  userName = user.displayName;
  userEmail = user.email;
  imageUrl = user.photoUrl;
  return user;
}

// ...
//GITHUB REQUEST-RESPONSE MODELS
class GitHubLoginRequest {
  String clientId;
  String clientSecret;
  String code;

  GitHubLoginRequest({this.clientId, this.clientSecret, this.code});

  dynamic toJson() => {
        "client_id": clientId,
        "client_secret": clientSecret,
        "code": code,
      };
}

class GitHubLoginResponse {
  String accessToken;
  String tokenType;
  String scope;

  GitHubLoginResponse({this.accessToken, this.tokenType, this.scope});

  factory GitHubLoginResponse.fromJson(Map<String, dynamic> json) => GitHubLoginResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        scope: json["scope"],
      );
}
