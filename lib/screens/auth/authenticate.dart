import 'package:flutter/material.dart';
import 'package:watch_hub/screens/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(child: SignIn());
  }
}
