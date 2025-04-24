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
  static List<dynamic> brandOptions = [
    0,
    'Nite',
    'Seiko',
    'Portahl',
    'G-shock',
    'Sylvi',
    'Rolex',
    'Patek',
  ];
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
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 22, 69, 169),
            elevation: 0.0,
            actions: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 30),
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
                                  borderSide: BorderSide(color: Colors.white)),
                              focusColor: Colors.white,
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    SearchBox.control.clear();
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  });
                                },
                                icon: const Icon(Icons.cancel),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      width: 0.8, color: Colors.white)),
                              hintText: "Search Watch"),
                          onChanged: (value) => setState(() {
                            SearchBox.control.text = value;
                          }),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        NavigationKey.navKey.currentState!.pushNamed('/cart');
                      },
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 80,
                width: MediaQuery.sizeOf(context).width,
                color: const Color.fromARGB(255, 22, 69, 169),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        primaryColorLight: Colors.red,
                      ),
                      child: DropdownMenu(
                        textStyle: const TextStyle(color: Colors.white),
                        initialSelection: 0,
                        inputDecorationTheme: const InputDecorationTheme(
                          suffixIconColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        width: 130,
                        label: const Text(
                          "By Brand",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownMenuEntries: <DropdownMenuEntry>[
                          DropdownMenuEntry(
                            value: OptionsClass.brandOptions[0],
                            label: 'None',
                          ),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[1],
                              label: 'Nite'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[2],
                              label: 'Seiko'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[3],
                              label: 'Portahl'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[4],
                              label: 'G-shock'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[5],
                              label: 'Sylvi'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[6],
                              label: 'Rolex'),
                          DropdownMenuEntry(
                              value: OptionsClass.brandOptions[7],
                              label: 'Patek')
                        ],
                        onSelected: (value) {
                          setState(() {
                            OptionsClass.currentBrand = value;
                            print("current is ${OptionsClass.currentBrand}");
                          });
                        },
                      ),
                    ),
                    DropdownMenu(
                      initialSelection: 0,
                      textStyle: const TextStyle(color: Colors.white),
                      inputDecorationTheme: const InputDecorationTheme(
                        suffixIconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      width: 130,
                      label: const Text(
                        "By Type",
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownMenuEntries: <DropdownMenuEntry>[
                        DropdownMenuEntry(
                            value: OptionsClass.typeOptions[0], label: 'None'),
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
                    DropdownMenu(
                      initialSelection: 0,
                      textStyle: const TextStyle(color: Colors.white),
                      inputDecorationTheme: const InputDecorationTheme(
                        suffixIconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      width: 130,
                      label: const Text(
                        "Sort By",
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownMenuEntries: <DropdownMenuEntry>[
                        DropdownMenuEntry(
                            value: OptionsClass.sortOptions[0], label: 'None'),
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
            backgroundColor: const Color.fromARGB(255, 22, 69, 169),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.lightBlue,
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Colors.amber,
              ),
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
            },
          ),
        ));
  }
}
