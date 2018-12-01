import 'package:brasil_acessivel/layout/widgets/search_widget.dart';
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
              title: Text('Faça login'),
              trailing: new Icon(Icons.account_box),
            ),
            ListTile(
              title: Text('Cadastre um novo local ou estabelecimento'),
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
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
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
      floatingActionButton: SearchWidget()
    );
  }
}