// main.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:moplieproject/screens/StaticImageListScreen.dart';
import 'package:moplieproject/screens/home_page.dart';
import 'package:moplieproject/screens/profile_page.dart';

import 'data/DatabaseHelper.dart';
import 'data/MyTextScreen.dart';
import 'data/list.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final databaseRef = FirebaseDatabase.instance.reference();
  var list = courtList;
  databaseRef.child('messages').push().set({'message': 'HelloWorld'});
  DatabaseHelper.createFirebaseRealtimeDBWithUniqueIDs('padlecourt', list);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius Group Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(), // Changed to MyHomePage to show the bottom navigation bar
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; //this is the index of the pages through navbar

  final List<Widget> _widgetOptions; //list that takes widgets

  _MyHomePageState() : _widgetOptions = [
    //HomePage(),
    // HomePage requires sendMessage to be passed
    HomeScreen(),

    MyTextScreen(),
    //AddNewCourtDataToFirebase(),
    StaticImageListScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genius Group Application'),
        backgroundColor: Colors.blue,
      ),
      
      body: Center( 
        
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        color: Colors.white,
        buttonBackgroundColor: Colors.amber,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 28, ),
          Icon(Icons.event, size: 28, ),
          Icon(Icons.add, size: 28, ),
          Icon(Icons.list, size: 28, ),

          // Uncomment the following line if you decide to add the profile item back
          // Icon(Icons.person, size: 28, color: _selectedIndex == 3 ? Colors.amber : Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        index: _selectedIndex,
      ),
    );
  }
}