import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:song_merge/model/Musica.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: ListaMusicas(),
          ),
        ),

        Card(
          elevation: 10.0,
          color: Colors.black,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text("Funk Sax", style: TextStyle(color: Colors.white),),
            subtitle: Text("Sla", style: TextStyle(color: Colors.white.withOpacity(0.5)),),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage("http://192.168.0.106/media/musicas/Wallpaper-05.png"),
              backgroundColor: Colors.transparent,
            ),
            trailing: Container(
              child: IconButton(
                icon: Icon(Icons.pause, color: Colors.white,),
                onPressed: () {
                  print("tocando");
                },
              ),
            ),
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
  String _urlBase = "http://192.168.0.106/musicas/";

  Future<List<Musica>> _recuperarMusicas() async {
    http.Response response = await http.get(_urlBase);
    var dadosJson = json.decode(response.body);

    List<Musica> musicas = List();

    for (var musica in dadosJson) {
      Musica m = Musica(musica['nome'], musica['banda'], musica['url'], musica['logo']);
      musicas.add(m);
    }

    return musicas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Musica>>(
      future: _recuperarMusicas(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (!snapshot.hasError) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List<Musica> _musicas = snapshot.data;

                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      title: Text(_musicas[index].titulo),
                      subtitle: Text(_musicas[index].banda),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(_musicas[index].logo),
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
            } else {
              print("erro ao recuperar musicas");
            }

            break;
        }

        return Center();
      },
    );
  }
}
