import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ImageDecoration.dart';

class StaticImageListScreen extends StatelessWidget {
  const StaticImageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //appBar: ,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ImageDecoration(imagePath: 'f1.jpg',),
              SizedBox(height: 20),
              ImageDecoration(imagePath: "f2.jpeg"),
              SizedBox(height: 20),
              ImageDecoration(imagePath: "f5.jpeg"),
              SizedBox(height: 20),
              ImageDecoration(imagePath: "f1.jpg"),
              SizedBox(height: 20),
              ImageDecoration(imagePath: "f6.jpg"),
              SizedBox(height: 20),
              ImageDecoration(imagePath: "s1.webp"),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}
