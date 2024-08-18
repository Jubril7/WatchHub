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
        body: OrderList(),
      ),
    );
  }
}
