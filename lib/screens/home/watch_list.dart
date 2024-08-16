import 'package:flutter/material.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/screens/home/watch_tile.dart';
import 'package:watch_hub/screens/home/home.dart';

// class OptionsClass {
//   static List<dynamic> brandOptions = [0, 'Rolex', 'Longines'];
//   static dynamic currentBrand = brandOptions[0];

//   static List<dynamic> typeOptions = [0, 'Analog', 'Digital'];
//   static dynamic currentType = typeOptions[0];

//   static List<dynamic> sortOptions = [
//     0,
//     'highestPrice',
//     'lowestPrice',
//     'highestPopularity',
//     'lowestPopularity'
//   ];
//   // static dynamic currentSortOption = typeOptions[0];
//   static String currentSortOption = 'highestPrice';
// }

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

    // OptionsClass.currentSortOption == 'highestPrice'
    //     ? watches.sort((a, b) => b.price!.compareTo(a.price!))
    //     : OptionsClass.currentSortOption == 'lowestPrice'
    //         ? watches.sort((a, b) => a.price!.compareTo(b.price!))
    //         : OptionsClass.currentSortOption == 'highestPopularity'
    //             ? watches.sort((a, b) => b.popularity!.compareTo(a.popularity!))
    //             : OptionsClass.currentSortOption == 'lowestPopularity'
    //                 ? watches
    //                     .sort((a, b) => a.popularity!.compareTo(b.popularity!))
    //                 : watches;
    var search = watches
        .where((item) =>
            item.model!.toLowerCase().contains(SearchBox.controller.text) ||
            item.brand!.toLowerCase().contains(SearchBox.controller.text))
        .toList();
    print("search returned ${SearchBox.controller.text}");

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
      return Expanded(
        child: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
                itemCount: search.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7, crossAxisCount: 2),
                itemBuilder: (contexts, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WatchTile(watch: search[index]));
                })),
      );
    }
  }
}
// child: WatchTile(watch: watches[index])
