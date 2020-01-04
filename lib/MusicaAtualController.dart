import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/widgets.dart';
import 'package:song_merge/model/Musica.dart';

class MusicaAtualController extends ChangeNotifier {
  Musica musicaAtual = Musica("Sem Musica", "Sem Musica",);
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;

  alterarMusicaAtual(String titulo, String url) {
    this.musicaAtual.titulo = titulo;
    this.musicaAtual.url = url;

    notifyListeners();
  }

  Future<void> play() async {
    await audioPlayer.play(this.musicaAtual.url);
    audioPlayerState = AudioPlayerState.PLAYING;

    notifyListeners();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    audioPlayerState = AudioPlayerState.PAUSED;

    notifyListeners();
  }

  Future<void> stop() async {
    await audioPlayer.stop();

    notifyListeners();
  }
}
