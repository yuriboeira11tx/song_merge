import 'package:flutter/material.dart';
import 'package:song_merge/model/Musica.dart';

List<Musica> _musicas;
String _url = "https://i.ytimg.com/vi/-EzURpTF5c8/maxresdefault.jpg";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _carregarMusicas() {
    _musicas = [];

    Musica _musica1 = Musica("train", "acdc");
    _musicas.add(_musica1);

    Musica _musica2 = Musica("californication", "red hot chilli");
    _musicas.add(_musica2);

    Musica _musica3 = Musica("ctulhu", "metalica");
    _musicas.add(_musica3);

    Musica _musica4 = Musica("hey jude", "the beatles");
    _musicas.add(_musica4);

    Musica _musica5 = Musica("Time", "Pink Floyd");
    _musicas.add(_musica5);
  }

  @override
  Widget build(BuildContext context) {
    _carregarMusicas();

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: ListaMusicas(),
          ),
        ),
      ],
    );
  }
}

class ListaMusicas extends StatefulWidget {
  @override
  _ListaMusicasState createState() => _ListaMusicasState();
}

class _ListaMusicasState extends State<ListaMusicas> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _musicas.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5.0,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(_musicas[index].titulo),
            subtitle: Text(_musicas[index].banda),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(_url),
              backgroundColor: Colors.transparent,
            ),
            trailing: Container(
              child: IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.black,),
                onPressed: () {
                  print("tocando: " + index.toString());
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
