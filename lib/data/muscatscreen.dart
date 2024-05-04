import 'package:flutter/material.dart';

import '../screens/CastleDetailScreen.dart';
import '../screens/ImageDecoration.dart';
import '../screens/MapScreen.dart';
import 'DatabaseHelper.dart';
import 'court_model.dart';

class muscatscreen extends StatefulWidget {
  const muscatscreen({super.key});

  @override
  State<muscatscreen> createState() => _muscatscreenState();
}

class _muscatscreenState extends State<muscatscreen> {
  List<Court> castleList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDBMain((List<Court> list) {
      setState(() {
        castleList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MuscatList'),
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
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(court: court),
                            ),
                          ),
                          icon: Icon(Icons.map, color: Colors.deepPurple),
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
