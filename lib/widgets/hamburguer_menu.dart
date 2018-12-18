import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:brasil_acessivel_flutter/pages/signin.dart';

class HamburguerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.cyan),
                  accountName: Text('Nome do usuário'),
                  accountEmail: Text('usuario@email.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_box, color: Colors.grey),
                  )
              )
          ),
          ListTile(
              title: Text('Efetuar login'),
              leading: new Icon(Icons.account_box),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => SignIn()
                )
                );
              }
          ),
          Divider(),
          ListTile(
            title: Text('Cadastrar locais acessíveis'),
            leading: new Icon(Icons.map),
          ),
          Divider(),
          ListTile(
            title: Text('Contribua com o projeto'),
            leading: new Icon(Icons.attach_money),
          ),
          Divider(),
        ],
      ),
    );
  }
}