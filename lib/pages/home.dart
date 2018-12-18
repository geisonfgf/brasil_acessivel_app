import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:brasil_acessivel_flutter/widgets/hamburguer_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _editingController = TextEditingController();
  GoogleMapController _mapController;
  bool _mapToogle = false;
  LatLng _mapPosition = LatLng(-22.34, -48.05);
  var _mapZoom = 4.0;

  Future _search(String query) async {

    setState(() {
      _mapToogle = false;
    });

    try{
      var results = await Geocoder.local.findAddressesFromQuery(query);
      setState(() {
        _mapZoom = 13.0;
        _mapPosition = LatLng(
            results.first.coordinates.latitude, results.first.coordinates.longitude
        );
        _mapToogle = true;
      });
    } catch(e) {
      _showErrorMessage();
    } finally {
      setState(() {
        _mapToogle = true;
      });
    }
  }

  _showErrorMessage() {
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Icon(Icons.error),
          ),
          Text(
              'Endereço não encontrado',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.purple,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currentLocation) {
      if(currentLocation == null) { return; }

      setState(() {
        _mapPosition = LatLng(
          currentLocation.latitude,
          currentLocation.longitude
        );
        _mapZoom = 13.0;
        _mapToogle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Brasil Acessível")),
      drawer: HamburguerMenu(),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: _mapToogle ?
              GoogleMap(
                onMapCreated: onMapCreated,
                options: GoogleMapOptions(
                    cameraPosition: CameraPosition(
                        target: _mapPosition,
                        zoom: _mapZoom
                    )
                ),
              ):
              Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.purple
                    )
                ),
              )
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            margin: const EdgeInsets.only(),
            child: Material(
              borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
              elevation: 2.0,
              child: Container(
                height: 45.0,
                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.search, color: Colors.purple),
                              hintText: "Busque em outro local",
                              border: InputBorder.none
                          ),
                          onSubmitted: _search,
                          controller: _editingController,
                        )
                    ),
                    Icon(Icons.mic, color: Colors.purple)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}