import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/ImageDecoration.dart';
import '../../screens/imageCaption.dart';
import 'DatabaseHelper.dart';
import 'court_model.dart';
import '../../screens/CastleDetailScreen.dart'; // Ensure you have the correct import for CastleDetailScreen

class MyTextScreen extends StatefulWidget {
  const MyTextScreen({Key? key});

  @override
  State<MyTextScreen> createState() => _MyTextScreenState();
}

class _MyTextScreenState extends State<MyTextScreen> {
  List<Court> castleList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDBMain((List<Court> castleList) {
      setState(() {
        this.castleList = castleList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: castleList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: castleList.length,
        itemBuilder: (context, index) {
          Court court = castleList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CastleDetailScreen(court: court),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: ImageDecoration(
                      imagePath: '${court.courtData?.imagePath ?? ''}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${court.courtData?.name ?? 'No Name'}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Place: ${court.courtData?.place ?? 'Unknown'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Price: \$${court.courtData?.ticketPrice?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
