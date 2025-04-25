import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color.fromARGB(255, 22, 69, 169),
        title: const Text(
          "Contact",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (val) =>
                  val!.isEmpty ? 'Please Enter A Review Before Sending' : null,
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 8, //or null
              decoration: const InputDecoration(
                  hintText: "How May We Help?",
                  errorStyle: TextStyle(fontSize: 17),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Message Sent!"),
                                  content: const Text(
                                      "We will get back to you shortly"),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: (const Text("Close")))
                                  ],
                                ));
                      },
                      child: const Text("Send Message"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
