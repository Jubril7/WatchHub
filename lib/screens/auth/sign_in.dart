import 'package:flutter/material.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/shared/constants.dart';
import 'package:watch_hub/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  const SignIn({this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 253, 249, 246),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 22, 69, 169),
              elevation: 0.0,
              title: const Text("Sign in to Watch Hub",
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    label: const Text("Register",
                        style: TextStyle(color: Colors.white)),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ))
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
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty
                                              ? 'Enter an email'
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                          decoration:
                                              textInputDecoration.copyWith(
                                            hintText: "Email",
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 139, 185, 255),
                                                width: 2,
                                              ),
                                            ),
                                          ),
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
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 139, 185, 255),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                password = value;
                                              });
                                            })),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/reset');
                                          },
                                          child: const Text(
                                            "Forgot Password?",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 139, 185, 255),
                                        ),
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => loading = true);
                                            dynamic result = await _auth
                                                .signInWithEmailAndPassword(
                                                    email, password);
                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    'Could not sign in with those credentials';
                                                loading = false;
                                              });
                                            }
                                            Wrapper.currentIndex = 0;
                                          }
                                        },
                                      ),
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
