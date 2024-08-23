import 'package:flutter/material.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/services/database.dart';

class Admin extends StatelessWidget {
  Admin({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Admin",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 22, 69, 169),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Wrapper()));
            },
            label:
                const Text("Sign Out", style: TextStyle(color: Colors.white)),
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(context, '/add_watch');
                    },
                    child: const Text(
                      "Add Watch",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(context, '/delete_watch');
                    },
                    child: const Text(
                      "Delete Watch",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
