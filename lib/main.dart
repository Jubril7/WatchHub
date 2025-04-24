import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/admin/add_watch.dart';
import 'package:watch_hub/screens/admin/delete_watch.dart';
import 'package:watch_hub/screens/auth/reset.dart';
import 'package:watch_hub/screens/home/cart/cart_list.dart';
import 'package:watch_hub/screens/home/favourites/favourites_provider.dart';
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/screens/home/orders/order_provider.dart';
import 'package:watch_hub/screens/home/orders/track.dart';
import 'package:watch_hub/screens/home/profile/contact.dart';
import 'package:watch_hub/screens/home/profile/edit_profile.dart';
import 'package:watch_hub/screens/home/profile/faq.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/models/user.dart';
import 'package:watch_hub/screens/home/shop/watch_detail.dart';
import 'package:watch_hub/screens/home/profile/profileList.dart';
import 'package:watch_hub/services/database.dart';

class NavigationKey {
  static final navKey = GlobalKey<NavigatorState>();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDc_HywtM_Jh7tzr-4NxkI2PmglHzw9RkI",
        appId: "1:87695584694:web:f3669e0ef6978eaf58a517",
        messagingSenderId: "87695584694",
        projectId: "watchhub-d41f0"
        ),
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
      child: ChangeNotifierProvider(
        create: (context) => DatabaseService(),
        child: MaterialApp(
            navigatorKey: NavigationKey.navKey,
            debugShowCheckedModeBanner: false,
            routes: {
              '/home': (context) => Home(),
              '/reset': (context) => Reset(),
              '/profile_list': (context) => const ProfileList(),
              '/watch_details': (context) => const WatchDetail(),
              '/cart': (context) => const CartList(),
              '/orders': (context) => const OrderProvider(),
              '/edit_profile': (context) => const EditProfile(),
              '/faq': (context) => const Faq(),
              '/favourites': (context) => const FavouritesProvider(),
              '/track': (context) => const Track(),
              '/contact': (context) => const Contact(),
              '/add_watch': (context) => const AddWatch(),
              '/delete_watch': (context) => const DeleteWatch(),
            },
            home: Wrapper()),
      ),
    );
  }
}
