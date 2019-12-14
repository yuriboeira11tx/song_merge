class Musica {
  String _titulo;
  String _banda;

  Musica(this._titulo, this._banda);

  String get banda => _banda;

  set banda(String value) {
    _banda = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }
}