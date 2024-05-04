import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/court_model.dart';

class MapScreen extends StatefulWidget {
  final Court court;

  const MapScreen({Key? key, required this.court}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Court Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.court.courtData!.latitude!, widget.court.courtData!.longitude!),
          zoom: 5.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('courtMarker'),
            position: LatLng(widget.court.courtData!.latitude!, widget.court.courtData!.longitude!),
            infoWindow: InfoWindow(title: widget.court.courtData!.name!),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
