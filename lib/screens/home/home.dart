import 'package:flutter/material.dart';
import 'package:watch_hub/models/user.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';
import 'package:watch_hub/services/database.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/shop/watch_list.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class OptionsClass {
  static List<dynamic> brandOptions = [0, 'Rolex', 'Longines'];
  static dynamic currentBrand = brandOptions[0];

  static List<dynamic> typeOptions = [0, 'Analog', 'Digital'];
  static dynamic currentType = typeOptions[0];
  static List<dynamic> sortOptions = [
    0,
    'highestPrice',
    'lowestPrice',
    'highestPopularity',
    'lowestPopularity'
  ];
  static dynamic currentSortOption = sortOptions[0];
}

class SearchBox {
  static String controller = '';
  static TextEditingController control = TextEditingController();
}

class UserInformation {
  static String fullName = '';
  static String phone = '';
  static String address = '';
}

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String fullName = '';
  void getUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    DocumentSnapshot<Map<String, dynamic>> userName = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    UserInformation.fullName = userName.data()!['fullname'];
    UserInformation.phone = userName.data()!['phone'];
    UserInformation.address = userName.data()!['address'];
    print("initstate ran");
  }

  @override
  void initState() {
    super.initState();
    getUser();
    print('super init ran');
  }

  @override
  Widget build(BuildContext context) {
    print("user info ${UserInformation.fullName}");
    return StreamProvider<List<Watch>>.value(
        value: DatabaseService().watches,
        initialData: const [],
        child: Scaffold(
            backgroundColor: Colors.brown[50],
            drawer: Drawer(
              child: Column(
                children: <Widget>[
                  const UserAccountsDrawerHeader(
                    accountName: Text("Flutter"),
                    accountEmail: null,
                  ),
                  ListTile(
                    leading: TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text("Logout"),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              // title: const Text("Watch Hub"),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: <Widget>[
                Row(
                  children: [
                    SizedBox(
                        width: 310,
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                          child: TextField(
                              controller: SearchBox.control,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hoverColor: Colors.white,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusColor: Colors.white,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        SearchBox.control.clear();
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      });
                                    },
                                    icon: Icon(Icons.cancel),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                          width: 0.8, color: Colors.white)),
                                  hintText: "Search Watch"),
                              onChanged: (value) => setState(() {
                                    SearchBox.control.text = value;
                                  })),
                        )),
                    IconButton(
                        onPressed: () {
                          NavigationKey.navKey.currentState!.pushNamed('/cart');
                        },
                        icon: Icon(Icons.shopping_cart)),
                  ],
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  height: 80,
                  color: Color.fromARGB(255, 213, 195, 195),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownMenu(
                          width: 130,
                          label: Text("By Brand"),
                          dropdownMenuEntries: <DropdownMenuEntry>[
                            DropdownMenuEntry(
                                value: OptionsClass.brandOptions[0],
                                label: 'None'),
                            DropdownMenuEntry(
                                value: OptionsClass.brandOptions[1],
                                label: 'Rolex'),
                            DropdownMenuEntry(
                                value: OptionsClass.brandOptions[2],
                                label: 'Longines')
                          ],
                          onSelected: (value) {
                            setState(() {
                              OptionsClass.currentBrand = value;
                              print("current is ${OptionsClass.currentBrand}");
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownMenu(
                          width: 130,
                          label: Text("By Type"),
                          dropdownMenuEntries: <DropdownMenuEntry>[
                            DropdownMenuEntry(
                                value: OptionsClass.typeOptions[0],
                                label: 'None'),
                            DropdownMenuEntry(
                                value: OptionsClass.typeOptions[1],
                                label: 'Analog'),
                            DropdownMenuEntry(
                                value: OptionsClass.typeOptions[2],
                                label: 'Digital')
                          ],
                          onSelected: (value) {
                            setState(() {
                              OptionsClass.currentType = value;
                              print("current is ${OptionsClass.currentBrand}");
                            });
                          },
                        ),
                      ),
                      DropdownMenu(
                        width: 130,
                        label: Text("Sort By"),
                        dropdownMenuEntries: <DropdownMenuEntry>[
                          DropdownMenuEntry(
                              value: OptionsClass.sortOptions[0],
                              label: 'None'),
                          DropdownMenuEntry(
                              value: OptionsClass.sortOptions[1],
                              label: 'Price - Highest To Lowest'),
                          DropdownMenuEntry(
                              value: OptionsClass.sortOptions[2],
                              label: 'Price - Lowest To Highest'),
                          DropdownMenuEntry(
                              value: OptionsClass.sortOptions[3],
                              label: 'Popularity - Highest To Lowest'),
                          DropdownMenuEntry(
                              value: OptionsClass.sortOptions[4],
                              label: 'Popularity - Lowest To Highest')
                        ],
                        onSelected: (value) {
                          setState(() {
                            OptionsClass.currentSortOption = value;
                            print("current is ${OptionsClass.currentBrand}");
                          });
                        },
                      )
                    ],
                  ),
                ),
                const WatchList(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                fixedColor: Colors.white,
                showUnselectedLabels: false,
                currentIndex: Wrapper.currentIndex,
                backgroundColor: Colors.brown[400],
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: Colors.lightBlue,
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                      backgroundColor: Colors.amber),
                ],
                onTap: (index) {
                  setState(() {
                    Wrapper.currentIndex = index;
                  });
                  if (Wrapper.currentIndex == 0) {
                    Navigator.pushNamed(
                      context,
                      "/home",
                    );
                  } else if (Wrapper.currentIndex == 1) {
                    Navigator.pushNamed(
                      context,
                      "/profile_list",
                    );
                  }
                })));
  }
}
