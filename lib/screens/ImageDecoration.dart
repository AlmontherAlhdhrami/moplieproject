import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDecoration extends StatelessWidget {
  final String imagePath;

  ImageDecoration({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("image/$imagePath"), // Ensure the path is correct and the image exists in assets
        ),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // More natural shadow color
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4), // Standard shadow positioning
          )
        ],
      ),
      clipBehavior: Clip.hardEdge, // Ensures the content is clipped to the rounded borders
    );
  }
}
