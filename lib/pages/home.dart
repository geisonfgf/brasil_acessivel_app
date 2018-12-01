import 'package:brasil_acessivel/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  var mapPosition = LocationService.brazilLocation;

  List<Address> results = [];

  bool isLoading = false;

  Future search() async {

    this.setState(() {
      this.isLoading = true;
    });

    try{
      var results = await Geocoder.local.findAddressesFromQuery("Porto Alegre RS");
      this.setState(() {
        this.results = results;
      });
    }
    catch(e) {
      print("Error occured: $e");
    }
    finally {
      this.setState(() {
        this.isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    LocationService.getGPSPosition().then((position) {
      if(position == null) { return; }

      this.setState((){
        mapPosition = LatLng(position.latitude, position.longitude);
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
              icon: Icon(Icons.account_circle),
              onPressed: () { Navigator.of(context).pushNamed("/login"); }
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {Navigator.of(context).pushNamed("/login");},
                    iconSize: 80.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Faça login'),
              trailing: new Icon(Icons.account_box),
            ),
            ListTile(
              title: Text('Contribua com o projeto'),
              trailing: new Icon(Icons.attach_money),
            ),
            Divider(),
            ListTile(
              title: Text('Fechar menu'),
              trailing: new Icon(Icons.close),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left:16.0, top: 7.0, bottom: 7.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Busque por lugares acessíveis...',
                  icon: Icon(Icons.search)
                ),
              ),
            ),
          ),
          Container(
            child: Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: mapPosition,
                  zoom: 4.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'])
                ],
              )
            )
          )
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