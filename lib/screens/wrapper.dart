import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/user.dart';
import 'package:watch_hub/screens/auth/authenticate.dart';
import 'package:watch_hub/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key});
  static int currentIndex = 0;
  @override
  State<Wrapper> createState() => _WrapperState();
}

int currentIndex = 0;

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetails?>(context);

    print(user);

    //return either home or authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Scaffold(
        body: Home(),
      );
    }
  }
}
