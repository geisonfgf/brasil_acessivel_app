import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget{

  final TextEditingController editingController = TextEditingController();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left: 40.0, right: 10.0, top: 140.0),
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
                      hintText: "Busque por lugares ou estabelecimentos",
                      border: InputBorder.none
                    ),
                    onSubmitted: onSubmitted,
                    controller: editingController,
                  )
              ),
              Icon(Icons.mic, color: Colors.purple)
            ],
          ),
        ),
      ),
    );
  }

  onSubmitted(query){
    //TODO: implement the use of query
  }
}
