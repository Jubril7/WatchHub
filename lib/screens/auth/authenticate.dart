import 'package:flutter/material.dart';
import 'package:watch_hub/screens/auth/register.dart';
import 'package:watch_hub/screens/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  //set the state of showSignIn to be the opposite of its current value
  void toggleView() {
    setState(
      () => showSignIn = !showSignIn,
    );
    print(showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    //display either sign in or register widget depending on the value of showSignIn
    if (showSignIn == true) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
