import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/services/database.dart';

class WatchTile extends StatefulWidget {
  final Watch? watch;
  const WatchTile({this.watch, super.key});

  @override
  State<WatchTile> createState() => _WatchTileState();
}

class _WatchTileState extends State<WatchTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/watch_details",
          arguments: widget.watch,
        );
        DatabaseService().getCartBool(widget.watch!.model!);
      },
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.blue),
            ),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.watch!.images![0]),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: const EdgeInsets.only(left: 4.0),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.watch!.brand!,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  Text(
                    widget.watch!.model!,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text('\$${widget.watch!.price!}',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
