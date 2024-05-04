import 'package:flutter/material.dart';
import 'package:moplieproject/data/DatabaseHelper.dart'; // Make sure the path is correct
import 'package:moplieproject/data/court_model.dart'; // Make sure the path is correct

class AddNewCourtDataToFirebase extends StatelessWidget {
  final nameController = TextEditingController();
  final imagePathController = TextEditingController();
  final placeController = TextEditingController();
  final ticketPrice = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final starRating = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  AddNewCourtDataToFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create New Castle',
      home: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.account_circle, color: Colors.green[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.green[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: imagePathController,
                    decoration: InputDecoration(
                      labelText: "Image Path",
                      prefixIcon: Icon(Icons.image, color: Colors.blue[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.blue[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: placeController,
                    decoration: InputDecoration(
                      labelText: "Place",
                      prefixIcon: Icon(Icons.place, color: Colors.red[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.red[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: ticketPrice,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Ticket Price",
                      prefixIcon: Icon(Icons.money, color: Colors.amber[800]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.amber[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: latitude,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Latitude",
                      prefixIcon: Icon(Icons.public, color: Colors.purple[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.purple[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: longitude,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Longitude",
                      prefixIcon: Icon(Icons.public, color: Colors.purple[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.purple[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: starRating,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Star Rating",
                      prefixIcon: Icon(Icons.star, color: Colors.orange[700]),
                      border: OutlineInputBorder(),
                      fillColor: Colors.orange[50],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      CourtData courtData = CourtData(
                        imagePathController.text,
                        nameController.text,
                        placeController.text,
                        double.parse(ticketPrice.text),
                        double.parse(latitude.text),
                        double.parse(longitude.text),
                        double.parse(starRating.text),
                      );
                      DatabaseHelper.addNew(courtData).then((_) {
                        _scaffoldMessengerKey.currentState?.showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Data saved successfully",
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }).catchError((error) {
                        _scaffoldMessengerKey.currentState?.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Failed to save data: $error",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            )
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.deepPurple, // text color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
