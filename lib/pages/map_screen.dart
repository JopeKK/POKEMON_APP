import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String name;
  final double lat;
  final double lng;
  final String photo;

  const MapScreen({
    super.key,
    required this.name,
    required this.lat,
    required this.lng,
    required this.photo,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late final LatLng _initialPosition = LatLng(widget.lat, widget.lng);

  Uint8List? dataBytes;

  void imagePrep(String image) async {
    final request = await http.get(Uri.parse(image));
    Uint8List bytes = request.bodyBytes;

    setState(() {
      dataBytes = bytes;
    });
  }

  @override
  void initState() {
    imagePrep(widget.photo);
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        scrolledUnderElevation: 3,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 500,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 4.0,
                ),
                markers: {
                  if (dataBytes != null)
                    Marker(
                      markerId: MarkerId(widget.name),
                      position: _initialPosition,
                      infoWindow: InfoWindow(title: widget.name),
                      icon: BitmapDescriptor.bytes(
                        dataBytes!.buffer.asUint8List(),
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
