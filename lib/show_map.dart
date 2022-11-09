import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  final String latLng;
  const ShowMap({Key? key, required this.latLng}) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late final Completer<GoogleMapController> _controller = Completer();

  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(widget.latLng.split(',').first.trim()), double.parse(widget.latLng.split(',').last.trim())),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
