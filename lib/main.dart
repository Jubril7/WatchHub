import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDetails?>.value(
      initialData: null,
      value: AuthService().user,
      child:
          const MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()),
    );
  }
}
