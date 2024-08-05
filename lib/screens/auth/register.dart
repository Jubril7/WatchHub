import 'package:flutter/material.dart';
import 'package:watch_hub/services/auth.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({this.toggleView, super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text("Sign Up to Watch Hub"),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                widget.toggleView!();
              },
              label:
                  const Text("Sign In", style: TextStyle(color: Colors.white)),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Center(
                      child: Container(
                          width: 350,
                          height: 500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
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
                                    width: 300,
                                    height: 50,
                                    child: TextFormField(
                                      validator: (val) => val!.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Email"),
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: TextFormField(
                                        validator: (val) => val!.length < 6
                                            ? 'Enter a password with at least 6 characters'
                                            : null,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            hintText: "Password"),
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
                                    "Register",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() => error =
                                            'Please supply a valid email');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(error,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 14.0))
                              ]))))),
        ));
  }
}
