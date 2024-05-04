import 'package:flutter/material.dart';
import '../data/DatabaseHelper.dart';
import '../data/court_model.dart';
import '../main.dart';

class CastleCreationUpdateScreen extends StatefulWidget {
  final bool isUpdate;
  final Court? court;

  const CastleCreationUpdateScreen(
      {super.key, required this.isUpdate, this.court});

  @override
  State<CastleCreationUpdateScreen> createState() =>
      _CastleCreationUpdateScreenState();
}

class _CastleCreationUpdateScreenState
    extends State<CastleCreationUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _placeController = TextEditingController();
  final _establishedController = TextEditingController();
  final _imageController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.court != null) {
      // Pre-fill form fields if isUpdate is true and castle is provided
      _nameController.text = widget.court!.courtData?.name ?? '';
      _placeController.text = widget.court!.courtData?.place ?? '';
      _establishedController.text =
      _imageController.text = widget.court!.courtData?.imagePath ?? '';
      _ticketPriceController.text =
          widget.court!.courtData?.ticketPrice.toString() ?? '';
      _latitudeController.text =
          widget.court!.courtData?.latitude.toString() ?? '';
      _longitudeController.text =
          widget.court!.courtData?.longitude.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Castle")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Castle Name',
                prefixIcon: Icon(Icons.castle),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter castle name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _establishedController,
              decoration: const InputDecoration(
                labelText: 'Year Established',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the year the castle was established';
                }
                if (int.tryParse(value) == null ||
                    (int.tryParse(value)!) <= 0) {
                  return 'Please enter a valid year';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                prefixIcon: Icon(Icons.image),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ticketPriceController,
              decoration: const InputDecoration(
                labelText: 'Ticket Price',
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a ticket price';
                }
                if ((double.tryParse(value)!) <= 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            // Latitude TextFormField
            TextFormField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: 'Latitude',
                prefixIcon: Icon(Icons.map),
              ),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the latitude';
                }

                return null;
              },
            ),

            // Longitude TextFormField
            TextFormField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Longitude',
                prefixIcon: Icon(Icons.map),
              ),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the longitude';
                }

                return null;
              },
            ),
            ElevatedButton(
                onPressed: _submitForm,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.update),
                    SizedBox(width: 8,),
                    Text("Submit")],
                ))
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      CourtData castleData = CourtData(
        _imageController.text,
        _nameController.text,
        _placeController.text,

        double.tryParse(_ticketPriceController.text),
        double.tryParse(_latitudeController.text),
        double.tryParse(_longitudeController.text),
        0.0,
      );

      if (widget.isUpdate) {
        // Update the existing castle
        DatabaseHelper.update(
            widget.court!.key!, castleData, context);
      } else {
        // Add a new castle
        DatabaseHelper.addNew(castleData);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );

      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Castle added successfully!')),
      );*/

      //Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _placeController.dispose();
    _establishedController.dispose();
    _imageController.dispose();
    _ticketPriceController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}
