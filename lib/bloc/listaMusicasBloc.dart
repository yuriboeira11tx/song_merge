import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:song_merge/model/Musica.dart';
import 'package:path/path.dart' as path;

class ListaMusicasBloc {
  StreamController controller = StreamController();

  // entrada e saída do StreamController
  Sink get input => controller.sink;
  Stream get output => controller.stream;

  Future<void> buscarMusicas() async {
    var dir = await getExternalStorageDirectory();
    final local = new Directory("${dir.path}");
    List<FileSystemEntity> musicasFiles;
    List<Musica> musicas = List();
    musicasFiles = local.listSync(recursive: true, followLinks: false);

    for (var musica in musicasFiles) {
      Musica music = Musica(path.basename(musica.path), musica.path);
      musicas.add(music);
    }

    controller.add(musicas);
  }
}
