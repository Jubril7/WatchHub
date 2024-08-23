import 'package:flutter/material.dart';

class Track extends StatelessWidget {
  const Track({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 69, 169),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Track",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Column(
        children: [
          ListTile(
            title: Text(
              "Order Confirmed",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Order Shipped",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
