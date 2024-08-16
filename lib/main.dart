import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/cart_list.dart';
import 'package:watch_hub/screens/home/cart_provider.dart';

import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/models/user.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/screens/home/watch_detail.dart';
import 'package:watch_hub/services/database.dart';

class NavigationKey {
  static final navKey = GlobalKey<NavigatorState>();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //IF BLANK SCREEN DISPLAYS COMMENT THE INITIALIZE FIREBASE STATEMENT, RUN THE APP AND LET THE APP SHOW ERROR THEN UNCOMMENT AND RUN AGAIN
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDl6sev6AC1oz893_BuTNNWP5cE2tAE1F4",
        appId: "1:416592857912:android:6f9046a88cdfe2ea8d8fcd",
        messagingSenderId: "416592857912",
        projectId: "watch-hub-6810e"),
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDetails?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
          navigatorKey: NavigationKey.navKey,
          debugShowCheckedModeBanner: false,
          routes: {
            '/watch_details': (context) => const WatchDetail(),
            '/cart': (context) => const CartProvider()
          },
          home: const Wrapper()),
    );
  }
}
