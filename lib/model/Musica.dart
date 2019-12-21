class Musica {
  String _titulo;
  String _banda;
  String _url;
  String _logo;

  Musica(this._titulo, this._banda, this._url, this._logo);

  Musica.fromJson(Map<String, dynamic> json) {
    _titulo = json['nome'];
    _banda = json['banda'];
    _url = json['url'];
    _logo = json['logo'];
  }

  Map toJson() {
    return {
      "titulo": this._titulo,
      "banda": this._banda,
      "url": this._url,
      "logo": this._logo,
    };
  }

  String get logo => _logo;

  set logo(String value) {
    _logo = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get banda => _banda;

  set banda(String value) {
    _banda = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }
}
