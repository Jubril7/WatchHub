import 'package:flutter/material.dart';
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/screens/wrapper.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: const Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Hi, ${UserInformation.fullName}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit_profile");
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/orders",
                  )
                },
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.brown.withOpacity(0.5)),
                  child: const Icon(Icons.shopping_bag),
                ),
                title: const Text(
                  "Orders",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_circle_right_rounded),
                ),
              ),
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/favourites",
                  )
                },
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.brown.withOpacity(0.5)),
                  child: const Icon(Icons.favorite),
                ),
                title: const Text(
                  "Favourites",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_circle_right_rounded),
                ),
              ),
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/cart",
                  )
                },
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.brown.withOpacity(0.5)),
                  child: const Icon(Icons.shopping_cart),
                ),
                title: const Text(
                  "Cart",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_circle_right_rounded),
                ),
              )
            ],
          )),
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
          }),
    );
  }
}
