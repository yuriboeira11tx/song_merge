import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_merge/MusicaAtualController.dart';
import 'package:song_merge/bloc/listaMusicasBloc.dart';
import 'package:song_merge/model/Musica.dart';
import 'package:song_merge/widgets/ItemAtual.dart';
import 'package:song_merge/widgets/ItemMusica.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _buildItemAtual(MusicaAtualController musicaAtualController) {
    return ItemAtual(musicaAtualController);
  }

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
        Consumer<MusicaAtualController>(builder: (context, musicaAtualController, widget) {
          if (musicaAtualController.musicaAtual.titulo != "Sem Musica") {
            return _buildItemAtual(musicaAtualController);
          }

          return Center();
        })
      ],
    );
  }
}

class ListaMusicas extends StatefulWidget {
  @override
  _ListaMusicasState createState() => _ListaMusicasState();
}

class _ListaMusicasState extends State<ListaMusicas> {
  ListaMusicasBloc bloc = ListaMusicasBloc();

  @override
  void initState() {
    super.initState();
    bloc.buscarMusicas();
  }

  @override
  void dispose() {
    bloc.input.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.output,
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
            if (!snapshot.hasError && snapshot.hasData) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<Musica> _musicas = snapshot.data;

                    return ItemMusica(
                      _musicas[index].titulo,
                      _musicas[index].banda,
                      _musicas[index].logo,
                      _musicas[index].url,
                    );
                  },
                ),
                onRefresh: bloc.buscarMusicas,
                color: Colors.white,
                backgroundColor: Colors.black,
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
