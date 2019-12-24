import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:song_merge/screens/Home.dart';

class ItemMusica extends StatefulWidget {
  String _titulo;
  String _banda;
  String _logo;
  String _urlMusica;

  ItemMusica(this._titulo, this._banda, this._logo, this._urlMusica);

  @override
  _ItemMusicaState createState() => _ItemMusicaState();
}

class _ItemMusicaState extends State<ItemMusica> {
  AudioPlayer _audioPlayer = new AudioPlayer();
  bool _playing = false;

  Future<void> play(urlMusica) async {
    if (_playing) {
      stop();
    } else {
      await _audioPlayer.play(urlMusica);
    }

    setState(() {
      _playing = !_playing;
    });
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(widget._titulo),
        subtitle: Text(widget._banda),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(widget._logo),
          backgroundColor: Colors.transparent,
        ),
        trailing: Container(
          child: IconButton(
            icon: _playing ? Icon(Icons.pause, color: Colors.black) : Icon(Icons.play_arrow, color: Colors.black),
            onPressed: () {
              play(widget._urlMusica);
            },
          ),
        ),
      ),
    );
  }
}

