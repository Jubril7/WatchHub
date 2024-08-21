import 'package:flutter/material.dart';
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/services/database.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController =
      TextEditingController(text: UserInformation.fullName);
  TextEditingController phoneController =
      TextEditingController(text: UserInformation.phone);
  TextEditingController addressController =
      TextEditingController(text: UserInformation.address);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color.fromARGB(255, 22, 69, 169),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          validator: (value) =>
                              value!.isEmpty ? "Enter A Name" : null,
                          onChanged: (value) => setState(() {
                            nameController.text = value;
                          }),
                          controller: nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2)),
                              label: const Text("Fullname"),
                              prefixIcon: const Icon(Icons.person)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          validator: (value) =>
                              value!.isEmpty ? "Enter A Phone Number" : null,
                          onChanged: (value) => setState(() {
                            phoneController.text = value;
                          }),
                          controller: phoneController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2)),
                              label: const Text("Phone Number"),
                              prefixIcon: const Icon(Icons.phone)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          validator: (value) =>
                              value!.isEmpty ? "Enter An Address" : null,
                          onChanged: (value) => setState(() {
                            addressController.text = value;
                          }),
                          controller: addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2)),
                              label: const Text("Address"),
                              prefixIcon: const Icon(Icons.home)),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 139, 185, 255),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserInformation.fullName = nameController.text;
                      UserInformation.phone = phoneController.text;
                      UserInformation.address = addressController.text;

                      DatabaseService().editProfile(nameController.text,
                          phoneController.text, addressController.text);

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Watch Hub"),
                                content: const Text("Profile Saved"),
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
                    "Save Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
