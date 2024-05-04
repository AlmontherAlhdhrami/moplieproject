import 'package:flutter/material.dart';
import '../data/Izkiscreen.dart';
import '../data/NzwaScreen.dart';
import '../data/Salalahscreen.dart';
import '../data/muscatscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white70, Colors.blue],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    Image.asset(
                      "image/logo2.png",
                      width: 200,  // Specify the width
                      height: 200, // Specify the height
                      fit: BoxFit.cover, // Covers the box by clipping the image
                    ),

                     // Space between the image and the text
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF596B21),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Start booking your time to play now",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:  Color(
                      0xFF1A730C)),
                ),
                SizedBox(height: 20),
                Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search your place",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      List<String> places = ['Muscat', 'Izki', 'Nizwa', 'Salalah'];
                      List<String> images = ['b', 'c', 'd', 'e'];
                      return placecard(
                        title: places[index],
                        image: 'images/${images[index]}.jpg',
                        press: () {
                          if (places[index] == "Muscat") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => muscatscreen()),
                            );
                          }
                          if (places[index] == "Izki") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => izkiscreen()),
                            );
                          }
                          if (places[index] == "Nizwa") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Nizwascreen()),
                            );
                          }
                          if (places[index] == "Salalah") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Salalahscreen()),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class placecard extends StatelessWidget {
  final String title, image;
  final VoidCallback press;

  const placecard({super.key, required this.title, required this.image, required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: press,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(image),
                    radius: 48,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
