import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_extractor/youtube_extractor.dart';

class WebViewYou extends StatefulWidget {
  @override
  _WebViewYouState createState() => _WebViewYouState();
}

class _WebViewYouState extends State<WebViewYou> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  YouTubeExtractor extractor = YouTubeExtractor();
  String _audioDownloadUrl;
  String _audioTitle;
  bool downloading = false;

  Future<void> _downloadMusica() async {
    Dio dio = Dio();
    
    try {
      var dir = await getExternalStorageDirectory();

      await dio.download(_audioDownloadUrl, "${dir.path}/$_audioTitle.mp3", onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          print(((rec / total) * 100).toStringAsFixed(0) + "%");
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
    });
  }

  _getMusica() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context, controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            child: !downloading ? Icon(Icons.file_download) : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            onPressed: () async {
              var url = await controller.data.currentUrl();
              var title = await controller.data.getTitle();
              
              if (url.contains("https://m.youtube.com/watch?v=")) {
                String musicaId = url.replaceAll("https://m.youtube.com/watch?v=", "");
                var audioUrlInfo = await extractor.getMediaStreamsAsync(musicaId);
              
                setState(() {
                   _audioDownloadUrl = audioUrlInfo.audio.first.url;
                   _audioTitle = title;
                });

                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Baixando..."),));
                _downloadMusica();
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Você não pode baixar a página inicial")));
              }
            },
          );
        }

        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://m.youtube.com",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: _getMusica(),
    );
  }
}