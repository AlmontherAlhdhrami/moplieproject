import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageDecoration extends StatelessWidget {
  final String imagePath;

  const ImageDecoration({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("image/$imagePath"),
          ),
          border: Border.all(width: 6, color: Colors.green),
          boxShadow: const [
            BoxShadow(
              color: Colors.red,
              blurRadius: 4,
              spreadRadius: 4.5,
              blurStyle: BlurStyle.solid,
            )
          ]),
    );
  }
}
