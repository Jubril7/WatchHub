import 'package:flutter/material.dart';
import 'package:watch_hub/services/auth.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Watch Hub"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print("error signing in");
              } else {
                print("signed in");
                print(result.uid);
              }
            },
            child: Text("Sign In anon")),
      ),
    );
  }
}
