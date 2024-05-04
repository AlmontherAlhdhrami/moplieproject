import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/court_model.dart';
import '../data/DatabaseHelper.dart';
import '../data/registrationpage.dart';
import 'CastleCreationUpdateScreen.dart';
import 'ImageDecoration.dart';
import 'appStyle.dart'; // Make sure appStyle.dart is updated with new styles as needed

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[300],
        elevation: 0,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(color: Colors.grey[300], fontSize: 18),
        button: TextStyle(color: Colors.white),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey[600],
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}

class CastleDetailScreen extends StatefulWidget {
  final Court court;
  const CastleDetailScreen({super.key, required this.court});

  @override
  State<CastleDetailScreen> createState() => _CastleDetailScreenState();
}

class _CastleDetailScreenState extends State<CastleDetailScreen> {
  int _ticketQuantity = 1;
  double _ticketPrice = 0, _runningCost = 0;

  @override
  Widget build(BuildContext context) {
    _ticketPrice = widget.court.courtData?.ticketPrice ?? 0.0;
    _runningCost = _ticketQuantity * _ticketPrice;

    return Theme(
      data: AppTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.court.courtData?.name ?? 'Castle Details'),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.message),
                      label: Text("Send SMS"),
                      onPressed: () => sendSMS("+96871745009", "Your SMS message here."),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.email),
                      label: Text("Send Email"),
                      onPressed: () => DatabaseHelper.sendEmail(
                          "asfz.2000@gmail.com",  // Recipient's email address
                          "about registration", // Email subject
                          "Hello, we are padle app how can we help you?", // Email body
                          context
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    ),
                  ]
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    widget.court.courtData?.imagePath != null
                        ? ImageDecoration(imagePath: widget.court.courtData!.imagePath!)
                        : const SizedBox(height: 200, child: Placeholder()),
                    Text("Name: ${widget.court.courtData?.name ?? 'N/A'}", style: TextStyle(fontSize: 50, color: Colors.white60)),
                    Text('Place: ${widget.court.courtData?.place ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1),
                    Text(
                      'Established: ${widget.court.courtData?.yearEstablished ?? 'N/A'}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).hintColor),
                    ),
                    Text(
                      'Ticket Price: \$${_ticketPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text('Running Cost: OMR ${_runningCost.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headline1),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                value: _ticketQuantity.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: _ticketQuantity.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _ticketQuantity = value.toInt();
                  });
                },
              ),
              _buildRatingBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.update),
                    label: Text("Update"),
                    onPressed: updateCastle,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text("Delete"),
                    onPressed: _deleteCastle,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.assignment),
                    label: Text("Register"),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(court: widget.court),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRatingBar() {
    return RatingBar.builder(
      initialRating: widget.court.courtData?.starRating ?? 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        setState(() {
          widget.court.courtData?.starRating = rating;
          DatabaseHelper.update(widget.court.key!, widget.court.courtData!, context);
        });
      },
    );
  }
  void sendSMS(String phoneNumber, String message) async {
    final Uri url = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {
          'body': message
        }
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to open SMS app."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void updateCastle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CastleCreationUpdateScreen(isUpdate: true, court: widget.court),
      ),
    );
  }

  void _deleteCastle() {
    String castleName = widget.court.courtData!.name!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete the castle $castleName?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () {
                DatabaseHelper.delete(widget.court.key!);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$castleName castle deleted')),
                );
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
