import 'package:flutter/material.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/watch_tile.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    final watches = Provider.of<List<Watch>>(context);
    print("watch model is $watches");

    watches.forEach((watch) {
      print("rolaaa $watch");
    });

    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: watches.length,
    //   itemBuilder: (context, index) {
    //   },
    // );
    if (watches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/watch-hub-6810e.appspot.com/o/not-found-removebg-preview.png?alt=media&token=c98edcd3-07e1-4016-b510-a34bdd687fae'),
            const Text(
              "Item Not Found",
              style: TextStyle(fontSize: 30.0),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
              itemCount: watches.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7, crossAxisCount: 2),
              itemBuilder: (contexts, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WatchTile(watch: watches[index]));
              }));
    }
  }
}
// child: WatchTile(watch: watches[index])
