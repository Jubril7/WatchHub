import 'package:flutter/material.dart';
import 'package:watch_hub/services/database.dart';

class DeleteWatch extends StatefulWidget {
  const DeleteWatch({super.key});

  @override
  State<DeleteWatch> createState() => _DeleteWatchState();
}

class _DeleteWatchState extends State<DeleteWatch> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 249, 246),
        appBar: AppBar(
            title: const Text(
              "Delete Watch",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: const Color.fromARGB(255, 22, 69, 169)),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2)),
                      label: const Text("Input Watch Model To Delete"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DatabaseService().deleteWatch(input.text);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Watch Hub"),
                              content: const Text("Watch Deleted"),
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
                child: const Text(
                  "Delete Watch",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ])));
  }
}
