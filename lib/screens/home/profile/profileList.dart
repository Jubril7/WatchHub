import 'package:flutter/material.dart';
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/screens/wrapper.dart';
import 'package:watch_hub/services/auth.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 69, 169),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
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
                    backgroundColor: Color.fromARGB(255, 139, 185, 255),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit_profile");
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
                      color: Color.fromARGB(255, 22, 69, 169).withOpacity(0.5)),
                  child: const Icon(
                    Icons.shopping_bag,
                    // color: Color.fromARGB(232, 236, 233, 225),
                    color: Colors.white,
                  ),
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
                  child: const Icon(Icons.arrow_forward_ios),
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
                      color: Color.fromARGB(255, 22, 69, 169).withOpacity(0.5)),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Wishlist",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/faq",
                  )
                },
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 22, 69, 169).withOpacity(0.5)),
                  child: const Icon(Icons.question_answer, color: Colors.white),
                ),
                title: const Text(
                  "FAQ",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/contact",
                  )
                },
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 22, 69, 169).withOpacity(0.5)),
                  child: const Icon(Icons.headset_mic, color: Colors.white),
                ),
                title: const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(
                width: 200,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Wrapper()));
                  },
                  child: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          showUnselectedLabels: false,
          currentIndex: Wrapper.currentIndex,
          backgroundColor: Color.fromARGB(255, 22, 69, 169),
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
