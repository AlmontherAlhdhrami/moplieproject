import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../data/court_model.dart';
import '../data/DatabaseHelper.dart';
import 'CastleCreationUpdateScreen.dart';
import 'ImageDecoration.dart';
import 'appStyle.dart'; // Make sure appStyle.dart is updated with new styles as needed

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueGrey[800],
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
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
                    Text("Name: ${widget.court.courtData?.name ?? 'N/A'}", style: Theme.of(context).textTheme.headline1),
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
                    icon: Icon(Icons.arrow_back),
                    label: Text("Back"),
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[300]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
