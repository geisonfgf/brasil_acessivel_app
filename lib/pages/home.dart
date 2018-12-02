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

  final TextEditingController editingController = TextEditingController();

  var _mapPosition = LocationService.brazilLocation;
  var _mapZoom = 4.0;

  List<Address> results = [];

  bool isLoading = false;

  Future search(String query) async {

    setState(() {
      isLoading = true;
    });

    try{
      var results = await Geocoder.local.findAddressesFromQuery(query);
      setState(() {
        results = results;
        _mapZoom = 13.0;
        _mapPosition = LatLng(
          results.first.coordinates.latitude, results.first.coordinates.longitude
        );
        isLoading = false;
      });
    } catch(e) {
      print("Error occured: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    LocationService.getGPSPosition().then((position) {
      if(position == null) { return; }

      setState((){
        _mapPosition = LatLng(position.latitude, position.longitude);
        _mapZoom = 13.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Brasil Acessível")),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.lime),
                accountName: Text('Nome do usuário'),
                accountEmail: Text('usuario@email.com'),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Text("G"),
                )
              )
            ),
            ListTile(
              title: Text('Efetuar login'),
              trailing: new Icon(Icons.account_box),
              onTap: () { Navigator.of(context).pushNamed('/login'); }
            ),
            ListTile(
              title: Text('Cadastrar locais acessíveis'),
              trailing: new Icon(Icons.map),
            ),
            ListTile(
              title: Text('Contribua com o projeto'),
              trailing: new Icon(Icons.attach_money),
            ),
            Divider(),
            ListTile(
              title: Text('Fechar menu'),
              trailing: new Icon(Icons.close),
              onTap: () { Navigator.of(context).pop(); }
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            key: UniqueKey(),
            child: Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: _mapPosition,
                  zoom: _mapZoom,
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
      floatingActionButton: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 40.0, right: 10.0, top: 120.0),
        margin: const EdgeInsets.only(),
        child: Material(
          borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
          elevation: 2.0,
          child: Container(
            height: 45.0,
            margin: EdgeInsets.only(left: 15.0,right: 15.0),
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
                      onSubmitted: searchPlaces,
                      controller: editingController,
                    )
                ),
                Icon(Icons.mic, color: Colors.purple)
              ],
            ),
          ),
        ),
      )
    );
  }

  void searchPlaces(query){
    search(query);
  }
}