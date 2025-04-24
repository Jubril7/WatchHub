import 'package:flutter/material.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/shop/watch_tile.dart';
import 'package:watch_hub/screens/home/home.dart';

class getResult {
  static List search = [];
}

class WatchList extends StatefulWidget {
  const WatchList({super.key});
  void passf(String value) {
    print("search result is $value");
  }

  @override
  State<WatchList> createState() => WatchListState();
}

class WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    final watches = Provider.of<List<Watch>>(context);
    print("watch model is $watches");

    OptionsClass.currentSortOption == 'highestPrice'
        ? watches
            .sort((a, b) => int.parse(b.price!).compareTo(int.parse(a.price!)))
        : OptionsClass.currentSortOption == 'lowestPrice'
            ? watches.sort(
                (a, b) => int.parse(a.price!).compareTo(int.parse(b.price!)))
            : OptionsClass.currentSortOption == 'highestPopularity'
                ? watches.sort((a, b) => b.popularity!.compareTo(a.popularity!))
                : OptionsClass.currentSortOption == 'lowestPopularity'
                    ? watches
                        .sort((a, b) => a.popularity!.compareTo(b.popularity!))
                    : watches;
    SearchBox.controller != "" ? getResult.search = watches : getResult.search;
    print("search result is ${SearchBox.controller}");
    getResult.search = watches
        .where((item) =>
            item.model!.toLowerCase().contains(SearchBox.control.text) ||
            item.brand!.toLowerCase().contains(SearchBox.control.text))
        .toList();

    print("clicked");

    if (watches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //     'assets/not-found.png'),
            const Text(
              "Item Not Found",
              style: TextStyle(fontSize: 30.0),
            )
          ],
        ),
      );
    } else {
      return Expanded(
        child: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
                itemCount: getResult.search.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6, crossAxisCount: 2),
                itemBuilder: (contexts, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WatchTile(watch: getResult.search[index]));
                })),
      );
    }
  }
}
// child: WatchTile(watch: watches[index])
