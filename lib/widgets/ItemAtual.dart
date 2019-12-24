import 'package:flutter/material.dart';

class ItemAtual extends StatefulWidget {
  String _titulo;
  String _banda;
  String _logo;
  String _urlMusica;

  ItemAtual(this._titulo, this._banda, this._logo, this._urlMusica);

  @override
  _ItemAtualState createState() => _ItemAtualState();
}

class _ItemAtualState extends State<ItemAtual> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: Colors.black,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          widget._titulo,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget._banda,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(widget._logo),
          backgroundColor: Colors.transparent,
        ),
        trailing: Container(
          child: IconButton(
            icon: Icon(
              Icons.pause,
              color: Colors.white,
            ),
            onPressed: () {
              print("tocando");
            },
          ),
        ),
      ),
    );
  }
}
