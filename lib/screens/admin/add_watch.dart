import 'package:flutter/material.dart';
import 'package:watch_hub/services/database.dart';

class AddWatch extends StatefulWidget {
  const AddWatch({super.key});

  @override
  State<AddWatch> createState() => _AddWatchState();
}

class _AddWatchState extends State<AddWatch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController modelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController popularityController = TextEditingController();
  TextEditingController resistanceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController coverController = TextEditingController();
  TextEditingController secondary1Controller = TextEditingController();
  TextEditingController secondary2Controller = TextEditingController();
  TextEditingController secondary3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
          title: const Text(
            "Add Watch",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Color.fromARGB(255, 22, 69, 169)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: modelController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          modelController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Model"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: brandController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          brandController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Brand"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: colorController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          colorController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Color"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: materialController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          materialController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Material"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: popularityController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          popularityController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Popularity"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: resistanceController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          resistanceController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Resistance"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: priceController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          priceController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Price"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: descriptionController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          descriptionController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Description"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: typeController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          typeController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Type"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: coverController,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          coverController.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Cover Image"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: secondary1Controller,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          secondary1Controller.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Secondary Image 1"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: secondary2Controller,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          secondary2Controller.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Secondary Image 2"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: secondary3Controller,
                        validator: (value) =>
                            value!.isEmpty ? "Empty Fields Not Allowed" : null,
                        onChanged: (value) => setState(() {
                          secondary3Controller.text = value;
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          label: const Text("Secondary Image 3"),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DatabaseService().addWatch(
                        brandController.text,
                        modelController.text,
                        colorController.text,
                        typeController.text,
                        materialController.text,
                        popularityController.text,
                        resistanceController.text,
                        priceController.text,
                        descriptionController.text,
                        coverController.text,
                        secondary1Controller.text,
                        secondary2Controller.text,
                        secondary3Controller.text);

                    brandController.clear();
                    modelController.clear();
                    colorController.clear();
                    typeController.clear();
                    materialController.clear();
                    popularityController.clear();
                    resistanceController.clear();
                    priceController.clear();
                    descriptionController.clear();
                    coverController.clear();
                    secondary1Controller.clear();
                    secondary2Controller.clear();
                    secondary3Controller.clear();

                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Watch Hub"),
                              content: const Text("Watch Added"),
                              contentPadding: EdgeInsets.all(20.0),
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
                  "Add Watch",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
