import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner/theme/global_themes.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    MapType mapType = MapType.normal;
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;
    final CameraPosition punto_inicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    //markers
    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId("geo-location"),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),

        backgroundColor: GlobalThemes.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 50),
                ),
              );
            },
          ),
        ],
      ),

      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: punto_inicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
