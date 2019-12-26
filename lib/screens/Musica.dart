import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:song_merge/model/Musica.dart' as music;
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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

  Future buscarMusicas() async {
    http.Response response = await http.get("http://192.168.0.106/musicas/");
    List dados = json.decode(utf8.decode(response.bodyBytes));
    musicas = dados.map((json) => music.Musica.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    buscarMusicas();
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
              _seekBar(),
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
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.fast_rewind),
                      onTap: () {
                        for (var i = 0; i < musicas.length; i++) {
                          if (musicas[i].titulo == musicaAtualController.musicaAtual.titulo) {
                            setState(() {
                              musicaAtualIndex = i;
                            });
                          }
                        };

                        if ((musicaAtualIndex-1) >= 0) {
                          musicaAtualController.alterarMusicaAtual(
                            musicas[musicaAtualIndex-1].titulo,
                            musicas[musicaAtualIndex-1].banda,
                            musicas[musicaAtualIndex-1].logo,
                            musicas[musicaAtualIndex-1].url,
                          );

                          musicaAtualController.stop();
                          musicaAtualController.play();
                        }
                      },
                    ),
                    SizedBox(width: 120),
                    GestureDetector(
                      child: Icon(Icons.fast_forward),
                      onTap: () {
                        for (var i = 0; i < musicas.length; i++) {
                          if (musicas[i].titulo == musicaAtualController.musicaAtual.titulo) {
                            setState(() {
                              musicaAtualIndex = i;
                            });
                          }
                        };

                        if ((musicaAtualIndex+1) != musicas.length) {
                          musicaAtualController.alterarMusicaAtual(
                            musicas[musicaAtualIndex+1].titulo,
                            musicas[musicaAtualIndex+1].banda,
                            musicas[musicaAtualIndex+1].logo,
                            musicas[musicaAtualIndex+1].url,
                          );

                          musicaAtualController.stop();
                          musicaAtualController.play();
                        }
                      },
                    ),
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
        bottom: 0.4 * height,
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
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                musicaAtualController.musicaAtual.banda,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _seekBar() => Positioned(
        left: 0,
        right: 3,
        bottom: 0.25 * height,
        child: SleekCircularSlider(
          min: 0,
          max: 100,
          initialValue: 32,
          onChange: (double value) {},
          innerWidget: (value) => Container(),
          appearance: CircularSliderAppearance(
            startAngle: 0,
            angleRange: 180,
            size: width - 50,
            customWidths: CustomSliderWidths(
              progressBarWidth: 4.0,
              trackWidth: 4.0,
              handlerSize: 8.0,
            ),
            customColors: CustomSliderColors(
              progressBarColor: _dotColor,
              trackColor: Colors.grey,
              dotColor: _dotColor,
            ),
          ),
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
            image: NetworkImage(musicaAtualController.musicaAtual.logo),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
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
          ],
        ),
      );
}
