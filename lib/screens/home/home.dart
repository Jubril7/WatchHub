import 'package:flutter/material.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/services/database.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/watch_list.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/main.dart';

class OptionsClass {
  static List<dynamic> brandOptions = [0, 'Rolex', 'Longines'];
  static dynamic currentBrand = brandOptions[0];

  static List<dynamic> typeOptions = [0, 'Analog', 'Digital'];
  static dynamic currentType = typeOptions[0];
}

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Watch>>.value(
      value: DatabaseService().watches,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        drawer: Drawer(
          elevation: 20.0,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Flutter"),
                accountEmail: null,
              ),
              ListTile(
                title: const Text('None'),
                leading: Radio<dynamic>(
                  value: OptionsClass.typeOptions[0],
                  groupValue: OptionsClass.currentType,
                  onChanged: (value) {
                    setState(() {
                      OptionsClass.currentType = value;
                      print("current is ${OptionsClass.currentType}");
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Analog'),
                leading: Radio<dynamic>(
                  value: OptionsClass.typeOptions[1],
                  groupValue: OptionsClass.currentType,
                  onChanged: (value) {
                    setState(() {
                      OptionsClass.currentType = value;
                      print("current is ${OptionsClass.currentType}");
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Digital'),
                leading: Radio<dynamic>(
                  value: OptionsClass.typeOptions[2],
                  groupValue: OptionsClass.currentType,
                  onChanged: (value) {
                    setState(() {
                      OptionsClass.currentType = value;
                      print("current is ${OptionsClass.currentType}");
                    });
                  },
                ),
              ),
              Divider(
                height: 0.1,
              ),
              ListTile(
                title: const Text('None'),
                leading: Radio<dynamic>(
                  value: OptionsClass.brandOptions[0],
                  groupValue: OptionsClass.currentBrand,
                  onChanged: (value) {
                    setState(() {
                      OptionsClass.currentBrand = value;
                      print("current is ${OptionsClass.currentBrand}");
                    });
                  },
                ),
              ),
              ListTile(
                  title: const Text('Rolex'),
                  leading: Radio(
                    value: OptionsClass.brandOptions[1],
                    groupValue: OptionsClass.currentBrand,
                    onChanged: (value) {
                      setState(() {
                        OptionsClass.currentBrand = value;
                        print("current is ${OptionsClass.currentBrand}");
                      });
                    },
                  )),
              ListTile(
                  title: const Text('Longines'),
                  leading: Radio(
                    value: OptionsClass.brandOptions[2],
                    groupValue: OptionsClass.currentBrand,
                    onChanged: (value) {
                      setState(() {
                        OptionsClass.currentBrand = value;
                        print("current is ${OptionsClass.currentBrand}");
                      });
                    },
                  )),
              const ListTile(
                title: Text("ADD ORDER BY PRICE AND POPULARITY HERE"),
                leading: Icon(Icons.local_offer),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Watch Hub"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      NavigationKey.navKey.currentState!.pushNamed('/cart');
                    },
                    icon: Icon(Icons.shopping_cart)),
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Logout"),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            )
          ],
        ),
        body: const WatchList(),
      ),
    );
  }
}
