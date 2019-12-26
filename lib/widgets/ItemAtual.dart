import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:song_merge/MusicaAtualController.dart';

class ItemAtual extends StatefulWidget {
  MusicaAtualController musicaAtualController;

  ItemAtual(this.musicaAtualController);

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
          widget.musicaAtualController.musicaAtual.titulo,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.musicaAtualController.musicaAtual.banda,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(widget.musicaAtualController.musicaAtual.logo),
          backgroundColor: Colors.transparent,
        ),
        trailing: Container(
          child: IconButton(
            icon: widget.musicaAtualController.audioPlayerState == AudioPlayerState.PLAYING ? Icon(Icons.pause, color: Colors.white,) : Icon(Icons.play_arrow, color: Colors.white,),
            onPressed: () {
              if (widget.musicaAtualController.audioPlayerState == AudioPlayerState.PLAYING) {
                widget.musicaAtualController.pause();
              } else {
                widget.musicaAtualController.play();
              }
            },
          ),
        ),
      ),
    );
  }
}
