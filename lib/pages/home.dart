import 'package:brasil_acessivel/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  var _initialMapPosition = LocationService.brazilLocation;

  @override
  void initState() {
    super.initState();
    LocationService.getGPSPosition().then((position) {
      if(position == null) { return; }

      this.setState((){
        _initialMapPosition = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brasil Acessível"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () { debugPrint('App Bar Search Button Clicked'); }
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () { Navigator.of(context).pushNamed("/login"); }
            ),
          )
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _initialMapPosition,
          zoom: 4.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'])
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () { Navigator.of(context).pushNamed("/login"); },
        ),
      ),
    );
  }
}