//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_showcase/pages/home.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Cadastre-se')),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Informe seu nome';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Nome'
                ),
                onSaved: (input) => _name = input,
              ),
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Informe seu email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Informe uma senha com mais de 6 caracteres';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Senha'
                ),
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Efetuar Login'),
              ),
            ],
          )
      ),
    );
  }

  void signIn() async {
    /*if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }catch(e){
        print(e.message);
      }
    }*/
  }
}
