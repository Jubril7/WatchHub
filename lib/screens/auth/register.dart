import 'package:flutter/material.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/shared/constants.dart';
import 'package:watch_hub/shared/loading.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({this.toggleView, super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  String address = '';
  String fullName = '';
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
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
                  label: const Text("Sign In",
                      style: TextStyle(color: Colors.white)),
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Center(
                          child: Container(
                              width: 350,
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
                                      height: 10,
                                    ),
                                    const Text(
                                      "Account",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty
                                              ? 'Enter Your Name'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              fullName = value;
                                            });
                                          },
                                          decoration: textInputDecoration
                                              .copyWith(hintText: "Full Name"),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty
                                              ? 'Enter an email'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                          decoration: textInputDecoration
                                              .copyWith(hintText: "Email"),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty
                                              ? 'Enter An Address'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              address = value;
                                            });
                                          },
                                          decoration: textInputDecoration
                                              .copyWith(hintText: "Address"),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty
                                              ? 'Enter A Phone Number'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              phone = value;
                                            });
                                          },
                                          decoration:
                                              textInputDecoration.copyWith(
                                                  hintText: "Phone Number"),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                            validator: (val) => val!.length < 6
                                                ? 'Enter a password with at least 6 characters'
                                                : null,
                                            obscureText: true,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: "Password",
                                                    errorStyle: TextStyle()),
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
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email,
                                                  password,
                                                  address,
                                                  fullName,
                                                  phone);
                                          if (result == null) {
                                            setState(() {
                                              error =
                                                  'Please supply a valid email';
                                              loading = false;
                                            });
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
