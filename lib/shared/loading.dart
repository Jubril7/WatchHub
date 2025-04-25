import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 139, 185, 255),
      child: const Center(
          child: SpinKitFoldingCube(
        color: Color.fromARGB(255, 22, 69, 169),
        size: 50.0,
      )),
    );
  }
}
