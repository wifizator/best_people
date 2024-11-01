import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Persondetails extends StatelessWidget {
  const Persondetails(
      {super.key,
      this.imgUrl,
      this.firstName,
      this.familyName,
      this.location,
      this.rating});

  final imgUrl;
  final firstName;
  final familyName;
  final location;
  final rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${firstName} ${familyName}'),
        actions: [],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: [
              imgUrl == null
                  ? Image.network(imgUrl)
                  : Icon(Icons.account_circle_outlined),
              Text('${firstName} ${familyName}'),
              Text(location),
              Text(rating),
              // const Text('Description'),
              // const Text('Ocupation'),
              // const Text('Reviews'),
              Expanded(
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(46, 25), //center map to romania
                    initialZoom: 9.2,
                  ),
                  children: [
                    TileLayer(
                      // Display map tiles from any source
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                      userAgentPackageName: 'com.example.app',
                      // And many more recommended properties!
                    ),
                    RichAttributionWidget(
                      // Include a stylish prebuilt attribution widget that meets all requirments
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => print('tapped map'), // (external)
                        ),
                        // Also add images...
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
