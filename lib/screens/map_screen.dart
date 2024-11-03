import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seminario_4/models/scan_model.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(initialPoint),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: mapType,
            initialCameraPosition: initialPoint,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationButtonEnabled: false,
          ),
          Positioned(
            bottom: 100,
            right: 5,
            child: FloatingActionButton(
              child: Icon(Icons.layers),
              onPressed: () {
                if (mapType == MapType.normal) {
                  mapType = MapType.satellite;
                } else {
                  mapType = MapType.normal;
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
