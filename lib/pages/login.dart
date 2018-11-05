import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.greenAccent),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.redAccent),
                iconSize: 70.0,
                onPressed: () { Navigator.of(context).pop(); }
              ),
              Text("Home")
            ]
          )
        )
      )
    );
  }
}