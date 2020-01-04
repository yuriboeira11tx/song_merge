import 'package:audioplayer/audioplayer.dart';
import 'package:song_merge/model/Musica.dart' as music;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_merge/MusicaAtualController.dart';

class Musica extends StatefulWidget {
  @override
  _MusicaState createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  final Color _dotColor = Color(0xff040602);
  double height, width;
  List<music.Musica> musicas;
  int musicaAtualIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Consumer<MusicaAtualController>(
      builder: (context, musicaAtualController, widget) {
        return Container(
          padding: EdgeInsets.only(top: 15),
          child: Stack(
            children: <Widget>[
              _albumArt(musicaAtualController),
              _musicTitle(musicaAtualController),
              _bottomButtons(musicaAtualController),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomButtons(MusicaAtualController musicaAtualController) =>
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 0.22 * height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.shuffle),
                      Expanded(
                        child: _musicControls(musicaAtualController),
                      ),
                      Icon(Icons.repeat),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _musicControls(MusicaAtualController musicaAtualController) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.fast_rewind),
                    SizedBox(width: 120),
                    Icon(Icons.fast_forward)
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            child: CircleAvatar(
                radius: 35,
                backgroundColor: _dotColor,
                foregroundColor: Colors.white,
                child: musicaAtualController.audioPlayerState ==
                        AudioPlayerState.PLAYING
                    ? Icon(Icons.pause)
                    : Icon(Icons.play_arrow)),
            onTap: () {
              if (musicaAtualController.audioPlayerState ==
                  AudioPlayerState.PLAYING) {
                musicaAtualController.pause();
              } else {
                musicaAtualController.play();
              }
            },
          ),
        ],
      );

  Widget _musicTitle(MusicaAtualController musicaAtualController) => Positioned(
        bottom: 0.45 * height,
        left: 55,
        right: 55,
        child: Column(
          children: <Widget>[
            Text(musicaAtualController.musicaAtual.titulo,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 2.0,
                        color: Colors.black,
                      ),
                    ])),
          ],
        ),
      );

  Widget _albumArt(MusicaAtualController musicaAtualController) => Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(
          left: 50,
          right: 50,
          bottom: 0.3 * height,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://www.andrewwkmusic.com/wp-content/uploads/2014/05/No-album-art-itunes.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular((width - 100) / 2),
              bottomRight: Radius.circular((width - 100) / 2),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 8),
                  blurRadius: 5.0)
            ]),
      );
}
