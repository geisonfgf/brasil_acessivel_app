import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brasil Acessível"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.search),
          )
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-23.681532, -46.875000),
          zoom: 12.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'])
        ],
      )
    );
  }
}