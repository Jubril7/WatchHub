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
    watches.forEach((watch) {
      print(watch.model);
      print(watch.type);
      print(watch.price);
    });

    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: watches.length,
    //   itemBuilder: (context, index) {
    //   },
    // );
    if (watches.isEmpty) {
      return Center();
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
