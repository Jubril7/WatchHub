import 'package:flutter/material.dart';
import 'package:watch_hub/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text("Sign in to Watch Hub"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  child: Center(
                      child: Container(
                          width: 350,
                          height: 500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: const Icon(
                                    Icons.lock,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Account",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Email"),
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: TextFormField(
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            labelText: "Password"),
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        })),
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    print(email);
                                    print(password);
                                  },
                                )
                              ]))))),
        ));
  }
}
