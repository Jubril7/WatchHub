import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/screens/home/cart_list.dart';
import 'package:watch_hub/screens/home/watch_list.dart';
import 'package:watch_hub/services/database.dart';

class CartProvider extends StatefulWidget {
  const CartProvider({super.key});

  @override
  State<CartProvider> createState() => _CartProviderState();
}

class _CartProviderState extends State<CartProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseService(),
      child: StreamProvider<List<Cart>>.value(
        value: DatabaseService().carts,
        initialData: const [],
        child: Scaffold(
          body: CartList(),
        ),
      ),
    );
  }
}
