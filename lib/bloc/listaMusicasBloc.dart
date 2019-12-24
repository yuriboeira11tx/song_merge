import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:song_merge/model/Musica.dart';

class ListaMusicasBloc {
  String urlBase = "http://192.168.0.106/musicas/";
  StreamController controller = StreamController();

  // entrada e saída do StreamController
  Sink get input => controller.sink;
  Stream get output => controller.stream;

  Future buscarMusicas() async {
    http.Response response = await http.get(urlBase);
    List dados = json.decode(utf8.decode(response.bodyBytes));
    List<Musica> _musicas = dados.map((json) => Musica.fromJson(json)).toList();

    controller.add(_musicas);
  }
}