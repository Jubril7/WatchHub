import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/screens/home/orders/order_list.dart';
import 'package:watch_hub/services/database.dart';

class OrderProvider extends StatefulWidget {
  const OrderProvider({super.key});

  @override
  State<OrderProvider> createState() => _OrderProviderState();
}

class _OrderProviderState extends State<OrderProvider> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cart>>.value(
      value: DatabaseService().orders,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 69, 169),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text(
            "Orders",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 253, 249, 246),
        body: const OrderList(),
      ),
    );
  }
}
