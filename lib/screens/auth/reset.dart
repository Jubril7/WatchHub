import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 69, 169),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Enter An Email To Send A Password Reset Email",
            style: TextStyle(fontSize: 18),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      controller: input,
                      validator: (value) =>
                          value!.isEmpty ? "Empty Fields Not Allowed" : null,
                      onChanged: (value) => setState(() {
                        input.text = value;
                      }),
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _auth.sendPasswordResetLink(input.text);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Watch Hub"),
                              content: const Text("Password Reset Email Sent"),
                              contentPadding: const EdgeInsets.all(20.0),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: (const Text("Close")))
                              ],
                            ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 139, 185, 255),
                ),
                child: const Text(
                  "Reset",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
