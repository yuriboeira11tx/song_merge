class Musica {
  String _titulo;
  String _url;

  Musica(this._titulo, this._url,);

  Musica.fromJson(Map<String, dynamic> json) {
    _titulo = json['nome'];
    _url = json['url'];
  }

  Map toJson() {
    return {
      "titulo": this._titulo,
      "url": this._url,
    };
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }
}
