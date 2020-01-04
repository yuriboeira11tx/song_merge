import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_merge/MusicaAtualController.dart';

class ItemMusica extends StatefulWidget {
  String _titulo;
  String _urlMusica;

  ItemMusica(this._titulo, this._urlMusica);

  @override
  _ItemMusicaState createState() => _ItemMusicaState();
}

class _ItemMusicaState extends State<ItemMusica> {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> play(urlMusica) async {
    await audioPlayer.stop();
    await audioPlayer.play(urlMusica);
  }

  _buildItemAtual() {
    Provider.of<MusicaAtualController>(context).alterarMusicaAtual(
        widget._titulo,
        widget._urlMusica
    );

    play(widget._urlMusica);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(widget._titulo),
        trailing: Container(
          child: IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.black),
            onPressed: _buildItemAtual,
          ),
        ),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage("https://www.andrewwkmusic.com/wp-content/uploads/2014/05/No-album-art-itunes.jpg"),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

